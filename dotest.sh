#!/bin/bash
. config
SIEGECMD=`which siege`
SIEGECMD='/opt/siege/bin/siege'
if [ ! -x $SIEGECMD ]
then
  echo "Unable to use the siege command. Make sure Siege is installed and you have permission to use it."
  exit 1
fi

for (( COUNTER=$START; COUNTER<=$END; COUNTER+=$INCREMENT ))
do
  $SIEGECMD -f urls.txt -c$COUNTER -i -t$SIEGETIMEM > c$COUNTER.txt
done
