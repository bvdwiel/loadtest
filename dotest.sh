#!/usr/bin/env bash
. config
if [ ! -x /usr/bin/which ]
then
  echo "Can't find the which utility in /usr/bin or not allowed to use it, aborting." >&2
  exit 1
fi
SIEGECMD=`which siege`
SIEGECMD='/opt/siege/bin/siege'
if [ ! -x $SIEGECMD ]
then
  echo "Unable to use the siege command. Make sure Siege is installed and you have permission to use it." >&2
  exit 1
fi

for (( COUNTER=$START; COUNTER<=$END; COUNTER+=$INCREMENT ))
do
  $SIEGECMD -f urls.txt -c$COUNTER -i -t$SIEGETIME > c$COUNTER.txt
done
