#! /bin/sh
set -e
until nc -z -v -w5 localhost 9999
do
    echo "Waiting for warp..."
    sleep 1
done
echo "Warp is up and running"