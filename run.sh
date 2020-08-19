#!/bin/bash
#Installation dependent environment
sudo bash install.bash

#netperf test
sudo bash netperf/netperf.sh 192.168.1.100 60
#iperf3 test
sudo bash iperf3/iperf3.sh 192.168.1.100 200 60 10
#nc test
 #server
sudo bash ncserver.sh 5000 192.168.1.206
 #client
sudo bash ncclient.sh 192.168.1.217 5000 test01.sh 192.168.1.206
