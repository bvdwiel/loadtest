#!/bin/bash
#$results = ls | grep result\.txt
for result in c*result.txt
do
 cat $result | grep -e '^HTTP/1.1,4' > $result._errors.txt
 cat $result | grep -e '^HTTP/1.1,5' >> $result._errors.txt
 cat $result | grep -e '^HTTP/1.1,3' > $result._redirects.txt
 cat $result | grep -e '^HTTP/1.1,200' | cut -d, -f 3,5,7 > $result._normal.txt
done
