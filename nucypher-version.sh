#!/bin/sh
##### SCRIPT PARAMETERS #####
METRIC="$1"
USR=`find /home/*/.local/share/nucypher/ -type f -name ursula.json | awk -F "/" '{print $3}'`
if [ -z "$USR" ]; then
   HOME="/root"
else
   HOME="/home/$USR"
fi
##### RUN #####
NUCYPHERABOUTDIR=`find  $HOME/ -name "nucypher" -ls 2>/dev/null | egrep -o  "/(home || root).*site-packages/nucypher"`
NUCYPHERVERSIONLOCAL=`cat $NUCYPHERABOUTDIR/__about__.py | grep "__version__ =" | egrep -o '".*' | tr -d '"'`
NUCYPHERVERSIONGIT=`curl -s "https://api.github.com/repos/nucypher/nucypher/tags" | jq -r '.[0].name' | tr -d 'v'`
if [ "${METRIC}" = "nucypherversionlocal" ]; then
  echo $NUCYPHERVERSIONLOCAL
fi
if [ "${METRIC}" = "nucypherversiongit" ]; then
  echo $NUCYPHERVERSIONGIT
fi
exit 0
