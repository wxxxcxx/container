#! /bin/bash

apt update &&\
apt install -y unzip curl wget && \
apt clean autoclean && \
apt autoremove --yes && \
rm -rf /var/lib/{apt,dpkg,cache,log}/

MACHINE=""
if [[ "$(uname)" == 'Linux' ]]; then
case "$(uname -m)" in
    'i386' | 'i686')
    MACHINE='32'
    ;;
    'amd64' | 'x86_64')
    MACHINE='64'
    ;;
    'armv5tel')
    MACHINE='arm32-v5'
    ;;
    'armv6l')
    MACHINE='arm32-v6'
    grep Features /proc/cpuinfo | grep -qw 'vfp' || MACHINE='arm32-v5'
    ;;
    'armv7' | 'armv7l')
    MACHINE='arm32-v7a'
    grep Features /proc/cpuinfo | grep -qw 'vfp' || MACHINE='arm32-v5'
    ;;
    'armv8' | 'aarch64')
    MACHINE='arm64-v8a'
    ;;
    'mips')
    MACHINE='mips32'
    ;;
    'mipsle')
    MACHINE='mips32le'
    ;;
    'mips64')
    MACHINE='mips64'
    lscpu | grep -q "Little Endian" && MACHINE='mips64le'
    ;;
    'mips64le')
    MACHINE='mips64le'
    ;;
    'ppc64')
    MACHINE='ppc64'
    ;;
    'ppc64le')
    MACHINE='ppc64le'
    ;;
    'riscv64')
    MACHINE='riscv64'
    ;;
    's390x')
    MACHINE='s390x'
    ;;
    *)
    echo "error: The architecture is not supported."
    exit 1
    ;;
esac
if [[ ! -f '/etc/os-release' ]]; then
    echo "error: Don't use outdated Linux distributions."
    exit 1
fi
else
echo "error: This operating system is not supported."
exit 1
fi

# Get Xray latest release version number
RELEASE_LATEST=$(curl --silent "https://api.github.com/repos/XTLS/Xray-core/releases"|grep -E 'tag_name\": \".*?\"' -o|head -n 1|tr -d 'tag_name\": ')


DOWNLOAD_LINK="https://github.com/XTLS/Xray-core/releases/download/$RELEASE_LATEST/Xray-linux-$MACHINE.zip"
echo "Downloading Xray archive: $DOWNLOAD_LINK"
wget -q -O "/xray/xray.zip" "$DOWNLOAD_LINK"

ls -alh /xray
unzip -q /xray/xray.zip -d /xray/ && rm xray.zip



