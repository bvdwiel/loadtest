#!/bin/bash
mkdir -p ~/.siege
if [ -f ~/.siege/siege.conf ]
  mv ~/.siege/siege.conf ~/.siege/siege.conf_orig
fi
cp siegerc ~/.siege/siege.conf
echo "Loadtest siege.conf installed into your homedir. Original stashed away as ~/.siege/siege.conf_orig"
