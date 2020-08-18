#!/bin/bash
# $1 listening port
#init data
#sever
sudo bash ./install.sh

echo "start listen port $1 ..."
nc -l $1 > server_receive
/usr/bin/python3<<-MHY
import os
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
    pool = redis.ConnectionPool(host="192.168.1.206", port=6379, decode_responses=True)
    r = redis.Redis(connection_pool=pool)
    return r

if __name__ == '__main__':
    r = connect()
    print("接收文件大小",os.path.getsize("server_receive"))
    if verifymd5("server_receive")==r.hget("md5","client"):
        print("接收验证通过")
    else:
        print("接收验证失败")
MHY
