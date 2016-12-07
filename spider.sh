#!/bin/bash
. config
WGETCMD=`which wget`
AWKCMD=`which awk`
if [ ! -x $WGETCMD ] 
then
  echo "Can't use the wget command. Make sure wget is installed and you have permission to use it."
  exit 1
fi
if [ ! -x $AWKCMD ]
then
  echo "Can't use the awk command. Make sure awk is installed and you have permission to use it."
  exit 1
fi
if [ -f urls.txt ] 
then
  rm urls.txt
fi
$WGETCMD -e robots=off --no-check-certificate -m $1 2>&1 | grep '^--' | awk '{ print $3 }' | grep -v '\.\(css\|js\|jpg\|png\|gif\|CSS\|JS\|JPG\|PNG\|GIF\|php\|PHP\)' > urls.txt
rm -rf ./$1
