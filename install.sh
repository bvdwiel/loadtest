#!/bin/bash
mv ~/.siege/siege.conf ~/.siege/siege.conf_orig
cp siegerc ~/.siege/siege.conf
echo "Loadtest siege.conf installed into your homedir. Original stashed away as ~/.siege/siege.conf_orig"
