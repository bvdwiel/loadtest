#!/usr/bin/env bash
GNUPLOTCMD=`which gnuplot`
if [ ! -x $GNUPLOTCMD ]
then
  echo "Cannot use the gnuplot command. Make sure Gnuplot is installed and you have permission to use it."
  exit 1
fi
if [ ! -f averages.csv ]
then
  echo "File averages.csv not present. Run parseresults.sh to generate it."
  exit 1
fi
if [ ! -f httpstatus.csv ]
then
  echo "File httpstatus.csv not present. Run parseresults.sh to generate it."
fi
$GNUPLOTCMD statistics.gnuplot

