#!/bin/bash
echo "start..."
#TCP_STREAM
echo "start test tcp_stream..."
echo "TCP_STREAM" > report_netperf.csv
netperf -H $1 -l $2|tail -n4|grep "^$" -v >> report_netperf.csv
echo >>report_netperf
#UDP_STREAM
echo "start test udp_stream..."想
echo "UDP_STREAM" >> report_netperf.csv
netperf -t UDP_STREAM -H $1 -l $2|tail -n6|grep "^$" -v >> report_netperf.csv
echo >>report_netperf.csv
#TCP_RR
echo "start test tcp_rr..."
echo "TCP_RR" >> report_netperf.csv
netperf -t TCP_RR -H $1 -l $2|tail -n6|grep "^$" -v >> report_netperf.csv
echo >>report_netperf.csv
#TCP_CRR
echo "start test tcp_crr..."
echo "TCP_CRR" >> report_netperf.csv
netperf -t TCP_CRR -H $1 -l $2 |tail -n6|grep "^$" -v >> report_netperf.csv
echo >>report_netperf.csv
#UDP_RR
echo "start test udp_rr..."
echo "UDP_RR" >> report_netperf.csv
netperf -t UDP_RR -H $1 -l $2|tail -n6|grep "^$" -v >> report_netperf.csv
echo "test over..."