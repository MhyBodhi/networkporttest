#!/bin/bash
test -e ./result
if [ $? -ne 0 ];then
    mkdir result
fi
#TCP test $2 file
echo "test TCP $2"
echo "TCP $2" >> ./result/iperf3.csv
iperf3 -c $1 -b 1000M -n $2|tail -n 5|head -n 3 >> result/iperf3.csv
#UDP test 2G file
echo "test UDP $2"
echo "UDP $2" >> ./result/iperf3.csv
iperf3 -u -c $1 -b 1000M -n $2|tail -n 5|head -n 3 >> result/iperf3.csv

