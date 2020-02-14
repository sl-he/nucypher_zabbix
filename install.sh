#!/bin/sh
##### SCRIPT PARAMETERS #####
UPDATEFILEPATH=`find /home/*/ -type f -name git_update.sh`
if [ -z "$UPDATEFILEPATH" ]; then
   UPDATEFILEPATH=`find /root/ -type f -name git_update.sh`
else
   HOME1=`find /home/*/ -type f -name git_update.sh`
fi
crontab -l | { cat; echo "1 0 * * * $UPDATEFILEPATH"; } | crontab -
mkdir -p /etc/zabbix/scripts
cp ~/nucypher_zabbix/*.sh /etc/zabbix/scripts/
cp ~/nucypher_zabbix/zabbix_agentd.conf /etc/zabbix/
cp ~/nucypher_zabbix/nucypher.conf /etc/zabbix/zabbix_agentd.d/
chmod 755 /etc/zabbix/scripts/*.sh
service zabbix-agent restart
