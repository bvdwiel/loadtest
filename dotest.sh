#!/bin/bash
/bin/siege -f urls.txt -c10 -i -t1M -l > c10_t10_result.txt
/bin/siege -f urls.txt -c20 -i -t1M -l > c20_t10_result.txt
/bin/siege -f urls.txt -c30 -i -t1M -l > c30_t10_result.txt
/bin/siege -f urls.txt -c40 -i -t1M -l > c40_t10_result.txt
/bin/siege -f urls.txt -c50 -i -t1M -l > c50_t10_result.txt
/bin/siege -f urls.txt -c60 -i -t1M -l > c60_t10_result.txt

