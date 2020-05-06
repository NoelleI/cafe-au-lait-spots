#
# BASH Script checks for duplicates in image library
#
# author: Takis Zourntos
#

#!/bin/bash

search_path="images" # directory which contains the files
imgfileprefix="image_" # all image files begin with this string
fileset=$(ls $search_path/$imgfileprefix*) # complete set of files


# check for diffs amongst all files
results_file="result_filename_comparison.txt"; echo "The following files have identical names/designations:" > $results_file
for x in $fileset
do
	fullfilename_x=$(basename -- "$x")
	extension_x="${fullfilename_x##*.}"
	filename_x="${fullfilename_x%.*}"
	for y in $fileset
	do
		if [ "$x" != "$y" ]; then # don't compare the file to itself
			fullfilename_y=$(basename -- "$y")
			extension_y="${fullfilename_y##*.}"
			filename_y="${fullfilename_y%.*}"
			if [ "$filename_x" == "$filename_y" ]; then
  				echo "files $x and $y" >> $results_file
			fi
		fi
	done
done

# exit normally
exit 0
