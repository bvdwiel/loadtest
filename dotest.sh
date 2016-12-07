#!/bin/bash
. config
SIEGECMD=`which siege`
SIEGECMD='/opt/siege/bin/siege'
if [ ! -x $SIEGECMD ]
then
  echo "Unable to use the siege command. Make sure Siege is installed and you have permission to use it."
  exit 1
fi

for i in {$START..$END..$INCREMENT}
do
  $SIEGECMD -f urls.txt -c$i -i -t$SIEGETIMEM > c$i.txt
done
