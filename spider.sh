#!/bin/bash
wget -e robots=off -m $1 2>&1 | grep '^--' | awk '{ print $3 }' | grep -v '\.\(css\|js\|png\|gif\|jpg\|JPG\)$' > urls.txt
rm -rf ./$1

