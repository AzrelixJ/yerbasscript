
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
INS_TYPE=''
File=".err.log"

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
        echo "$COIN_NAME install script .... created and maintained by Azrelix"
        echo ""
        echo ""

}

function dots(){
        read -t 0.5 -p "."
        read -t 0.5 -p "."
        read -t 0.5 -p "."
        read -t 0.1 -p ". "
}


function install_type(){
        echo "Select option"
        echo "  1) Install new $COIN_NAME node"
        echo "  2) Update existing $COIN_NAME node"
        read n
        case $n in
        1) INS_TYPE='new';;
        2) INS_TYPE='update';;
        *) echo -e "${RED}invalid option selected.. :( try again${CN}"  ;install_type;
        esac
        echo " "
}


function therest() {
        read -t 0.5 -p "Detecting system "
        dots
        if [ $osType == "x86_64" ]
                then
                echo -e "${YG}$osType system detected.${CN}"
        elif [ $osType == "aarch64" ]
                then
                echo -e "${YG}$osType system detected.${CN}"
        else
                echo -e "${RED}ERROR ERROR ERROR...."
                echo ""
                echo -e "SCRIPT FAILED... NO MATCHING OS FOUND found${CN}"
                end
        fi
}

function uninstall_old() {
        if [ $INS_TYPE == "update" ]
                then
                read -t 0.5 -p "Stopping Yerbas Damon "
                dots
                cd ~/yerbas-build &> ~/.err.log
                if ! grep -q "No such file or directory" "$File"; then
                        ./$COIN_CLI stop &> ~/.err.log
                        cd ~
                        if ! grep -q "error:" "$File"; then
                                echo -e "${YG}Success.${CN}"
                        else
                                echo -e "${RED}Failed.  Daemon not running, attempting to continue.${CN}"
                        fi
                        echo " "
                        read -t 0.5 -p "Removing YerbasBuild folder "
                        dots
                        rm -r yerbas-build &> ~/.err.log
                        if ! grep -q "cannot remove 'yerbas-build'" "$File"; then
                                echo -e "${YG}Success.${CN}"
                        else
                                echo -e "${RED}Failed. Unable to remove yerbas-build folder, either wrong location or yerbas not installed, attempting to continue.${CN}"
                        fi
                else
                        echo -e "${RED}yerbas-build directory not found, either wrong location or yerbas not installed, attempting to continue.${CN}"
                fi
                
                echo " "
        fi
}

function download_node() {
        read -t 0.5 -p "Fetching  $COIN_NAME $COIN_VERSION_NAME"
        dots

        if [ $osType == "x86_64" ]
                then
                wget -q $COIN_URL$COIN_URL_UBUNTU
        elif [ $osType == "aarch64" ]
                then
                wget -q $COIN_URL$COIN_URL_ARM
        fi
        echo -e "${YG}Success.${CN}"
        echo " "
        read -t 0.5 -p "Extracting files "
        dots
        if [ $osType == "x86_64" ]
                then
                tar -xf $COIN_URL_UBUNTU
                rm $COIN_URL_UBUNTU
        elif [ $osType == "aarch64" ]
                then
                tar -xf $COIN_URL_ARM
                rm $COIN_URL_ARM
        fi
        echo -e "${YG}Success.${CN}"
        echo " "

}

function power_cache() {



        
}



function other() {
        sudo apt-get install -qq unzip
        cd ~/.yerbascore
        wget -q $COIN_URL$COIN_URL_POWER
        wget -q $COIN_URL$COIN_URL_BOOT
        unzip $COIN_URL_BOOT
        mv bootstrap/*
        rm -r bootstrap
        rm $COIN_URL_BOOT
        }
        function restart_daemon() {
        read -t 0.5 -p "Restarting Yerbas Daemon "
        dots
        cd ~/yerbas-build
        ./COIN_DAEMON
        cd ~
        echo -e "${YG}Success.${CN}"
        dots
        read -t 2 -p "${YG}UPDATE COMPLETE ... 420 4 LIFE${CN}"
        echo " "
}

#MAIN

clear

yerbas_title
install_type
uninstall_old
download_node

#therest