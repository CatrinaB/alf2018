#!/bin/bash

echo -n > "$3"

../node_modules/.bin/was "$1" -o "$1".wasm

while read inputstr
do
    echo $inputstr > "file.keyboard"
	../node_modules/.bin/was r "$1".wasm < "file.keyboard" >> "$3"
	echo >> "$3"
done < "$2"

