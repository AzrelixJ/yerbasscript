#azrelix ARM install script


echo "Azrelix Yerbas ARM install Script"
echo " "
read -p "Enter username: " uname
read -p "Enter IP address: " ipaddy
read -p "Enter BLS private key: " blsprivkey

echo $uname
echo $ipaddy
echo $blsprivkey

sudo useradd -m "$uname" -p "test"

echo "rpcport=100"$uname


wget https://github.com/The-Yerbas-Endeavor/test/releases/download/test1/yerbas-arm64-.tar.gz
tar -xvf yerbas-arm64-.tar.gz
rm yerbas-arm64-.tar.gz
mkdir ~/.yerbascore && touch ~/.yerbascore/yerbas.conf
echo daemon=1 >> ~/.yerbascore/yerbas.conf
echo addnode=107.191.55.148 >> ~/.yerbascore/yerbas.conf
echo smartnodeblsprivkey=$blsprivkey >> ~/.yerbascore/yerbas.conf
echo rpcport= >> ~/.yerbascore/yerbas.conf
echo bind=$ipaddy >> ~/.yerbascore/yerbas.conf
cd ~/yerbas-build/
cat <(crontab -l) <(echo "@reboot sleep 20 && ~/yerbas-build/yerbasd -testnet") | crontab -
nano ~/.yerbascore/yerbas.conf 