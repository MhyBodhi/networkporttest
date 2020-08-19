#!/bin/bash
# $1 server IP address
# $2 server port
# $3 Specify test file

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
    pool = redis.ConnectionPool(host="$4", port=6379, decode_responses=True)
    r = redis.Redis(connection_pool=pool)
    return r
if __name__ == '__main__':
    filesize = os.path.getsize("$3")
    print("发送文件大小", filesize)
    r = connect()
    r.hset("md5","client",verifymd5("$3"))
    r.hset("size","client",filesize)
    print("client success...")
MHY
/bin/nc $1 $2 < $3
