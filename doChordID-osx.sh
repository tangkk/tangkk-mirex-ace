#!/bin/bash

listfile="$1"
if [ $# -gt 2 ]; then
	outputdir="$3"
else
	outputdir="$2"
fi

while read infile; do
	echo $infile
	if [ "$infile" -a -f "$infile" ]; then
		before="$(date +%s)"
		echo "_____________________________________________________"
		echo " "
		echo Processing file "$infile"
		echo " "
		outfile="$outputdir"/"`basename "$infile"`".txt
		matlab -nosplash -nodesktop -nojvm -r mirexace\(\'"$infile"\',\'"$outfile"\'\)
		after="$(date +%s)"
		elapsed_seconds="$(expr $after - $before)"
		echo "  -->" time elapsed: $elapsed_seconds seconds
		echo " "
	else if [ ! "$infile" ]; then echo ...; fi
	fi		
done < "$listfile"
