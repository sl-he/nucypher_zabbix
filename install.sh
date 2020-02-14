#!/bin/sh
mkdir -p /etc/zabbix/scripts
cp ~/nucypher_zabbix/*.sh /etc/zabbix/scripts/
chmod 755 /etc/zabbix/scripts/*.sh
service zabbix-agent restart
