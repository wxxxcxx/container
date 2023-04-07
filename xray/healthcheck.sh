#! /bin/bash
set -e
until nc -z -v -w5 localhost 40000
do
    echo "Waiting for warp..."
    sleep 1
done
echo "Warp is up and running"