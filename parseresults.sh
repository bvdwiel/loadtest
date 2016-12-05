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
echo "Creating results database in results.db"
$SQLITECMD results.db < ddl.sql

for resultfile in c*.txt
do
  echo "Processing data in $resultfile, this may take a while!"
  cValue="$(grep -o '[0-9][0-9]' <<< $resultfile)"
  while read line; do
    if grep -q  '^HTTP/' <<< $line
    then
      PROTO=$(echo $line | cut -f1 -d,)
      STATUS=$(echo $line | cut -f2 -d,)
      VOLUME=$(echo $line | cut -f4 -d,)
      RT=$(echo $line | cut -f3 -d,)
      URL=$(echo $line | cut -f5 -d,)
      DATETIME=$(echo $line | cut -f7 -d,)
      $SQLITECMD results.db <<SQLCommandString
BEGIN TRANSACTION;
INSERT INTO main.results (PROTO,STATUS,VOLUME,RT,URL,DATETIME,C)
  VALUES('$PROTO',$STATUS,$VOLUME,$RT,'$URL','$DATETIME',$cValue);
COMMIT TRANSACTION;
SQLCommandString
    fi
  done < $resultfile
done
