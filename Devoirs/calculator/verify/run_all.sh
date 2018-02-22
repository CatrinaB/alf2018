#!/bin/bash

mkdir -p output
rm -rf output/*

POINTS=0

errorslist=$1/errors.out
rm -f $errorslist

cd "$1"

if [ ! -f package.json ];
then
	echo 'The package.json file is missing'
	echo 'Please add a package.json file to you homework archive.'
elif ! npm install;
then
	echo 'npm install fail, please verify that the package.json file information'
else

	MAIN=`node verify/startup.js | cut -d ';' -f 1`
	AUTHOR=`node verify/startup.js | cut -d ';' -f 2`

	POINTS=$(($POINTS+10))

	echo Your main file is "$MAIN"
	echo The author is "$AUTHOR"

	passed=0
	failed=0
	total=0

	echo '{ "node":true, "esnext":true }' > .jshintrc
	if [ ! -f $MAIN ];
	then
		echo "Your main file, $MAIN, is not available"
		echo "Please verify that the name of your main file is right in package.json (\"main\":\"...\")"
	elif ! jshint *.js;
	then
		echo "Please review your code, you have jshint errors"
	else
		cd -

		POINTS=$(($POINTS+10))

		for file in calculator/*.a
		do
			head -n 1 $file | cut -d ';' -f 1
			P=`head -n 1 $file | cut -d ';' -f 2`
			if [ $failed == 0 ] || ! (echo $file | grep bonus &> /dev/null);
			then
				# STANDARDIFS=$IFS
				IFS=$'\n'
				for item in `tail -n +2 $file `;
				do
					output=`echo $item | cut -d ';' -f 1`
					title=`echo $item | cut -d ';' -f 2`
					input=`echo $item | cut -d ';' -f 3`
					# echo $output
					# inputfile=`pwd`/"$file"
					outputfile=output/`basename "$file"`_"$output".out
					originalfile="$file"_"$output".out
					errorsfile=output/`basename "$file"`_"$output".err
					# title=`head -n 1 "$file"`
					# if [ `echo -n "$title" | wc -c` -eq 0 ];
					# then
					# 	title=`basename $file`
					# fi
					# cat $inputfile | tail -1
					unset IFS
					node "$1/$MAIN" `echo $input` > homeworkoutput
					head -8 homeworkoutput > "$outputfile"
					tail -n +9 homeworkoutput | sed "s/ *//" | sort >> "$outputfile"
					rm homeworkoutput
					strtitle="Verifying $title"
					printf '%s' "$strtitle"
					pad=$(printf '%0.1s' "."{1..60})
					padlength=65
					sed "s/ALF/$AUTHOR/" "$originalfile" | sed "s/ ---/ `sed s/./-/g <<< $AUTHOR`/" | sed "s/ ___/ `sed s/./_/g <<< $AUTHOR`/" > original
					if diff --side-by-side --suppress-common-lines original "$outputfile" &> "$errorsfile"
					then
						str="ok (""$P""p)"
						passed=$(($passed+1))
						POINTS=$(($POINTS+$P))
					else
						str="error (0p)"
						failed=$(($failed+1))
						echo "--------------" >> $errorslist 
						echo $strtitle >> $errorslist
						head -10 "$errorsfile" >> $errorslist
					fi
					rm original
					total=$(($total+1))
					printf '%*.*s' 0 $((padlength - ${#strtitle} - ${#str} )) "$pad"
					printf '%s\n' "$str"
				done
				unset IFS 
			else
				echo "Not verifying bonus, you have $failed failed tests"
			fi
		done	
	fi

	echo 'Tests: ' $passed '/' $total
	echo 'Points: '$POINTS
	echo 'Mark without penalties: '`echo $(($POINTS/3)) | sed 's/.$/.&/'`

	if [ "$passed" != "$total" ];
	then
		echo -e "Original file						      | Your file" 1>&2
		cat $errorslist 1>&2
	fi
fi