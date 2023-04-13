
osType="$(uname -m)"
COIN_DAEMON='yerbasd'
COIN_FOLDER='yerbas-build'
COIN_CONF_FOLDER='.yerbascore'
COIN_NAME='YERBAS'
COIN_CLI='yerbas-cli'
COIN_URL='https://github.com/The-Yerbas-Endeavor/yerbas/releases/download/v3.1.2.6/'
COIN_URL_ARM='yerbas-arm64-v3.1.2.6.tar.gz'
COIN_URL_UBUNTU='yerbas-ubuntu20-v3.1.2.6.tar.gz'
COIN_URL_POWER='powcache.dat'
COIN_URL_BOOT='bootstrap.zip'
COIN_VERSION_NAME='v3.1.2.6 -- Salata Furca Deux'
COIN_CONF_FILE='yerbas.conf'
COIN_PORT='15420'
NODE_IP=''
BLS_SECRET=''
INS_TYPE=''
File=".err.log"

YG='\033[0;32m'
CN='\033[0m'
RED='\033[0;31m'
BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"



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
        echo "     $COIN_NAME install script .... created and maintained by Azrelix"
        echo ""
        rm .err.log &>> ~/.err.log
        touch ~/.err.log

}

function dots(){
        sleep 0.5
        read -t 0.25 -p " ."
        read -t 0.25 -p "."
        read -t 0.25 -p "."
        read -t 0.25 -p ". "
}


function install_type(){
        echo -e "     ${CYAN}Select option"
        echo "       1) Install new $COIN_NAME node"
        echo -e "       2) Update existing $COIN_NAME node${CN}"
        read -p "     " n
        case $n in
        1) INS_TYPE='new';;
        2) INS_TYPE='update';;
        *) echo -e "     ${RED}invalid option selected.. :( try again${CN}"  ;install_type;
        esac
        echo " "
}


function detect_os() {
        echo -n "     Detecting system"
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
                echo -n "     Stopping $COIN_NAME Daemon"
                dots
                cd ~/$COIN_FOLDER &>> ~/.err.log
                cd ~
                if ! grep -q "No such file or directory" "$File"; then
                        cd ~/$COIN_FOLDER
                        ./$COIN_CLI stop &>> ~/.err.log
                        cd ~
                        if ! grep -q "error:" "$File"; then
                                echo -e "${YG}Success.${CN}"
                        else
                                echo -e "${RED}Failed.  Daemon not running, attempting to continue.${CN}"
                        fi
                        echo -n "     Removing $COIN_FOLDER folder "
                        dots
                        rm -r $COIN_FOLDER &>> ~/.err.log
                        if ! grep -q "cannot remove 'yerbas-build'" "$File"; then
                                echo -e "${YG}Success.${CN}"
                        else
                                echo -e "${RED}Failed. Unable to remove $COIN_FOLDER folder, either wrong location or $COIN_NAME not installed, attempting to continue.${CN}"
                        fi
                else
                        echo -e "${RED}$COIN_FOLDER directory not found, either wrong location or yerbas not installed, attempting to continue.${CN}"
                fi
        fi
}

function download_node() {
        echo -n "     Fetching $COIN_NAME $COIN_VERSION_NAME"
        dots

        if [ $osType == "x86_64" ]
                then
                wget -q $COIN_URL$COIN_URL_UBUNTU
        elif [ $osType == "aarch64" ]
                then
                wget -q $COIN_URL$COIN_URL_ARM
        fi
        echo -e "${YG}Success.${CN}"
        echo -n "     Extracting $COIN_NAME $COIN_VERSION_NAME"
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
        echo -n "     Cleaing up"
        dots
        echo -e "${YG}Success.${CN}"
        if [ $PC == 1 ]
                then
                cd ~
                mkdir $COIN_CONF_FOLDER &>> ~/.err.log
                cd $COIN_CONF_FOLDER
                echo -n "     Fetching $COIN_NAME $COIN_URL_POWER"
                dots
                wget -q $COIN_URL$COIN_URL_POWER
                echo -e "${YG}Success.${CN}"

        else
                echo "     Skipping $COIN_URL_POWER"
        fi

        if [ $BS == 1 ]
                then
                cd ~
                mkdir $COIN_CONF_FOLDER &>> ~/.err.log
                cd $COIN_CONF_FOLDER
                rm -r blocks &>> ~/.err.log
                rm -r chainstate &>> ~/.err.log
                rm -r evodb &>> ~/.err.log
                rm -r llmq &>> ~/.err.log
                echo -n "     Fetching $COIN_NAME $COIN_URL_BOOT"
                dots
                wget -q $COIN_URL$COIN_URL_BOOT
                echo -e "${YG}Success.${CN}"
                echo -n "     Unzipping $COIN_NAME $COIN_URL_BOOT"
                dots
                unzip -q $COIN_URL_BOOT
                rm $COIN_URL_BOOT
                echo -e "${YG}Success.${CN}"
                echo -n "     Moving $COIN_NAME bootstrap files to $COIN_CONF_FOLDER folder"
                dots
                mv bootstrap/* .
                rm -r bootstrap
                echo -e "${YG}Success.${CN}"

        else
                echo "     Skipping $COIN_URL_BOOT"
        fi

}

function power_cache() {
        echo -e "     ${CYAN}Download Power Cache?"
        echo "       1) Yes"
        echo -e "       2) No${CN}"
        read -p "     " n
        case $n in
        1) PC=1;;
        2) PC=2;;
        *) echo -e "     ${RED}invalid option selected.. :( try again${CN}"  ;power_cache;
        esac
        echo " "
}

function tx_reindex() {
        echo " "
        echo -e "     ${CYAN}Is txreindex required on Daemon start?"
        echo "       1) Yes"
        echo -e "       2) No${CN}"
        read -p "     " n
        case $n in
        1) TX=1;;
        2) TX=2;;
        *) echo -e "     ${RED}invalid option selected.. :( try again${CN}"  ;tx_reindex;
        esac
        echo " "
}

function add_to_cron() {
        echo " "
        echo -e "     ${CYAN}Add $COIN_NAME to Crontab? (this will start $COIN_NAME daemon on Boot)"
        echo "       1) Yes"
        echo -e "       2) No${CN}"
        read -p "     " n
        case $n in
        1) AC=1;;
        2) AC=2;;
        *) echo -e "     ${RED}invalid option selected.. :( try again${CN}"  ;add_to_cron;
        esac
        echo " "
}

function bootstrap() {
        echo -e "     ${CYAN}Download Bootstrap?"
        echo "       1) Yes"
        echo -e "       2) No${CN}"
        read -p "     " n
        case $n in
        1) BS=1;;
        2) BS=2;;
        *) echo -e "     ${RED}invalid option selected.. :( try again${CN}"  ;bootstrap;
        esac
        echo " "
}

function 4204life() {
        echo " "
        echo " "
        echo " "
        echo -e "     ${YG}INSTALLATION COMPLETE${CN}"
        echo " "
}

function start_daemon () {
        tx_reindex
        if [ $TX == 1 ]
        then
                echo -n "     Starting $COIN_NAME daemon with txindex enabled"
                dots
                cd ~/$COIN_FOLDER
                #./$COIN_DAEMON -txindex
                #add error catching if daemon doesnt start
                cd ~
                echo -e "${YG}Success.${CN}"
        else 
                        echo -n "     Starting $COIN_NAME daemon "
                dots
                cd ~/$COIN_FOLDER
                #./$COIN_DAEMON
                #add error catching if daemon doesnt start
                cd ~
                echo -e "${YG}Success.${CN}"
        fi
}

function node_settings () {
        echo " "
        echo -e "${CYAN}     (Press enter to skip)"
        read -p "     Enter node IP: " NODE_IP
        read -p "     Enter BLS secret Key: " BLS_SECRET
        echo -e "${CN} "
}

function update_config () {
        echo -n "     Updating $COIN_NAME config file"
        dots
        echo addnode=24.51.177.113:15420 >> ~/$COIN_CONF_FOLDER/$COIN_CONF_FILE
        echo addnode=65.20.114.24:15420 >> ~/$COIN_CONF_FOLDER/$COIN_CONF_FILE
        echo rpcallowip=127.0.0.1 >> ~/$COIN_CONF_FOLDER/$COIN_CONF_FILE
        echo listen=1 >> ~/$COIN_CONF_FOLDER/$COIN_CONF_FILE
        echo server=1 >> ~/$COIN_CONF_FOLDER/$COIN_CONF_FILE
        echo daemon=1 >> ~/$COIN_CONF_FOLDER/$COIN_CONF_FILE
        echo port=$COIN_PORT >> ~/$COIN_CONF_FOLDER/$COIN_CONF_FILE
        if [ $NODE_IP = "" ]
        else
                echo bind=$NODE_IP >> ~/$COIN_CONF_FOLDER/$COIN_CONF_FILE
        fi
        if [ $BLS_SECRET = "" ]
        else
                echo smartnodeblsprivkey=$BLS_SECRET >> ~/$COIN_CONF_FOLDER/$COIN_CONF_FILE
        fi
        echo -e "${YG}Success.${CN}"
}

function install_zip() {
        sudo apt-get install -qq unzip
}

function add_cron() {
        if [ $AC == 1 ]
                then
                echo -n "     Adding $COIN_NAME to crontab"
                dots
                cat <(crontab -l) <(echo "@reboot sleep 20 && ~/yerbas-build/yerbasd") | crontab -
                echo -e "${YG}Success.${CN}"
        fi
}

#MAIN

clear

yerbas_title
install_type
power_cache
bootstrap
detect_os
uninstall_old
download_node
node_settings
update_config
start_daemon
add_to_cron
add_cron

4204life