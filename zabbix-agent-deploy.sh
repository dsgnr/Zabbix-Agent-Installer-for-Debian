#!/usr/bin/env bash
# @author: Daniel Hand
#!/bin/bash

##### Zabbix-agent install script for Debian


# Define colors for output
green=`tput setaf 2`


#while read line
#do
#echo -e "ssh root@$line\n" << EOF
echo "${green}============================================${reset}"
echo "${green}Fetching Debian repository files${reset}"
echo "${green}============================================${reset}"
wget http://repo.zabbix.com/zabbix/3.0/debian/pool/main/z/zabbix-release/zabbix-release_3.0-1+jessie_all.deb
sudo dpkg -i zabbix-release_3.0-1+jessie_all.deb
sudo apt-get update
sudo apt-get install zabbix-agent
echo "${green}============================================${reset}"
echo "${green}Installed Zabbix Agent${reset}"
echo "${green}============================================${reset}"

echo "${green}============================================${reset}"
echo "${green}Add allowed hosts${reset}"
echo "${green}============================================${reset}"

sed -i '95s|Server=127.0.0.1|Server=127.0.0.1,mon.wessex.cloud|' /etc/zabbix/zabbix_agentd.conf

echo "${green}============================================${reset}"
echo "${green}Adding pre-shared key${reset}"
echo "${green}============================================${reset}"

sed -i '321s|# TLSConnect=unencrypted|TLSConnect=psk|' /etc/zabbix/zabbix_agentd.conf
sed -i '332s|# TLSAccept=unencrypted|TLSAccept=psk|' /etc/zabbix/zabbix_agentd.conf
sed -i '382s|# TLSPSKIdentity=|TLSPSKIdentity=psk|' /etc/zabbix/zabbix_agentd.conf
sed -i '389s|# TLSPSKFile=|TLSPSKFile=/etc/zabbix/zabbix_agentd.psk|' /etc/zabbix/zabbix_agentd.conf
echo "lpl2cYjegL09U1OA31G6dXC2" > /etc/zabbix/zabbix_agentd.psk

echo "${green}============================================${reset}"
echo "${green}pre-shared keys added${reset}"
echo "${green}============================================${reset}"
echo "${green}Restarting zabbix-agent${reset}"
echo "${green}============================================${reset}"
service zabbix-agent restart
echo "${green}============================================${reset}"
echo "${green}done!${reset}"
echo "${green}============================================${reset}"
#EOF

#done <hosts.txt
