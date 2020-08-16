#!/bin/bash

OPENSCAD="/c/Program Files/Openscad/openscad.exe"
RENDER_SCAD=render_stl.scad

# Command line options
OUTPUT_DIR=./Renders

# Params:
# 1: STL file name
# 2: PNG file base name
render_model() {
    echo Building model for $1 to $2
    # See if the code or detail level has changed
    if [ "$1" -nt "$2.png" ]
    then
        # Generate the PNG
        echo "   Starting: " `date`
        "$OPENSCAD" $RENDER_SCAD --imgsize=1024,1024 --render -D STL_FILE_NAME=\"$1\" -o $2.png
        echo "   Done: " `date`
    else
        echo "   PNG file up to date"
    fi
}


# Make sure the output directory exists
if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir $OUTPUT_DIR
fi

echo "import(STL_FILE_NAME, convexity=3);" > $RENDER_SCAD

# Generate models for all the SCAD files in the directory
for f in *.stl
do
    output_name=`echo $f | awk -F.stl '{print $1}'`

    render_model $f $OUTPUT_DIR/$output_name
done
