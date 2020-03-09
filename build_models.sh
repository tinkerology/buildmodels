#!/bin/bash

OPENSCAD="/c/Program Files/Openscad/openscad.exe"

# Command line options
START_MODEL=50
IGNORE_SCAD_CHANGES=1
DETAIL=120
OUTPUT_DIR=./STLS

build_model() {
    echo Building model for $1 to $4
    # See if the code or detail level has changed
    if [ "$1" -nt "$4.stl" ]
    then
        # Generate the STL
        echo "   Starting: " `date`
        "$OPENSCAD" $1 -D MODELNUM=$2 -D DETAIL=$3 -o $4.stl
        "$OPENSCAD" $1 --imgsize=1024,1024 --render -D MODELNUM=$2 -D DETAIL=$3 -o $4.png
        echo "   Done: " `date`
    else
        echo "   STL file up to date"
    fi
}

build_models() {
    output_name=`echo $1 | awk -F.scad '{print $1}'`

    # Figure out how many models there are
    model_count=`grep MODEL_COUNT $1 | awk -F= '{print $2}' | awk -F\; '{print $1}'`
    if [ "$model_count" == "" ];
    then
        model_count=1;
    fi

    # Figure out the model names
    model_names=`grep MODEL_NAMES $1 | awk -F[ '{print $2}' | awk -F] '{print $1}'`
    if [ "$model_names" == "" ];
    then
        model_names="";
    fi

    # Render each model with either an index or name suffix
    for (( counter=$START_MODEL; counter<=$model_count; counter++ ))
    do
        model_name=`echo $model_names | awk -F, -v ctr="$counter" '{print $ctr}'`
        model_name=`echo $model_name | awk -F\" '{print $2}'`
        if [ "$model_name" == "" ];
        then
            model_name=$counter
        fi

        # Put together the file output file name
        output_path="$OUTPUT_DIR""/"$output_name""_""$model_name""_D"$DETAIL"

        # Create the STL file and any other files like previews 
        build_model $1 $counter $DETAIL $output_path
    done
}

# Make sure the output directory exists
if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir $OUTPUT_DIR
fi

# Generate models for all the SCAD files in the directory
for f in *.scad
do
    build_models $f
done
