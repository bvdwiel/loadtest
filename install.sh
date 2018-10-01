#!/usr/bin/env bash
if [ ! -x ./parseresults ]
then
  echo "Building optimized binary for parseresults."
  MAKECMD=`which make`
  if [ ! -x $MAKECMD ]
  then
    echo "Can't find a usable make utility. Make sure you have C++ development tools installed."
  fi
  if [ ! -x `which g++` ]
  then
    echo "Can't find GNU C++ compiler. Make sure you have g++ installed."
  fi
  cd cpp
  $MAKECMD
fi
