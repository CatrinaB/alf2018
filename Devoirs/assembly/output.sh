#!/bin/bash

for folder in verify/alf/*
do
	rm $folder/*.out
	rm $folder/*.json
	rm $folder/*.wat
	rm $folder/*.wasm
done

for folder in verify/alf/*
do
	for file in $folder/*.alf
	do
		echo $file
		node main.js $file
	done
done

cd verify 

for folder in alf/*
do
	for file in $folder/*.alf
	do
		echo $file
		keyboardfile="$file".in
		if [ ! -f $keyboardfile ]; then keyboardfile="empty.in"; fi
		./run_asm.sh "$file".wat "$keyboardfile" "$file".wasm.out
	done
done

cd ..