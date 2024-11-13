#!/bin/sh
set -e
nohup warp-svc
sleep 5
echo "Initializing warp license..."
if [ $LICENSE ]; then
    warp-cli --accept-tos set-license $LICENSE
else
    warp-cli --accept-tos register
fi
echo "Changing warp mode..."
warp-cli --accept-tos set-proxy-port 9999
warp-cli --accept-tos set-mode proxy
echo "Connecting to warp..."
warp-cli --accept-tos connect
exec warp-svc