#!/bin/bash
#-----
# START		The lowest value for concurrency to test
# END		The highest value for concurrency to test
# INCREMENT	Step-size for the increment between START and END
# SIEGETIME	Duration of each single run of the Siege command
#-----
START=10
END=160
INCREMENT=10
SIEGETIME=5

#-----
# No user-serviceable parts below this line
#-----
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
