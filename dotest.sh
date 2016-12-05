#!/bin/bash
SIEGECMD=`which siege`
SIEGECMD=/opt/siege/bin/siege
if [ ! -x $SIEGECMD ]
then
  echo "Unable to use the siege command. Make sure Siege is installed and you have permission to use it."
  exit 1
fi
$SIEGECMD -f urls.txt -c10 -i -t1M -l > c10.txt
