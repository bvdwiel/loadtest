#!/usr/bin/env bash
. config
if [ ! -x /usr/bin/which ]
then
  echo "Can't find the which utility in /usr/bin or not allowed to use it, aborting."
  exit 1
fi
WGETCMD=`which wget`
if [ ! -x $WGETCMD ]
then
  echo "Can't find the wget command or not allowed to use it, aborting."
  exit 1
fi
AWKCMD=`which awk`
if [ ! -x $AWKCMD ]
then
  echo "Can't find the awk command or not allowed to use it, aborting."
  exit 1
fi
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
