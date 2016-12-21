#!/usr/bin/env bash
. config
if [ ! -x /usr/bin/which ]
then
  echo "Can't find the which utility in /usr/bin or not allowed to use it, aborting." >&2
  exit 1
fi
WGETCMD=`which wget`
if [ ! -x $WGETCMD ]
then
  echo "Can't find the wget command or not allowed to use it, aborting." >&2
  exit 1
fi
AWKCMD=`which awk`
if [ ! -x $AWKCMD ]
then
  echo "Can't find the awk command or not allowed to use it, aborting." >&2
  exit 1
fi
if [ ! -x $WGETCMD ] 
then
  echo "Can't use the wget command. Make sure wget is installed and you have permission to use it." >&2
  exit 1
fi
if [ ! -x $AWKCMD ]
then
  echo "Can't use the awk command. Make sure awk is installed and you have permission to use it." >&2
  exit 1
fi
CURLCMD=`which curl`
if [ ! -x $CURLCMD ]
then
  echo "Can't use the curl command. Make sure curl is installed and you have permission to use it." >&2
  exit 1
fi

#-----
# Clean out any leftover urls.txt file
#-----
if [ -f urls.txt ]
then
  rm urls.txt
fi

#-----
# Start the indexer and build urls_raw.txt
#-----
$WGETCMD -e robots=off --no-check-certificate -m $1 2>&1 | grep '^--' | awk '{ print $3 }' | grep -v '\.\(css\|js\|jpg\|png\|gif\|CSS\|JS\|JPG\|PNG\|GIF\|php\|PHP\)' > urls_raw.txt
rm -rf ./$1

#-----
# Clean up the urls so only 200's remain
#-----
if [ ! -f urls_raw.txt ]
then
  echo "Something went wrong while creating urls_raw.txt, check if wget works properly on your system. Aborting for now." >&2
  exit 1
fi
while read URL; do
  if [ $($CURLCMD -sL -w "%{http_code}" "$URL" -o /dev/null) == "200" ]
  then
    echo $URL >> urls.txt
  fi
done <urls_raw.txt
