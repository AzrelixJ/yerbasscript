cd yerbas-build/
./yerbas-cli stop
cd ../
rm -r yerbas-build
wget https://github.com/The-Yerbas-Endeavor/yerbas/releases/download/v3.1.4.20/yerbas-arm64-v3.1.4.20.tar.gz
tar -xf yerbas-arm64-v3.1.4.20.tar.gz
rm yerbas-arm64-v3.1.4.20.tar.gz
cd yerbas-build
./yerbasd
rm ~/yerbupdateARM.sh
