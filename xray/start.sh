#! /bin/bash
set -e
function setup() {
    if [ $LICENSE ]; then
        warp-cli --accept-tos set-license $LICENSE
    else
        warp-cli --accept-tos register
    fi
    warp-cli --accept-tos set-mode proxy
    warp-cli --accept-tos connect
}

warp-svc &
sleep 2
setup
/xray/xray run -config /xray/config.json
