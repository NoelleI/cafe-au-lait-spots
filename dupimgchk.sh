#
# BASH Script checks for duplicates in image library
#
# author: Takis Zourntos
#

#!/bin/bash

search_path="." # directory which contains the files
imgfileprefix="image_" # all image files begin with this string
fileset=$(ls $search_path/$imgfileprefix*) # complete set of files

# create a temporary index file
temp_indx_filename="temporaneous227.dat"
if [ -e $temp_indx_filename ]; then
	rm $temp_indx_filename # remove the temporary file if it already exists
fi
indx=0  # our index variable
for x in $fileset
do
	let indx=indx+1	
	echo "$indx $x" >> $temp_indx_filename # create a line in the temporary file
done
number_of_files=$indx
declare -i number_of_files

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
