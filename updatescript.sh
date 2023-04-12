osType="$(uname -m)"
clear

echo "YYYYYYY       YYYYYYYEEEEEEEEEEEEEEEEEEEEEERRRRRRRRRRRRRRRRR   BBBBBBBBBBBBBBBBB               AAA                 SSSSSSSSSSSSSSS   "
echo "Y:::::Y       Y:::::YE::::::::::::::::::::ER::::::::::::::::R  B::::::::::::::::B             A:::A              SS:::::::::::::::S  "
echo "Y:::::Y       Y:::::YE::::::::::::::::::::ER::::::RRRRRR:::::R B::::::BBBBBB:::::B           A:::::A            S:::::SSSSSS::::::S  "
echo "Y::::::Y     Y::::::YEE::::::EEEEEEEEE::::ERR:::::R     R:::::RBB:::::B     B:::::B         A:::::::A           S:::::S     SSSSSSS  "
echo "YYY:::::Y   Y:::::YYY  E:::::E       EEEEEE  R::::R     R:::::R  B::::B     B:::::B        A:::::::::A          S:::::S              "
echo "   Y:::::Y Y:::::Y     E:::::E               R::::R     R:::::R  B::::B     B:::::B       A:::::A:::::A         S:::::S              "
echo "    Y:::::Y:::::Y      E::::::EEEEEEEEEE     R::::RRRRRR:::::R   B::::BBBBBB:::::B       A:::::A A:::::A         S::::SSSS           "
echo "     Y:::::::::Y       E:::::::::::::::E     R:::::::::::::RR    B:::::::::::::BB       A:::::A   A:::::A         SS::::::SSSSS      "
echo "      Y:::::::Y        E:::::::::::::::E     R::::RRRRRR:::::R   B::::BBBBBB:::::B     A:::::A     A:::::A          SSS::::::::SS    "
echo "       Y:::::Y         E::::::EEEEEEEEEE     R::::R     R:::::R  B::::B     B:::::B   A:::::AAAAAAAAA:::::A            SSSSSS::::S   "
echo "       Y:::::Y         E:::::E               R::::R     R:::::R  B::::B     B:::::B  A:::::::::::::::::::::A                S:::::S  "
echo "       Y:::::Y         E:::::E       EEEEEE  R::::R     R:::::R  B::::B     B:::::B A:::::AAAAAAAAAAAAA:::::A               S:::::S  "
echo "       Y:::::Y       EE::::::EEEEEEEE:::::ERR:::::R     R:::::RBB:::::BBBBBB::::::BA:::::A             A:::::A  SSSSSSS     S:::::S  "
echo "    YYYY:::::YYYY    E::::::::::::::::::::ER::::::R     R:::::RB:::::::::::::::::BA:::::A               A:::::A S::::::SSSSSS:::::S  "
echo "    Y:::::::::::Y    E::::::::::::::::::::ER::::::R     R:::::RB::::::::::::::::BA:::::A                 A:::::AS:::::::::::::::SS   "
echo "    YYYYYYYYYYYYY    EEEEEEEEEEEEEEEEEEEEEERRRRRRRR     RRRRRRRBBBBBBBBBBBBBBBBBAAAAAAA                   AAAAAAASSSSSSSSSSSSSSS     "


echo ""
echo ""
echo "Azrelix YERBAS update script ...."
echo ""
read -t 0.5 -p "Detecting system "
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.1 -p ". "



if [ $osType == "x86_64" ]
        then
        echo "$osType system detected."
elif [ $osType == "aarch64" ]
        then
        echo "$osType system detected."
else
        echo "ERROR ERROR ERROR...."
        echo ""
        echo "Script ending, no matching OS found"
        end
fi

read -t 0.5 -p "Stopping Yerbas Damon "
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.1 -p ". "
cd ~/yerbas-build
./yerbas-cli stop
cd ~
read -t 1 -p "Success."
echo " "

read -t 0.5 -p "Removing YerbasBuild folder "
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.1 -p ". "
rm -r yerbas-build
read -t 1 -p "Success."
echo " "

read -t 0.5 -p "Fetching yerbas v3.2.16 Salata Furca Deux "
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.1 -p ". "
if [ $osType == "x86_64" ]
        then
        wget https://github.com/The-Yerbas-Endeavor/yerbas/releases/download/v3.1.2.6/yerbas-ubuntu20-v3.1.2.6.tar.gz
elif [ $osType == "aarch64" ]
        then
        wget https://github.com/The-Yerbas-Endeavor/yerbas/releases/download/v3.1.2.6/yerbas-arm64-v3.1.2.6.tar.gz
fi
read -t 1 -p "Success."
echo " "

read -t 0.5 -p "Extracting files "
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.1 -p ". "
if [ $osType == "x86_64" ]
        then
        tar -xf yerbas-ubuntu20-v3.1.2.6.tar.gz
        rm yerbas-ubuntu20-v3.1.2.6.tar.gz
elif [ $osType == "aarch64" ]
        then
        tar -xf yerbas-arm64-v3.1.2.6.tar.gz
        rm yerbas-arm64-v3.1.2.6.tar.gz
fi
read -t 1 -p "Success."
echo " "

cd ~/.yerbascore
wget -q https://github.com/The-Yerbas-Endeavor/yerbas/releases/download/v3.1.2.6/powcache.dat
wget -q https://github.com/The-Yerbas-Endeavor/yerbas/releases/download/v3.1.2.6/bootstrap.zip
unzip bootstrap.zip
mv bootstrap/*
rm -r bootstrap
rm bootstrap.zip

read -t 0.5 -p "Restarting Yerbas Daemon "
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.1 -p ". "
cd ~/yerbas-build
./yerbasd
cd ~
read -t 1 -p "Success."
echo " "
echo " "
echo " "
echo " "
read -t 2 -p "UPDATE COMPLETE 420 4LIFE"
echo " "
