
osType="$(uname -m)"
COIN_DAEMON='yerbasd'
COIN_NAME='YERBAS'
COIN_CLI='yerbas-cli'
COIN_URL='https://github.com/The-Yerbas-Endeavor/yerbas/releases/download/v3.1.2.6/'
COIN_URL_ARM='yerbas-arm64-v3.1.2.6.tar.gz'
COIN_URL_UBUNTU='yerbas-ubuntu20-v3.1.2.6.tar.gz'
COIN_URL_POWER='powcache.dat'
COIN_URL_BOOT='bootstrap.zip'
COIN_VERSION_NAME='v3.1.2.6 -- Salata Furca Deux'
NODE_IP=''
YG='\033[0;32m'
CN='\033[0m'
RED='\033[0;31m'



function yerbas_title() {
echo -e "${YG}YYYYYYY       YYYYYYYEEEEEEEEEEEEEEEEEEEEEERRRRRRRRRRRRRRRRR   BBBBBBBBBBBBBBBBB               AAA                 SSSSSSSSSSSSSSS   "
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
echo -e "    YYYYYYYYYYYYY    EEEEEEEEEEEEEEEEEEEEEERRRRRRRR     RRRRRRRBBBBBBBBBBBBBBBBBAAAAAAA                   AAAAAAASSSSSSSSSSSSSSS     ${CN}"


echo ""
echo ""
echo "YERBAS install script .... created and maintained by Azrelix"
echo ""

}


function therest() {
read -t 0.5 -p "Detecting system "
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.1 -p ". "



if [ $osType == "x86_64" ]
        then
        echo -e "${YG}$osType system detected.${CN}"
elif [ $osType == "aarch64" ]
        then
        echo -e "${YG}$osType system detected.${CN}"
else
        echo -e "${RED}ERROR ERROR ERROR...."
        echo ""
        echo -e "Script ending, no matching OS found${CN}"
        end
fi

read -t 0.5 -p "Stopping Yerbas Damon "
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.1 -p "."
cd ~/yerbas-build
./$COIN_CLI stop
cd ~
read -t 1 -p " "
echo -e "${YG}Success.${CN}"
echo " "

read -t 0.5 -p "Removing YerbasBuild folder "
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.1 -p ". "
rm -r yerbas-build
read -t 1 -p "Success."
echo " "

read -t 0.5 -p "Fetching  $COIN_VERSION_NAME"
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.1 -p ". "
if [ $osType == "x86_64" ]
        then
        wget -q $COIN_URL$COIN_URL_UBUNTU
elif [ $osType == "aarch64" ]
        then
        wget -q $COIN_URL$COIN_URL_ARM
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
        tar -xf $COIN_URL_UBUNTU
        rm $COIN_URL_UBUNTU
elif [ $osType == "aarch64" ]
        then
        tar -xf $COIN_URL_ARM
        rm $COIN_URL_ARM
fi
read -t 1 -p "Success."
echo " "

sudo apt-get install -qq unzip

cd ~/.yerbascore
wget -q $COIN_URL$COIN_URL_POWER
wget -q $COIN_URL$COIN_URL_BOOT
unzip $COIN_URL_BOOT
mv bootstrap/*
rm -r bootstrap
rm $COIN_URL_BOOT

read -t 0.5 -p "Restarting Yerbas Daemon "
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.5 -p "."
read -t 0.1 -p ". "
cd ~/yerbas-build
./COIN_DAEMON
cd ~
read -t 1 -p "Success."
echo " "
echo " "
echo " "
echo " "
read -t 2 -p "UPDATE COMPLETE ... 420 4LIFE"
echo " "

}

#MAIN

clear
yerbas_title

therest