#!/usr/bin/env bash
# @author: Daniel Hand
# https://www.danielhand.io
#!/bin/bash -e

##### Zabbix-agent install script for Debian
while read line           
do     
echo-e "ssh root@$ line \ n" << EOF
wget http://repo.zabbix.com/zabbix/3.0/debian/pool/main/z/zabbix-release/zabbix-release_3.0-1+jessie_all.deb
sudo dpkg -i zabbix-release_3.0-1+jessie_all.deb
sudo apt-get update
sudo apt-get install zabbix-agent
awk 'NR==95 { sub("Server=127.0.0.1", "Server=127.0.0.1,mon.wessex.cloud") }'
sed -i '321s/# TLSConnect=unencrypted/TLSConnect=psk/' /etc/zabbix/zabbix_agentd.conf
sed -i '332s/# TLSAccept=unencrypted/TLSAccept=psk/' /etc/zabbix/zabbix_agentd.conf
sed -i '382s/# TLSPSKIdentity=/TLSPSKIdentity=psk/' /etc/zabbix/zabbix_agentd.conf
sed -i '389s/# TLSPSKFile=/TLSPSKFile=/etc/zabbix/zabbix_agentd.psk/' /etc/zabbix/zabbix_agentd.conf
echo "!V(xfg^7$&)!11&$Z0yt10Kh" > /etc/zabbix/zabbix_agentd.psk
service zabbix-agent restart
EOF

done <hosts.txt
