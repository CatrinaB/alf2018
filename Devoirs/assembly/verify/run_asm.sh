#!/bin/bash

echo -n > "$3"

while read inputstr
do
    echo $inputstr > "file.keyboard"
	was r "$1" < "file.keyboard" >> "$3"
done < "$2"

