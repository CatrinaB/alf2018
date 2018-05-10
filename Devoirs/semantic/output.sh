#!/bin/bash

for folder in verify/alf/*
do
	for file in $folder/*.alf
	do
		echo $file
		node main.js $file
	done
done
