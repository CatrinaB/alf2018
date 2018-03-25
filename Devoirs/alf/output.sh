#!/bin/bash

for folder in verify/alf/*
do
	rm -f $folder/*.json
	for file in $folder/*.alf
	do
		echo $file
		node main.js $file
	done
done