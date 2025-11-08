#!/usr/bin/env python3
# Providing metrics from GQ GMC Geiger counter
# The computer must connect to the counter via USB cable
# __author__: tuan t. pham
# tuan at vt dot edu

import pygmc
import argparse
from flask import Flask, json

# parsing config
parser = argparse.ArgumentParser()
parser.add_argument("-H", "--host", default="0.0.0.0", help="host to bind to, default: 0.0.0.0")
parser.add_argument("-p", "--port", type=int, default=2380, help="port to listen to, default: 2380")
parser.add_argument("-d", "--debug", action='store_true', help="debug mode, default: False")
args = parser.parse_args()

app = Flask("GMC")
gmc = pygmc.connect()
_version_ = str(gmc.get_version())

print(f"Available endpoints:")
print(f"/config = list GMC config")
print(f"/metrics = return availale metrics from gmc USB devices")

@app.route('/config')
def config():
    return json.dumps(gmc.get_config(), indent=2, sort_keys=True)

@app.route('/metrics')
def metrics():
    global _version_
    #_version_ = str(gmc.get_version())
    data = [{"cpm": gmc.get_cpm(),
             "version": _version_
             }]
    return json.dumps(data, indent=2)

if __name__ == '__main__':
    app.run(host=args.host, port=args.port, debug=args.debug)
