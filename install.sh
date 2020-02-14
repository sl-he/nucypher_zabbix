#!/bin/sh
mkdir -p /etc/zabbix/scripts
cp ~/nucypher_zabbix/*.sh /etc/zabbix/scripts/
cp ~/nucypher_zabbix/zabbix_agentd.conf /etc/zabbix/
cp ~/nucypher_zabbix/nucypher.conf /etc/zabbix/zabbix_agentd.d/
chmod 755 /etc/zabbix/scripts/*.sh
service zabbix-agent restart
