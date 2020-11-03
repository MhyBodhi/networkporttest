# networkporttest

* 测试脚本基于nc、netperf、iperf3网络测试工具的封装，相关参数的使用请参见脚本头行说明
* iperf3.sh,该文件封装ping、iperf3网络测试工具，生成的报告分别统计发送端带宽、接收端带宽、时延抖动、udp丢包、ping延迟、ping丢包
* netperf,该文件封装netperf工具，分别测试TCP_STREAM、UDP_STREAM、TCP_RR、TCP_CRR、UDP_RR五种情况下的吞吐量
* nc,通过对nc工具的封装，统计在传输大文件时网口的稳定性，报告统计发送文件大小、接收文件大小、传输时间、传输速率以及验证文件MD5等
* 运行脚本以run.sh作为运行入口文件
# 备注
   * 使用nc工具测试时，需要两端的系统时间一致，这样时间戳才不会有差异，否则会影响到统计时间相关的子项，如传输时间、传输时延等
