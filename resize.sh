#!/bin/bash
#
# Resize and/or convert all files from a given directory to an output directory with a custom resize factor.
#
# Author: Jose Martinez Gonzalez (Tunnel1337)
#

inputFolder=$1
factor=$2
format=$3
outputFolder=$4

#Check if given arguments are exactly 4
if [ $# -ne 4 ]
	then echo
	echo "usage:"
	echo "${0} <input folder> <factor> <format> <output folder>"
	echo
	echo "Example:"
	echo "${0} my_pictures/ 50 gif my_new_pictures/"
	echo
	echo "This program resizes and/or converts all images from a given directory to an output directory with a custom resize factor."
	echo
	echo "PLEASE NOTE:"
        echo "You will need ImageMagick installed to run this script."
	echo "This script works currently only for \"jpg\", \"png\" and \"gif\" formats."
        echo
	exit 1
fi

# Create output folder
$(cp -r $inputFolder $outputFolder)

# Find all files
data=$(find $outputFolder -name "*.png" && find $outputFolder -name "*.gif" && find $outputFolder -name "*.jpg")

# Number of found files
fileNumber=$(find $outputFolder -name "*.png" && find $outputFolder -name "*.gif" && find $outputFolder -name "*.jpg" | wc -w)

# Loop over all files
for line in $data
	do
	tmpFile=$line
	length=${#tmpFile}
	file=${tmpFile:0:$length-4}
        origFormat=${tmpFile:$length-3:$length}

	echo "Resizing ${tmpFile}"
        # the actual resize method
	$(convert $tmpFile -resize $factor% $file.$format)
	
        # Delete old unconverted file
        if [ $origFormat != $format ]
            then $(rm $tmpFile)
        fi
done

echo
echo "Done"
exit 0
