#!/usr/bin/env bash
. config
if [ ! -x /usr/bin/which ]
then
  echo "Can't find the which utility in /usr/bin or not allowed to use it, aborting." >&2
  exit 1
fi
SQLITECMD=`which sqlite3`
if [ ! -x $SQLITECMD ]
then
  echo "Cannot use sqlite3 command. Please check if SQLite3 is installed on this system and you have permission to use it." >&2
  exit 1
fi
if [ -f results.db ]
then
  rm results.db
fi
SEDCMD=`which sed`
if [ ! -x $SEDCMD ]
then
  echo "Cannot use the sed command. Please check if sed is installed on this system and you have permission to use it." >&2
fi
echo "Url-encoding any single-quote characters found in the result set URL's." -i -e s/\'
$SEDCMD s/%27/g c*.txt

echo "Creating results database in results.db"
$SQLITECMD results.db < ddl.sql

for resultfile in c*.txt
do
  echo "Processing data in $resultfile, this may take a while!"
  echo "BEGIN TRANSACTION; " > queryfile.sql
  cValue="$(grep -o -E '[0-9]{2,}' <<< $resultfile)"
  while read line; do
    if grep -q  '^HTTP/' <<< $line
    then
      PROTO=$(echo $line | cut -f1 -d,)
      STATUS=$(echo $line | cut -f2 -d,)
      VOLUME=$(echo $line | cut -f4 -d,)
      RT=$(echo $line | cut -f3 -d,)
      URL=$(echo $line | cut -f5 -d,)
      DATETIME=$(echo $line | cut -f7 -d,)
      echo "INSERT INTO main.results (PROTO,STATUS,VOLUME,RT,URL,DATETIME,C) VALUES ('"$PROTO"',$STATUS,$VOLUME,$RT,'"$URL"','"$DATETIME"',$cValue);" >>queryfile.sql
    fi
  done < $resultfile
  echo "COMMIT TRANSACTION;" >>queryfile.sql
  $SQLITECMD results.db < queryfile.sql
done
rm queryfile.sql
