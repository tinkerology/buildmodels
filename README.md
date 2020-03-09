# buildmodels
Bash script to build OpenSCAD models

# Overview
This script scans the current directory for .SCAD files and runs the OpenSCAD command line app to generate STL and PNG files for each model. If the .STL file is up to date compared to the .SCAD file, it will skip the file. STL and PNG files are generated in a subdirectory called STLS. If that subdirectory does not exist, it will be created.

Currently, there are no command line arguments. You can change the following parameters easily enough at the top of the script:
<pre>
START_MODEL=1
DETAIL=120
OUTPUT_DIR=./STLS
OPENSCAD="/c/Program Files/Openscad/openscad.exe"
</pre>

START_MODEL can be used to start generating at a particular model. This is very helpful when you keep adding models and don't want to re-run all the previous ones. Just remember to set it back to 1.

# OpenSCAD Code Changes

Add this at the top of your file:
<pre>
DETAIL=20;
MODEL_COUNT=4;
MODEL_NAMES=["ROUND","ROUND_SPACER","SQUARE","SQUARE_SPACER"];
$fn=DETAIL;
</pre>
MODEL_COUNT and MODEL_NAMES are only needed if you have more than one model to render. Set the values of those variables to match the models you will output. Note that all the model names need to be on one line to be found by the script.

If you have more than one model to render, add code like this at the end to render all the submodels:
<pre>
MODELNUM=1;
if ( MODELNUM == 1)
    drawRoundBracket(DOOR_MIRROR_DATA);
else if ( MODELNUM == 2)
    drawRoundBracket(DOOR_MIRROR_SPACER_DATA);
</pre>
Otherwise, just output the single model that you want to generate an STL for.

# Usage
<pre>
build_models.sh
</pre>
Model files generated for Foo.SCAD if no MODEL_NAMES are specified:
<pre>
Foo_1_D120.stl
Foo_1_D120.jpg
Foo_2_D120.stl
Foo_3_D120.jpg
...
Foo_n_D120.stl
Foo_n_D120.jpg
</pre>

Model files generated for Foo.SCAD if MODEL_NAMES are specified:
<pre>
Foo_{NAME1}_D120.stl
Foo_{NAME1}_D120.jpg
Foo_{NAME2}_D120.stl
Foo_{NAME3}_D120.jpg
...
Foo_{Name-n}_D120.stl
Foo_{Name-n}_D120.jpg
</pre>

# Generated Files
All output files are output by default to a subdirectory named <code>STLs</code>. Currently only an STL and PNG file are output. If you want to output additional types of files, edit the build_model() function and add another call to $OPENSCAD with the appropriate parameters.

Contact me on [Twitter @tinkerology](http://twitter.com/tinkerology)
