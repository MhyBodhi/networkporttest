import redis
import argparse
pool = redis.ConnectionPool(host='192.168.1.206', port=6379, decode_responses=True)
r = redis.Redis(connection_pool=pool)

if __name__ == '__main__':
    pass