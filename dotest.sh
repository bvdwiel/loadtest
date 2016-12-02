#!/bin/bash
/opt/siege/bin/siege -f urls.txt -c10 -i -t1M -l > c10_t10_result.txt
/opt/siege/bin/siege -f urls.txt -c20 -i -t1M -l > c20_t10_result.txt
/opt/siege/bin/siege -f urls.txt -c30 -i -t1M -l > c30_t10_result.txt
/opt/siege/bin/siege -f urls.txt -c40 -i -t1M -l > c40_t10_result.txt
/opt/siege/bin/siege -f urls.txt -c50 -i -t1M -l > c50_t10_result.txt
/opt/siege/bin/siege -f urls.txt -c60 -i -t1M -l > c60_t10_result.txt
/opt/siege/bin/siege -f urls.txt -c70 -i -t1M -l > c70_t10_result.txt
/opt/siege/bin/siege -f urls.txt -c80 -i -t1M -l > c80_t10_result.txt
/opt/siege/bin/siege -f urls.txt -c90 -i -t1M -l > c90_t10_result.txt
/opt/siege/bin/siege -f urls.txt -c100 -i -t1M -l > c100_t10_result.txt
/opt/siege/bin/siege -f urls.txt -c110 -i -t1M -l > c110_t10_result.txt
/opt/siege/bin/siege -f urls.txt -c120 -i -t1M -l > c120_t10_result.txt
