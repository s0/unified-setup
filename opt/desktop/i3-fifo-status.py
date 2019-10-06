#! /bin/python3

import json
import time
import sys

import os
import threading

class StatusListener(threading.Thread):

    def __init__(self, status_fifo):
        super(StatusListener, self).__init__()
        self.status_fifo = status_fifo

    def run(self):
        sys.stderr.write("listening for status...")

        sys.stdout.write('{ "version": 1 }\n')
        sys.stdout.write('[')
        try:
            os.mkfifo(self.status_fifo)
        except:
            pass

        while True:
            with open(self.status_fifo) as fifo:
                status_string = fifo.read()
                try:
                    status = json.loads(status_string)
                    sys.stdout.write(json.dumps(status))
                    sys.stdout.write(',\n')
                    sys.stdout.flush()
                except:
                    sys.stderr.write("Received Invalid Status: " + status_string)
                    sys.stderr.flush()
                time.sleep(0.3)

listener = StatusListener('/tmp/status_fifo')
listener.start()
