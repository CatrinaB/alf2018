#!/bin/bash

for folder in verify/design/*
do
	for file in $folder/*.dsn
	do
		echo $file
		node main.js $file $file.svg > $file.out
	done
done

