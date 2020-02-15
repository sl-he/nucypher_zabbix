#!/bin/sh
##### SCRIPT PARAMETERS #####
cd ~ && git clone https://github.com/sl-he/nucypher_zabbix.git
UPDATEFILEPATH=`find /home/*/ -type f -name git_update.sh`
if [ -z "$UPDATEFILEPATH" ]; then
   UPDATEFILEPATH=`find /root/ -type f -name git_update.sh`
else
   HOME1=`find /home/*/ -type f -name git_update.sh`
fi
USR=`find /home/*/.local/share/nucypher/ -type f -name ursula.json | awk -F "/" '{print $3}'`
if [ -z "$USR" ]; then
   USR1="root"
else
   USR1=$USR
fi
crontab -l | { cat; echo "*/5 * * * * su $USR1 -c 'cd ~ && source nucypher-venv/bin/activate && nucypher status stakers --provider ~/.ethereum/goerli/geth.ipc --network cassandra > /tmp/nucypher.tmp && cp /tmp/nucypher.tmp /tmp/nucypher.txt'"; } | crontab -
crontab -l | { cat; echo "1 0 * * * $UPDATEFILEPATH"; } | crontab -
mkdir -p /etc/zabbix/scripts
curl -s https://raw.githubusercontent.com/sl-he/nucypher_zabbix/master/geth.sh > /etc/zabbix/scripts/geth.sh
curl -s https://raw.githubusercontent.com/sl-he/nucypher_zabbix/master/nucypher-stats.sh > /etc/zabbix/scripts/nucypher-stats.sh
curl -s https://raw.githubusercontent.com/sl-he/nucypher_zabbix/master/nucypher-version.sh > /etc/zabbix/scripts/nucypher-version.sh
curl -s https://raw.githubusercontent.com/sl-he/nucypher_zabbix/master/nucypher.conf > /etc/zabbix/zabbix_agentd.d/nucypher.conf
curl -s https://raw.githubusercontent.com/sl-he/nucypher_zabbix/master/zabbix_agentd.conf  > /etc/zabbix/zabbix_agentd.conf
chmod 700 /etc/zabbix/scripts/*.sh
service zabbix-agent restart
service zabbix-agent status
exit 0
