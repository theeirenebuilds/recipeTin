#!/bin/bash

url=${1:?"Usage: $0 <url> <filename>"}
filename=${2%.html:?"Usage: $0 <url> <filename>"}
recipe_path="$HOME/Documents/icloudDocs/Recipe_backups"
recipe=$(printf "%s.html" "$filename")

#filename=${filename%.html} && filename="$filename.html"

#cd "$recipe_path"

# sed '1,/^$/d' skips everything until the blank line that separates headers from the html body (For HTML/General payloads)
curl -fsSL --url "$url" \
-H 'x-requested-with: XMLHttpRequest' \
--compressed -o "$recipe" | sed '1,/^$/d'

# if the filename ends in html strip it out
#sed 's/\.html$//' <<< "$filename" > /dev/null || filename="$filename.html"

#perl -e 's#<div data-testid="ContentFooterBottom" class="ContentFooterBottom-cbbwZo iSuBdg">.*?</div>(?=\s*</main>)##s' $filename

echo $recipe
