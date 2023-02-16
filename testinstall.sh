#azrelix ARM install script

wget https://github.com/The-Yerbas-Endeavor/test/releases/download/test1/yerbas-arm64-.tar.gz
tar -xvf yerbas-arm64-.tar.gz
mkdir ~/.yerbascore && touch ~/.yerbascore/yerbas.conf
echo daemon=1 >> ~/.yerbascore/yerbas.conf
echo addnode=107.191.55.148 >> ~/.yerbascore/yerbas.conf
echo smartnodeblsprivkey= >> ~/.yerbascore/yerbas.conf
echo bind= >> ~/.yerbascore/yerbas.conf
cd ~/.yerbcore/
nano yerbas.conf 
