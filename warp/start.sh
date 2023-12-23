#!/usr/bin/dumb-init /bin/bash
set -e
warp-svc 2>&1 >warp.log &
sleep 2
echo "Initializing warp license..."
if [ $LICENSE ]; then
    warp-cli --accept-tos set-license $LICENSE
else
    warp-cli --accept-tos register
fi
echo "Changing warp mode..."
warp-cli --accept-tos set-mode proxy
echo "Connecting to warp..."
warp-cli --accept-tos connect
