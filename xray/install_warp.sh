#! /bin/bash
set -e
apt-get update  && \
apt-get install -y curl gpg lsb-release  && \
curl https://pkg.cloudflareclient.com/pubkey.gpg | gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg  && \
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/cloudflare-client.list  && \
apt-get update && \
apt-get install -y cloudflare-warp && \
apt-get clean autoclean && \
apt-get autoremove --yes && \
rm -rf /var/lib/{apt,cache,log}/
