#!/bin/bash
SIEGECMD=`which siege`
SIEGECMD=/opt/siege/bin/siege
if [ ! -x $SIEGECMD ]
then
  echo "Unable to use the siege command. Make sure Siege is installed and you have permission to use it."
  exit 1
fi
$SIEGECMD -f urls.txt -c10 -i -t10M -l > c10.txt
$SIEGECMD -f urls.txt -c20 -i -t10M -l > c20.txt
$SIEGECMD -f urls.txt -c30 -i -t10M -l > c30.txt
$SIEGECMD -f urls.txt -c40 -i -t10M -l > c40.txt
$SIEGECMD -f urls.txt -c50 -i -t10M -l > c50.txt
$SIEGECMD -f urls.txt -c60 -i -t10M -l > c60.txt
$SIEGECMD -f urls.txt -c70 -i -t10M -l > c70.txt
$SIEGECMD -f urls.txt -c80 -i -t10M -l > c80.txt
$SIEGECMD -f urls.txt -c90 -i -t10M -l > c90.txt

