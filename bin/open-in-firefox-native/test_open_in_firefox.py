#!/usr/bin/env python3
import sys
import json
import struct
import subprocess

message = {"url": "https://www.mozilla.org"}
encoded = json.dumps(message).encode("utf-8")
packed = struct.pack("=I", len(encoded)) + encoded

# Run the native host script and send the packed message
p = subprocess.Popen(
    ["./open_in_firefox.py"],
    stdin=subprocess.PIPE,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
)

stdout, stderr = p.communicate(packed)
print("STDOUT:", stdout.decode("utf-8"))
print("STDERR:", stderr.decode("utf-8"))
