#!/bin/bash
/opt/siege/bin/siege -f urls.txt -c$1 -i -t$2M > c$1_t$2_prod.txt
