#!/usr/bin/env bash
. config
if [ ! -x /usr/bin/which ]
then
  echo "Can't find the which utility in /usr/bin or not allowed to use it, aborting." >&2
  exit 1
fi
GNUPLOTCMD=`which gnuplot`
SQLITECMD=`which sqlite3`
if [ ! -x $GNUPLOTCMD ]
then
  echo "Cannot use the gnuplot command. Make sure Gnuplot is installed and you have permission to use it." >&2
  exit 1
fi

#-----
# Highest response times in milliseconds at measured concurrency levels
#-----
$SQLITECMD results.db <<EOS
.mode csv
.output slowpages.csv
SELECT (MAX(RT)*1000),C FROM results WHERE STATUS=200 GROUP BY C ORDER BY C ASC;
EOS

#-----
# Lowest response times in milliseconds at measured concurrency levels
#-----
$SQLITECMD results.db <<EOS
.mode csv
.output fastpages.csv
SELECT (MIN(RT)*1000),C FROM results WHERE STATUS=200 GROUP BY C ORDER BY C ASC;
EOS

#-----
# Average response times in milliseconds at measured concurrency levels
#-----
$SQLITECMD results.db <<EOS
.mode csv
.output averages.csv
SELECT (AVG(RT)*1000),C FROM results WHERE STATUS=200 GROUP BY C ORDER BY C ASC;
EOS

#-----
# Aggregate error rate at measured concurrency levels
#-----
$SQLITECMD results.db <<EOS
.mode csv
.output errorrate.csv
SELECT COUNT(*) AS ERRORCOUNT,C FROM RESULTS WHERE STATUS>399 GROUP BY C;
EOS

#-----
# Average number of requests per second for each concurrency level
#-----
$SQLITECMD results.db <<EOS
.mode csv
.output reqspersecond.csv
SELECT AVG(NUMREQ),C FROM (SELECT COUNT(*) AS NUMREQ,DATETIME,C FROM results WHERE STATUS='200' GROUP BY DATETIME ORDER BY DATETIME) GROUP BY C ORDER BY C ASC;
EOS

#-----
# Average number of errors per second for each concurrency level
#-----
$SQLITECMD results.db <<EOS
.mode csv
.output failcount.csv
SELECT AVG(NUMREQ),C FROM (SELECT COUNT(*) AS NUMREQ,DATETIME,C FROM results WHERE STATUS>399 GROUP BY DATETIME ORDER BY DATETIME) GROUP BY C ORDER BY C ASC;
EOS

#-----
# Dotcloud: every request plotted as a dot on a timescale
#-----
$SQLITECMD results.db <<EOS
.mode csv
.output dotcloud.csv
SELECT RT,DATETIME FROM RESULTS ORDER BY DATETIME ASC;
EOS

$GNUPLOTCMD responsetimes.gnuplot
$GNUPLOTCMD timesvsthreads.gnuplot
$GNUPLOTCMD dotcloud.gnuplot
