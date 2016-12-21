#!/usr/bin/env bash
. config
VALIDATOR='(https?)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
if [[ ! $1 =~ $VALIDATOR ]]
then
  echo "$1 is not a valid URL, aborting." >&2
  exit 1
fi
./spider.sh $1
./dotest.sh
./parseresults.sh
./plottest.sh
