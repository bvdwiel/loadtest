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
  echo "BEGIN TRANSACTION; " > queryfile.sql
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
      echo "INSERT INTO main.results (PROTO,STATUS,VOLUME,RT,URL,DATETIME,C) VALUES ('"$PROTO"',$STATUS,$VOLUME,$RT,'"$URL"','"$DATETIME"',$cValue);" >>queryfile.sql
    fi
  done < $resultfile
  echo "COMMIT TRANSACTION;" >>queryfile.sql
  $SQLITECMD results.db < queryfile.sql
done
rm queryfile.sql

#-----
# Average response times in milliseconds at measured concurrency levels
#-----
$SQLITECMD results.db <<EOS
.mode csv
.output averages.csv
SELECT (AVG(RT)*1000),C FROM results WHERE STATUS=200 GROUP BY C ORDER BY C ASC;
EOS

#-----
# HTP status distribution at measured concurrency levels
#-----
$SQLITECMD results.db <<EOS
.mode csv
.output httpstatus.csv
SELECT STATUS,C,COUNT(*) FROM results GROUP BY STATUS,C ORDER BY STATUS;
EOS

