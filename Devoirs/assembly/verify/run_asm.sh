#!/bin/bash

echo -n > "$3"

while read inputstr
do
    echo $inputstr > "file.keyboard"
	java -classpath ../CPUSim4.0.9:../CPUSim4.0.9/richtextfx-fat-0.6.10.jar cpusim.Main -m ../alf_computer32.cpu -t "$1" -c < "file.keyboard" >> "$3"
done < "$2"

