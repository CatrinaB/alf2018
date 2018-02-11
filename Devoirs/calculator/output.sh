#!/bin/bash

IFS=';'

for file in verify/calculator/*.a
do
	echo $file
	tail -n +2 $file | while read output title input
	do
		IFS=' '
		echo $input
		node main.js `echo $input` > output 
		head -8 output > "$file"_"$output.out"
		tail -n +9 output | sort >> "$file"_"$output.out"
		rm output
		IFS=';'
	done
done
