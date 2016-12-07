#!/bin/bash
SIEGECMD=`which siege`
if [ ! -x $SIEGECMD ]
then
  echo "Unable to use the siege command. Make sure Siege is installed and you have permission to use it."
  exit 1
fi
$SIEGECMD -f urls.txt -c10 -i -t5M > c10.txt
$SIEGECMD -f urls.txt -c20 -i -t5M > c20.txt
$SIEGECMD -f urls.txt -c30 -i -t5M > c30.txt
$SIEGECMD -f urls.txt -c40 -i -t5M > c40.txt
$SIEGECMD -f urls.txt -c50 -i -t5M > c50.txt
$SIEGECMD -f urls.txt -c60 -i -t5M > c60.txt
$SIEGECMD -f urls.txt -c70 -i -t5M > c70.txt
$SIEGECMD -f urls.txt -c80 -i -t5M > c80.txt
$SIEGECMD -f urls.txt -c90 -i -t5M > c90.txt
$SIEGECMD -f urls.txt -c100 -i -t5M > c100.txt
$SIEGECMD -f urls.txt -c110 -i -t5M > c110.txt
$SIEGECMD -f urls.txt -c120 -i -t5M > c120.txt
$SIEGECMD -f urls.txt -c130 -i -t5M > c130.txt
$SIEGECMD -f urls.txt -c140 -i -t5M > c140.txt
$SIEGECMD -f urls.txt -c150 -i -t5M > c150.txt
$SIEGECMD -f urls.txt -c160 -i -t5M > c160.txt

