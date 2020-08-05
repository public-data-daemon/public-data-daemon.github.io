#!/bin/bash

if [ -z $EXTRACT_PATH ]; then
	echo 'you need to set a value for $EXTRACT_PATH and re-run.' > /dev/stderr
	exit 1
fi

datestamp=$(date +%Y-%m-%d)
csv_glob="*_$datestamp.csv"
todays_files="$EXTRACT_PATH/$csv_glob"

csv_dest='./data/boone-county-jail'
mkdir -p $csv_dest
cp $(ls $todays_files) $csv_dest

git add "$csv_dest/$csv_glob"
date > "$csv_dest/last_run.txt"
git add "$csv_dest/last_run.txt"
git commit -m 'data: run automated extract.'
git push origin
