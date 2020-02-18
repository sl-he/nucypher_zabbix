#!/bin/sh
##### SCRIPT PARAMETERS #####
METRIC="$1"
CACHE_TTL="150"
STATSFILE=/tmp/worklock.txt
CACHE_FILE="/tmp/worklock.`echo $STATSFILE | md5sum | cut -d" " -f1`.cache"
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
WEIETHPOOL=`cat $CACHE_FILE | grep "ETH Pool" | egrep -o "[0-9.]+$"`
ETHPOOL=`echo $WEIETHPOOL / 1000000000000000000 | bc -l`
WEIETHSUPPLY=`cat $CACHE_FILE | grep "ETH Supply" | egrep -o "[0-9.]+$"`
ETHSUPPLY=`echo $WEIETHSUPPLY / 1000000000000000000 | bc -l`
LOTSIZE=`cat $CACHE_FILE | grep "Lot Size" | egrep -o "[0-9.]+\s+NU" | awk '{print $1}'`
UNCLAIMEDTOKENS=`cat $CACHE_FILE | grep "Unclaimed Tokens" | egrep -o "[0-9.]+$"`
BOOSTINGREFUND=`cat $CACHE_FILE | grep "Boosting Refund" | egrep -o "[0-9.]+$"`
SLOWINGREFUND=`cat $CACHE_FILE | grep "Slowing Refund" | egrep -o "[0-9.]+$"`
REFUNDRATE=`cat $CACHE_FILE | grep "Refund Rate" | egrep -o "[0-9.]+$"`
DEPOSITRATE=`cat $CACHE_FILE | grep "Deposit Rate" | egrep -o "[0-9.]+$"`
TOTALBID=`cat $CACHE_FILE | grep "Total Bid" | egrep -o "[0-9.]+$"`
AVAILABLEREFUND=`cat $CACHE_FILE | grep "Available Refund" | egrep -o "[0-9.]+$"`
WORKCOMPLETED=`cat $CACHE_FILE | grep "Completed Work" | egrep -o "[0-9.]+$"`
WORKREMAINING=`cat $CACHE_FILE | grep "Remaining Work" | egrep -o "[0-9.]+$"`
WORKREFUNDED=`cat $CACHE_FILE | grep "Refunded Work" | egrep -o "[0-9.]+$"`
##### PARAMETERS #####
if [ "${METRIC}" = "ethpool" ]; then
  echo $ETHPOOL
fi
if [ "${METRIC}" = "ethsupply" ]; then
  echo $ETHSUPPLY
fi
if [ "${METRIC}" = "lotsize" ]; then
  echo $LOTSIZE
fi
if [ "${METRIC}" = "unclaimedtokens" ]; then
  echo $UNCLAIMEDTOKENS
fi
if [ "${METRIC}" = "boostingrefund" ]; then
  echo $BOOSTINGREFUND
fi
if [ "${METRIC}" = "slowingrefund" ]; then
  echo $SLOWINGREFUND
fi
if [ "${METRIC}" = "refundrate" ]; then
  echo $REFUNDRATE
fi
if [ "${METRIC}" = "depositrate" ]; then
  echo $DEPOSITRATE
fi
if [ "${METRIC}" = "totalbid" ]; then
  echo $TOTALBID
fi
if [ "${METRIC}" = "availablerefund" ]; then
  echo $AVAILABLEREFUND
fi
if [ "${METRIC}" = "workcompleted" ]; then
  echo $WORKCOMPLETED
fi
if [ "${METRIC}" = "workremaining" ]; then
  echo $WORKREMAINING
fi
if [ "${METRIC}" = "workrefunded" ]; then
  echo $WORKREFUNDED
fi
exit 0
