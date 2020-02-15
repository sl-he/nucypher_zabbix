#!/bin/sh
#Replace $BOT_TOKEN to your REAL bot token
#Paste this script to alertscripts directory in zabbix config directory
TOKEN='$BOT_TOKEN'
if [ $# -ne 3 ] ; then echo 'FAIL: Params not defined.' && echo 'Usage: zabbix-telegram.sh TelegramID Subject Message' && exit 1 ; fi
CHAT_ID="$1"
SUBJECT="$2"
MESSAGE="$3"
curl -s --header 'Content-Type: application/json' --request 'POST' --data "{\"chat_id\":\"${CHAT_ID}\",\"text\":\"${SUBJECT}\n${MESSAGE}\"}" "https://api.telegram.org/bot${TOKEN}/sendMessage" | grep -q '"ok":false,'
if [ $? -eq 0 ] ; then exit 1 ; fi
