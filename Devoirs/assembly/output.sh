#!/bin/bash

for folder in verify/alfy/*
do
	for file in $folder/*.alf
	do
		echo $file
		node main.js $file
	done
done

# cd verify 

# for folder in alfy/*
# do
# 	for file in $folder/*.alfy
# 	do
# 		echo $file
# 		keyboardfile="$file".in
# 		if [ ! -f $keyboardfile ]; then keyboardfile="empty.in"; fi
# 		./run_asm.sh "$file".asm "$keyboardfile" "$file".asm.out
# 	done
# done

# cd ..