#!/bin/bash
#sever
#echo "start listen port $1 ..."
#nc -l $1 > result
#client
echo "start send $3 ..."
/usr/bin/python3<<-MHY
import os
print("发送文件大小",os.path.size("largefile"))
MHY
nc $1 $2 < $3
#server
#nc -l $1 | tar -xvfz -
#client
#tar -czf - * | nc $1 $2 
/usr/bin/python3<<-MHY
def verifymd5():
    import hashlib
    md5_value = hashlib.md5()
    with open("result",'rb') as f:
        while True:
            data = f.read(2048)
            if not data:
                break
            md5_value.update(data)
    return md5_value.hexdigest()
if __name__ == '__main__':
    print("接收文件大小",os.path.getsize("result"))
    print(verifymd5())
MHY
