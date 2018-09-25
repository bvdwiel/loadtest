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
if [ ! -x ./parseresults ]
then
  echo "Cannot use parseresults binary. See ./cpp directory for more information. You did run install.sh before using this script, right?" >&2
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

for counter in $(seq $START $INCREMENT $END)
do
  echo "Working on C-level $counter." >&2
  ./parseresults $counter
done
