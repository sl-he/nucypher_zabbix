#!/bin/sh
##### SCRIPT PARAMETERS #####
USR=`find /home/*/.local/share/nucypher/ -type f -name ursula.json | awk -F "/" '{print $3}'`
if [ -z "$USR" ]; then
   HOME1="/root"
else
   HOME1="/home/$USR"
fi
IPC="$HOME1/.ethereum/goerli/geth.ipc"

##### RUN #####
BLOCKHEIGHT=`geth --exec "eth.blockNumber" attach $IPC`
if [ "$BLOCKHEIGHT" = 0 ]; then
  BLOCKHEIGHT=`geth --exec eth.syncing attach $IPC | jq .currentBlock`
fi
  echo $BLOCKHEIGHT
exit 0
