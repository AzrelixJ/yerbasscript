#azrelix UBUNTU install script


cd ~ 
wget https://github.com/The-Yerbas-Endeavor/yerbas/releases/download/v2.1.1.4/yerbas-arm64-2.1.1.4.tar.gz
tar -xf yerbas-arm64-2.1.1.4.tar.gz
rm yerbas-arm64-2.1.1.4.tar.gz
mkdir ~/.yerbascore 
touch ~/.yerbascore/yerbas.conf
echo daemon=1 >> ~/.yerbascore/yerbas.conf 
echo rpcallowip=127.0.0.1 >> ~/.yerbascore/yerbas.conf 
echo rpcport=8482 >> ~/.yerbascore/yerbas.conf 
echo rpcuser= >> ~/.yerbascore/yerbas.conf 
echo rpcpass= >> ~/.yerbascore/yerbas.conf 
echo listen=1 >> ~/.yerbascore/yerbas.conf 
echo server=1 >> ~/.yerbascore/yerbas.conf 
echo bind=10.0.0.63 >> ~/.yerbascore/yerbas.conf 
echo port=15420 >> ~/.yerbascore/yerbas.conf 
echo externalip=152.69.188.81 >> ~/.yerbascore/yerbas.conf 
echo smartnodeblsprivkey= >> ~/.yerbascore/yerbas.conf 

cd .yerbascore
wget https://github.com/The-Yerbas-Endeavor/yerbas/releases/download/v2.1.1.4/powcache.dat
cd ~/yerbas-build
./yerbasd
