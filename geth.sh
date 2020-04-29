#!/bin/sh
##### SCRIPT PARAMETERS #####
METRIC="$1"
USR=`find /home/*/.local/share/nucypher/ -type f -name ursula.json | awk -F "/" '{print $3}'`
if [ -z "$USR" ]; then
   HOME1="/root"
else
   HOME1="/home/$USR"
fi
WORKERADDRESS=`cat $HOME1/.local/share/nucypher/ursula.json | jq .worker_address| tr -d '"'`
STAKERADDRESS=`cat $HOME1/.local/share/nucypher/ursula.json | jq .checksum_address| tr -d '"'`
##### RUN #####
if [ "${METRIC}" = "workerethbalance" ]; then
  WORKERETHBALANCE=`python /etc/zabbix/scripts/check_balance.py $WORKERADDRESS`
  echo $WORKERETHBALANCE
fi
if [ "${METRIC}" = "stakerethbalance" ]; then
  STAKERETHBALANCE=`python /etc/zabbix/scripts/check_balance.py $STAKERADDRESS`
  echo $STAKERETHBALANCE
fi
exit 0
