#!/bin/bash
SQLITECMD=`which sqlite3`
if [ ! -x $SQLITECMD ]
then
  echo "Cannot use sqlite3 command. Please check if SQLite3 is installed on this system and you have permission to use it."
  exit 1
fi
if [ -f results.db ]
then
  rm results.db
fi

for result in c*result.txt
do
 cat $result | grep -e '^HTTP/1.1,4' > $result._errors.txt
 cat $result | grep -e '^HTTP/1.1,5' >> $result._errors.txt
 cat $result | grep -e '^HTTP/1.1,3' > $result._redirects.txt
 cat $result | grep -e '^HTTP/1.1,200' | cut -d, -f 3,5,7 > $result._normal.txt
done
