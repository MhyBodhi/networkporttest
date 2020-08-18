import os
import argparse
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
    pool = redis.ConnectionPool(host=args.ip, port=6379, decode_responses=True)
    r = redis.Redis(connection_pool=pool)
    return r

def report():
    pass

if __name__ == '__main__':
    print("发送文件大小", os.path.size("$3"))
    parse = argparse.ArgumentParser()
    parse.add_argument("-ip",default="192.168.1.206",help="Redis server address")
    args = parse.parse_args()
    print("接收文件大小", os.path.getsize("server_receive"))
    r = connect()
    r.hset("md5","client",verifymd5("$3"))
    if verifymd5("server_receive") == r.hget("md5","client"):
        print("success!")