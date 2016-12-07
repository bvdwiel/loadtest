#!/bin/bash
./spider.sh $1
./dotest.sh
./parseresults.sh
./plottest.sh
