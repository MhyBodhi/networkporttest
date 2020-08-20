#!/bin/bash
#Installation dependent environment
sudo bash install.bash

#netperf 60 seconds for each test
sudo bash netperf/netperf.sh 192.168.1.100 60
#iperf3 The test time is 200 seconds, each item runs for 60 seconds, and the Ping Test -c parameter is 10
sudo bash iperf3/iperf3.sh 192.168.1.100 200 60 10
#nc test
 #server listen to 5000 port,redis server ip 192.168.1.206
sudo bash ncserver.sh 5000 192.168.1.206
 #client connect server ip 192.168.1.217,port 5000,test01 is the transfer file,redis server 192.168.1.206
sudo bash ncclient.sh 192.168.1.217 5000 test01.sh 192.168.1.206