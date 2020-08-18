#!/bin/bash
# $1 server IP address
# $2 server port
# $3 Specify test file
#init data
#sudo bash ./install.sh

#client
echo "start send $3 ..."
/usr/bin/python3<<-MHY
import os
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
    pool = redis.ConnectionPool(host="192.168.1.206", port=6379, decode_responses=True)
    r = redis.Redis(connection_pool=pool)
    return r
if __name__ == '__main__':
    print("发送文件大小", os.path.getsize("$3"))
    r = connect()
    r.hset("md5","client",verifymd5("$3"))
    print("client success...")
MHY
nc $1 $2 < $3
