#!/bin/sh
##### SCRIPT PARAMETERS #####
USR=`find /home/*/.local/share/nucypher/ -type f -name ursula.json | awk -F "/" '{print $3}'`
if [ -z "$USR" ]; then
   HOME="/root"
else
   HOME="/home/$USR"
fi
IPC="$HOME/.ethereum/goerli/geth.ipc"

##### RUN #####
BLOCKHEIGHT=`geth --exec "eth.blockNumber" attach $IPC`
if [ "$BLOCKHEIGHT" = 0 ]; then
  BLOCKHEIGHT=`geth --exec eth.syncing attach $IPC | jq .currentBlock`
fi
  echo $BLOCKHEIGHT
exit 0
