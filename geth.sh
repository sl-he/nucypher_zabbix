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
  WEIWORKERETHBALANCE=`curl -s 'https://api-goerli.etherscan.io/api?module=account&action=balance&address='$WORKERADDRESS'&tag=latest' -H 'dnt: 1' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36' | jq .result | tr -d '"'`
  WORKERETHBALANCE=`echo $WEIWORKERETHBALANCE / 1000000000000000000 | bc -l`
  echo $WORKERETHBALANCE
fi
if [ "${METRIC}" = "stakerethbalance" ]; then
  WEISTAKERETHBALANCE=`curl -s 'https://api-goerli.etherscan.io/api?module=account&action=balance&address='$STAKERADDRESS'&tag=latest' -H 'dnt: 1' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36' | jq .result | tr -d '"'`
  STAKERETHBALANCE=`echo $WEISTAKERETHBALANCE / 1000000000000000000 | bc -l`
  echo $STAKERETHBALANCE
fi
exit 0
