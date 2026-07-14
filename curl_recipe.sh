#!/bin/bash

url=${1:?"Usage: $0 <url> <filename>"}
temp_file=$(mktemp -p /tmp)
filename=${2:?"Usage: $0 <url> <filename>"}
recipe_path="$HOME/Documents/icloudDocs/Recipe_backups"

cd "$recipe_path"

trap "rm -f $temp_file" 0 2 3 15
echo 'ls /tmp/'
ls /tmp/*
#tail -f $temp_file > /dev/null &

# sed '1,/^$/d' skips everything until the blank line that separates headers from the html body (For HTML/General payloads)
curl -fsSLO --url "$url" \
-H 'x-requested-with: XMLHttpRequest' \
--compressed -w "html" -o $filename.html | sed '1,/^$/d'

# if the filename ends in html strip it out
#sed 's/\.html$//' <<< "$filename" > /dev/null || filename="$filename.html"

perl -e 's#<div data-testid="ContentFooterBottom" class="ContentFooterBottom-cbbwZo iSuBdg">.*?</div>(?=\s*</main>)##s' "$filename".html

open .

/Applications/Safari.app/Contents/MacOS/Safari -bna "file:///$filename"