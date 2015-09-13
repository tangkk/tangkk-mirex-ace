#!/bin/bash

listfile="$1"
if [ $# -gt 2 ]; then
	outputdir="$3"
else
	outputdir="$2"
fi

before="$(date +%s)"
echo "_____________________________________________________"
echo " "
echo Processing file "$listfile"
echo " "
matlab -nosplash -nodesktop -nojvm -wait -r mirexace_win\(\'"$listfile"\',\'"$outputdir"\',\'"21"\'\)
after="$(date +%s)"
elapsed_seconds="$(expr $after - $before)"
echo "  -->" time elapsed: $elapsed_seconds seconds