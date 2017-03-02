#!/usr/bin/env bash
. config
if [ ! -x /usr/bin/which ]
then
  echo "Can't find the which utility in /usr/bin or not allowed to use it, aborting." >&2
  exit 1
fi
GNUPLOTCMD=`which gnuplot`
if [ ! -x $GNUPLOTCMD ]
then
  echo "Cannot use the gnuplot command. Make sure Gnuplot is installed and you have permission to use it." >&2
  exit 1
fi
if [ ! -f averages.csv ]
then
  echo "File averages.csv not present. Run parseresults.sh to generate it." >&2
  exit 1
fi
if [ ! -f errorrate.csv ]
then
  echo "File httpstatus.csv not present. Run parseresults.sh to generate it." >&2
fi
$GNUPLOTCMD statistics.gnuplot

