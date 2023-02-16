#azrelix ARM install script
cd ~
wget https://github.com/The-Yerbas-Endeavor/test/releases/download/test1/yerbas-arm64-.tar.gz
tar -xvf yerbas-arm64-.tar.gz
rm yerbas-arm64-.tar.gz
mkdir ~/.yerbascore && touch ~/.yerbascore/yerbas.conf
echo daemon=1 >> ~/.yerbascore/yerbas.conf
echo addnode=107.191.55.148 >> ~/.yerbascore/yerbas.conf
echo smartnodeblsprivkey= >> ~/.yerbascore/yerbas.conf
echo rpcport=1000 >> ~/.yerbascore/yerbas.conf
echo bind= >> ~/.yerbascore/yerbas.conf
cd ~/yerbas-build/
cat <(crontab -l) <(echo "@reboot sleep 20 && ~/yerbas-build/yerbasd -testnet") | crontab -
nano ~/.yerbascore/yerbas.conf 
