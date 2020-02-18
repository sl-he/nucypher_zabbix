#!/bin/sh
##### SCRIPT PARAMETERS #####
METRIC="$1"
CACHE_TTL="150"
USR=`find /home/*/.local/share/nucypher/ -type f -name ursula.json | awk -F "/" '{print $3}'`
if [ -z "$USR" ]; then
   HOME1="/root"
else
   HOME1="/home/$USR"
fi
IPC="$HOME1/.ethereum/goerli/geth.ipc"
ADDRESS=`cat $HOME1/.local/share/nucypher/ursula.json | jq .checksum_address| tr -d '"'`
STATSFILE=/tmp/nucypher.txt
CACHE_FILE="/tmp/nucypher.`echo $STATSFILE | md5sum | cut -d" " -f1`.cache"
EXEC_TIMEOUT="1"
NOW_TIME=`date '+%s'`

##### RUN #####
if [ -s "${CACHE_FILE}" ]; then
  CACHE_TIME=`stat -c %Y "${CACHE_FILE}"`
else
  CACHE_TIME=0
fi
DELTA_TIME=$(($NOW_TIME - $CACHE_TIME))

if [ $DELTA_TIME -lt $EXEC_TIMEOUT ]; then
  sleep $(($EXEC_TIMEOUT - $DELTA_TIME))
elif [ $DELTA_TIME -gt $CACHE_TTL ]; then
  cp $STATSFILE $CACHE_FILE
fi

NODESTOTAL=`cat $CACHE_FILE | grep Nickname | sort -u | wc -l`
NODESACTIVE=`cat $CACHE_FILE | grep Activity | grep Next | wc -l`
NODESPENDING=`cat $CACHE_FILE | grep Activity | grep Pending | wc -l`
NODESINACTIVE=`cat $CACHE_FILE | grep Activity | grep -v Pending | grep -v Next | wc -l`
TOKENSOWNED=`cat $CACHE_FILE | grep $ADDRESS -A 1 | egrep -o "Owned:\s+[0-9.]+" | awk '{print $2}'`
TOKENSSTAKED=`cat $CACHE_FILE | grep $ADDRESS -A 1 | egrep -o "Staked:\s+[0-9.]+" | awk '{print $2}'`
TOKENSDIFF=`echo $TOKENSOWNED-$TOKENSSTAKED | bc`
INDEX=`cat $CACHE_FILE | grep NU | egrep -o "Owned:\s+[0-9.]+" | awk '{print $2}'`
TOKENSTOTAL=`echo $INDEX | xargs | tr ' ' '+' | bc`
INDEX1=`cat $CACHE_FILE | grep -e "Next period confirmed" -e Pending -B3 | egrep -o "Staked:\s+[0-9.]+" | awk '{print $2}' | xargs | tr ' ' '+' | bc`
TOKENSACTIVETOTAL=`echo $INDEX1 | xargs | tr ' ' '+' | bc`
PERIOD=`echo $NOW_TIME / 86400 | bc`
GETDIRSIZE=`du -bs $HOME1/.ethereum | awk '{print $1}'`
URSULADIRSIZE=`du -bs $HOME1/.cache/nucypher | awk '{print $1}'`
URSULASTATUS=`cat $CACHE_FILE | grep $ADDRESS -A4 | egrep -o "Activity:\s+[a-zA-Z]+" | awk '{print $2}'`
if [ $URSULASTATUS = "Next" ]; then
   NODESTATUS=1
else
   NODESTATUS=0
fi
if  [ -d "/usr/data_backup" ]; then
  DATABACKUPDIRSIZE=`du -bs /usr/data_backup | awk '{print $1}'`
else
  DATABACKUPDIRSIZE="0"
fi

##### PARAMETERS #####
if [ "${METRIC}" = "nodestotal" ]; then
  echo $NODESTOTAL
  fi
if [ "${METRIC}" = "nodesactive" ]; then
  echo $NODESACTIVE
fi
if [ "${METRIC}" = "nodespending" ]; then
  echo $NODESPENDING
fi
if [ "${METRIC}" = "nodesinactive" ]; then
  echo $NODESINACTIVE
fi
if [ "${METRIC}" = "tokenstotal" ]; then
  echo $TOKENSTOTAL
fi
if [ "${METRIC}" = "tokensactivetotal" ]; then
  echo $TOKENSACTIVETOTAL
fi
if [ "${METRIC}" = "tokensowned" ]; then
  echo $TOKENSOWNED
fi
if [ "${METRIC}" = "tokensstaked" ]; then
  echo $TOKENSSTAKED
fi
if [ "${METRIC}" = "tokensdiff" ]; then
  echo $TOKENSDIFF
fi
if [ "${METRIC}" = "period" ]; then
  echo $PERIOD
fi
if [ "${METRIC}" = "gethdirsize" ]; then
  echo $GETDIRSIZE
fi
if [ "${METRIC}" = "ursuladirsize" ]; then
  echo $URSULADIRSIZE
fi
if [ "${METRIC}" = "databackupdirsize" ]; then
  echo $DATABACKUPDIRSIZE
fi
if [ "${METRIC}" = "nodestatus" ]; then
  echo $NODESTATUS
fi
#
exit 0
