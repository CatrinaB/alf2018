#!/bin/bash

IFS=';'

for file in verify/calculator/*.a
do
	echo $file
	tail -n +2 $file | while read output title input
	do
		IFS=' '
		echo $input
		node main.js $input | sort > "$file"_"$output.out"
		IFS=';'
	done
done
