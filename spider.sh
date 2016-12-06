#!/bin/bash
WGETCMD=`which wget`
if [ ! -x $WGETCMD ] 
then
  echo "Can't use the wget command. Make sure wget is installed and you have permission to use it."
  exit 1
fi
if [ -f urls.txt ] 
then
  rm urls.txt
fi
$WGETCMD -e robots=off -m $1 2>&1 | grep '^--' | awk '{ print $3 }' | grep -v '\.\(css\|js\|png\|gif\|jpg\|JPG\)$' > urls.txt
rm -rf ./$1

