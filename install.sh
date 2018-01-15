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
if [ -x ~/.siege ]
then
  echo "You already have a .siege directory in your home. Aborting. Check your config manually." >&2
  exit 1
fi
mkdir -p ~/.siege
if [ ! -d ~/.siege ]
then
  echo "Something went wrong while creating the .siege directory in your home.. strange. Aborting." >&2
  exit 1
fi

cp siegerc ~/.siege/siege.conf
echo "Loadtest siege.conf installed into your homedir."
