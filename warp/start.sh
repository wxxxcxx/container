#! /bin/bash
set -e
function setup() {
    if [ $LICENSE ]; then
        warp-cli --accept-tos set-license $LICENSE
    else
        warp-cli --accept-tos register
    fi
    warp-cli --accept-tos set-mode proxy
    if [ $PORT ]; then
        warp-cli --accept-tos set-proxy-port $PORT
    fi
    warp-cli --accept-tos connect
}

warp-svc&
sleep 10
setup
while [[ true ]]; do
    sleep 1
done

