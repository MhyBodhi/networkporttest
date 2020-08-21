#!/bin/bash
# $1 listening port
# $2 redis server IP address
# $3 waiting time Unit:second
echo "start listen port $1 ..."
sudo /bin/nc -l -p $1 > server_receive #/bin/nc
/usr/bin/python3<<-MHY
import os
import csv
import redis
def verifymd5(file):
    import hashlib
    md5_value = hashlib.md5()
    with open(file,'rb') as f:
        while True:
            data = f.read(2048)
            if not data:
                break
            md5_value.update(data)
    return md5_value.hexdigest()
def connect():
    pool = redis.ConnectionPool(host="$2", port=6379, decode_responses=True)
    r = redis.Redis(connection_pool=pool)
    return r
def report():
    header = ["发送文件大小(字节)","接收文件大小(字节)","发送端md5","接收端md5","结果"]
    with open("nc.csv","w",encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerow([client_size,server_size,client_md5,server_md5,result])
if __name__ == '__main__':
    r = connect()
    result = None
    client_size = r.hget("size","client")
    client_md5 = r.hget("md5","client")
    server_size = os.path.getsize("server_receive")
    server_md5 = verifymd5("server_receive")
    print("接收文件大小",os.path.getsize("server_receive"))
    if server_md5 == client_md5:
        print("接收验证通过")
        result = "success"
    else:
        print("接收验证失败")
        result = "fail"
    report()
MHY
ps -elf|grep "nc -l"|awk '{print $4}'|head -n1|xargs kill
echo "test over..."
