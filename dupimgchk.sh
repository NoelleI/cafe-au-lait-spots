#
# BASH Script checks for duplicates in image library
#
# author: Takis Zourntos
#

#!/bin/bash

search_path="." # directory which contains the files
imgfileprefix="image_" # all image files begin with this string
fileset=$(ls $search_path/$imgfileprefix*) # complete set of files

# check for diffs amongst all files
results_file="result_image_comparison.txt"; echo "The following files are identical:" > $results_file
for x in $fileset
do
	nextfile=$x	# get the filename
	for y in $fileset
	do
		if [ "$x" != "$y" ]; then # don't compare the file to itself
			comparisonfile=$y	# get the filename
			chkstr=''
			chkstr=$(diff $nextfile $comparisonfile) # run a diff between the files
			if [ -z "$chkstr" ]; then
  				echo "files $nextfile and $comparisonfile" >> $results_file
			fi
		fi
	done
done

# exit normally
exit 0
