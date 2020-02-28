#!/bin/sh
##### SCRIPT PARAMETERS #####
METRIC="$1"
USR=`find /home/*/.local/share/nucypher/ -type f -name ursula.json | awk -F "/" '{print $3}'`
if [ -z "$USR" ]; then
   HOME1="/root"
else
   HOME1="/home/$USR"
fi
##### RUN #####
NU_ABOUT_PATH=`find  $HOME1/ -user $USR -type f -name "__about__.py" -ls 2>/dev/null | grep site-packages/nucypher | egrep -o "/.*"`
NUCYPHERVERSIONLOCAL=`cat $NU_ABOUT_PATH | grep "__version__ =" | egrep -o '".*' | tr -d '"'`
NUCYPHERVERSIONGIT=`curl -s "https://api.github.com/repos/nucypher/nucypher/tags" | jq -r '.[0].name' | tr -d 'v'`
if [ "${METRIC}" = "nucypherversionlocal" ]; then
  echo $NUCYPHERVERSIONLOCAL
fi
if [ "${METRIC}" = "nucypherversiongit" ]; then
  echo $NUCYPHERVERSIONGIT
fi
exit 0
