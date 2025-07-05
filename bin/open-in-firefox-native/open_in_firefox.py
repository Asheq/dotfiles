#!/usr/bin/env python3
import sys
import json
import struct
import subprocess

def read_message():
    raw_length = sys.stdin.buffer.read(4)
    if len(raw_length) == 0:
        sys.exit(0)
    message_length = struct.unpack("=I", raw_length)[0]
    message = sys.stdin.buffer.read(message_length).decode("utf-8")
    return json.loads(message)

def send_message(message):
    encoded = json.dumps(message).encode("utf-8")
    sys.stdout.buffer.write(struct.pack("=I", len(encoded)))
    sys.stdout.buffer.write(encoded)
    sys.stdout.buffer.flush()

def main():
    data = read_message()
    url = data.get("url")
    print(f"Received URL: {url}", file=sys.stderr)
    try:
        # Adjust the Firefox path if needed for your system
        subprocess.Popen([
            "/Applications/Firefox.app/Contents/MacOS/firefox",
            url
        ])
        send_message({"status": "launched"})
    except Exception as e:
        send_message({"status": "error", "message": str(e)})

if __name__ == "__main__":
    main()
