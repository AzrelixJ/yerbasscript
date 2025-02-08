#!/bin/bash

# Azrelix UBUNTU install script

set -e  # Exit immediately if a command exits with a non-zero status

# Ensure required packages are installed
sudo apt update && sudo apt install -y wget unzip

# Download and extract Yerbas binary
cd ~
wget -q --show-progress https://github.com/The-Yerbas-Endeavor/yerbas/releases/download/v3.1.4.20/yerbas-ubuntu22-3.1.4.20.tar.gz
tar -xf yerbas-ubuntu22-3.1.4.20.tar.gz
rm yerbas-ubuntu22-3.1.4.20.tar.gz

# Create config directory and configuration file
mkdir -p ~/.yerbascore

cat <<EOF > ~/.yerbascore/yerbas.conf
daemon=1
rpcallowip=127.0.0.1
rpcport=8482
rpcuser=your_rpc_username
rpcpass=your_rpc_password
listen=1
server=1
bind=10.0.0.
port=15420
externalip=
smartnodeblsprivkey=
EOF

# Download and extract bootstrap files
cd ~/.yerbascore
wget -q --show-progress https://github.com/The-Yerbas-Endeavor/YERB-Bootstrap/releases/download/1.0.0.0/powcache.dat
wget -q --show-progress https://github.com/The-Yerbas-Endeavor/YERB-Bootstrap/releases/download/1.0.0.0/bootstrap.zip
unzip -o bootstrap.zip
rm bootstrap.zip

# Move contents of bootstrap folder back one level and remove empty folder
if [ -d "bootstrap" ]; then
    mv bootstrap/* .
    rmdir bootstrap
fi

# Open configuration file for review
nano ~/.yerbascore/yerbas.conf
