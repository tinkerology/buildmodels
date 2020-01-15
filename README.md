# buildmodels
Bash script to build OpenSCAD models

# Overview
This script scans the current directory for .SCAD files and runs the OpenSCAD command line app to generate STL and PNG files for each model. If the .STL file is up to date compared to the .SCAD file, it will skip the file. STL and PNG files are generated in a subdirectory called STLS. If that subdirectory does not exist, it will be created.

# Usage
\> build_models.sh
> 

# Generating Multiple Models per .SCAD File
build_models.sh can generate multiple models per .SCAD file. 

Contact me on [Twitter @tinkerology](http://twitter.com/tinkerology)
