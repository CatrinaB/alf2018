#!/bin/bash

mkdir -p output
rm -rf output/*

POINTS=0
PIXEL=100

errorslist=$1/errors.out
rm -f $errorslist

cd "$1"

if [ -d node_modules ];
then
	echo 'Please delete the node_modules folder from your homework archive'
elif [ ! -f package.json ];
then
	echo 'The package.json file is missing'
	echo 'Please add a package.json file to you homework archive.'
elif ! npm install;
then
	echo 'npm install fail, please verify that the package.json file information'
else

	MAIN=`node verify/startup.js | cut -d ';' -f 1`
	AUTHOR=`node verify/startup.js | cut -d ';' -f 2`

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

		# for file in calculator/*.a
		# do
		# 	head -n 1 $file | cut -d ';' -f 1
		# 	P=`head -n 1 $file | cut -d ';' -f 2`
		# 	if [ $failed == 0 ] || ! (echo $file | grep bonus &> /dev/null);
		# 	then
		# 		# STANDARDIFS=$IFS
		# 		IFS=$'\n'
		# 		for item in `tail -n +2 $file `;
		# 		do
		# 			output=`echo $item | cut -d ';' -f 1`
		# 			title=`echo $item | cut -d ';' -f 2`
		# 			input=`echo $item | cut -d ';' -f 3`
		# 			# echo $output
		# 			# inputfile=`pwd`/"$file"
		# 			outputfile=output/`basename "$file"`_"$output".out
		# 			originalfile="$file"_"$output".out
		# 			errorsfile=output/`basename "$file"`_"$output".err
		# 			# title=`head -n 1 "$file"`
		# 			# if [ `echo -n "$title" | wc -c` -eq 0 ];
		# 			# then
		# 			# 	title=`basename $file`
		# 			# fi
		# 			# cat $inputfile | tail -1
		# 			unset IFS
		# 			node "$1/$MAIN" `echo $input` > homeworkoutput
		# 			head -8 homeworkoutput > "$outputfile"
		# 			tail -n +9 homeworkoutput | sed "s/ *//" | sort >> "$outputfile"
		# 			rm homeworkoutput
		# 			strtitle="Verifying $title"
		# 			printf '%s' "$strtitle"
		# 			pad=$(printf '%0.1s' "."{1..60})
		# 			padlength=65
		# 			sed "s/ALF/$AUTHOR/" "$originalfile" | sed "s/ ---/ `sed s/./-/g <<< $AUTHOR`/" | sed "s/ ___/ `sed s/./_/g <<< $AUTHOR`/" > original
		# 			if diff --side-by-side --suppress-common-lines --ignore-space-change original "$outputfile" &> "$errorsfile"
		# 			then
		# 				str="ok (""$P""p)"
		# 				passed=$(($passed+1))
		# 				POINTS=$(($POINTS+$P))
		# 			else
		# 				str="error (0p)"
		# 				failed=$(($failed+1))
		# 				echo "--------------" >> $errorslist 
		# 				echo $strtitle >> $errorslist
		# 				head -10 "$errorsfile" >> $errorslist
		# 			fi
		# 			rm original
		# 			total=$(($total+1))
		# 			printf '%*.*s' 0 $((padlength - ${#strtitle} - ${#str} )) "$pad"
		# 			printf '%s\n' "$str"
		# 		done
		# 		unset IFS 
		# 	else
		# 		echo "Not verifying bonus, you have $failed failed tests"
		# 	fi
		# done
		for folder in design/*
		do
			if [ -d $folder ];
			then
				if [ -f "$folder"/run.txt ];
				then
					echo `head -n 1 "$folder"/run.txt`
					P=`head -n 2 "$folder"/run.txt | tail -n 1`
				else
					echo `basename $folder`
					P=10
				fi
				if [ $failed == 0 ] || ! (echo $folder | grep bonus &> /dev/null);
				then
					for file in "$folder"/*.dsn
					do
						inputfile=`pwd`/"$file"
						outputfile=output/`basename "$file"`.out
						outputsvgfile=output/`basename "$file"`.svg
						originalfile="$file.out"
						originalsvgfile="$file.svg"
						errorsfile=output/`basename "$file"`.err
						reportfile=output/`basename "$file"`.report
						title=`head -n 1 "$file" | grep '&' | cut -d '&' -f 2`
						if [ `echo -n "$title" | wc -c` -eq 0 ];
						then
							title=`basename $file`
						fi
						node "$1/$MAIN" "$inputfile" "$outputsvgfile" > "$outputfile"
						strtitle="Verifying $title"
						printf '%s' "$strtitle"
						pad=$(printf '%0.1s' "."{1..60})
						padlength=65
						compare -verbose -metric AE "$originalsvgfile" "$outputsvgfile" > /dev/null 2> "$reportfile" - 
						tail -n 5 "$reportfile" > "$reportfile.tmp"
						mv "$reportfile.tmp" "$reportfile"
						red_pixels=`cat "$reportfile" | grep red | cut -d ":" -f 2`
						green_pixels=`cat "$reportfile" | grep green | cut -d ":" -f 2`
						blue_pixels=`cat "$reportfile" | grep blue | cut -d ":" -f 2`
						alpha_pixels=`cat "$reportfile" | grep alpha | cut -d ":" -f 2`
						all_pixels=`cat "$reportfile" | grep all | cut -d ":" -f 2`
						# echo $all_pixels
						if [ "$all_pixels" -ne "" -a "$all_pixels" -le "$PIXEL" ];
						then
							if diff --ignore-space-change --side-by-side --suppress-common-lines "$originalfile" "$outputfile" &> "$errorsfile"
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
						else
							str="error (0p)"
							failed=$(($failed+1))
							echo "--------------" >> $errorslist 
							echo $strtitle >> $errorslist
							if [ "$all_pixels" -ne "" ];
							then
								echo "Pixels that are different" $(head -10 "$reportfile") >> $errorslist
							else
								echo "Your SVG file has errors" >> $errorslist
							fi
						fi
						total=$(($total+1))
						printf '%*.*s' 0 $((padlength - ${#strtitle} - ${#str} )) "$pad"
						printf '%s\n' "$str"
					done
				else
					echo "Not verifying bonus, you have $failed failed tests"
				fi
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