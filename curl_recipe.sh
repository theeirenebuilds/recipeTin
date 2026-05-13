#!/bin/bash

url=${1:?"Usage: $0 <url> <filename>"}
filename=${2:?"Usage: $0 <url> <filename>"}

# if the filename ends in html strip it out
sed 's/\.html$//' <<< "$filename" > /dev/null || filename="$filename.html"

curl $url -i  \
-H 'x-requested-with: XMLHttpRequest' \
--compressed -o /Users/ijaramil/Library/Mobile\ Documents/com\~apple\~CloudDocs/Documents/Recipe_backups/$filename | sed '1,/^$/d'


/Applications/Safari.app/Contents/MacOS/Safari -bna 'file:///Users/ijaramil/Library/Mobile\ Documents/com\~apple\~CloudDocs/Documents/Recipe_backups/$filename'