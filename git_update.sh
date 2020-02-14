#!/bin/sh
##### SCRIPT PARAMETERS #####
LOGFILE='/var/log/syslog'
DATE_TIME=`date '+%Y-%m-%d %H:%M:%S'`
LATESTRELEASE=`curl -s https://api.github.com/repos/sl-he/nucypher_zabbix/releases/latest | jq .tag_name| tr -d '"'`
UPDATEFILEPATH=`find /home/*/ -type f -name git_update.sh`
if [ -z "$UPDATEFILEPATH" ]; then
   UPDATEFILEPATH=`find /root/ -type f -name git_update.sh`
else
   HOME1=`find /home/*/ -type f -name git_update.sh`
fi
cat $UPDATEFILEPATH
GITREPODIR=`echo $UPDATEFILEPATH | rev | cut -d"/" -f2-  | rev`
cat $GITREPODIR
LOCALRELEASE=`cat $GITREPODIR/RELEASE`
##### RUN #####
if [ -z "$LATESTRELEASE" ] || [ "$LATESTRELEASE" == "$LOCALRELEASE" ]; then
echo "[$DATE_TIME git_update]    ==============================================================" >> $LOGFILE
echo "[$DATE_TIME git_update]==> Info: There is no New Update. Latest release is $LATESTRELEASE" >> $LOGFILE
echo "[$DATE_TIME git_update]    ==============================================================" >> $LOGFILE
exit;
else
echo "[$DATE_TIME git_update]    ==============================================================" >> $LOGFILE
echo "[$DATE_TIME git_update]==> Info: Starting Update nucypher_zabbix git repo to $LATESTRELEASE" >> $LOGFILE
echo "[$DATE_TIME git_update]    ==============================================================" >> $LOGFILE
cd $GITREPODIR && git pull
#cp $GITREPODIR/*.sh /etc/zabbix/scripts/
#cp $GITREPODIR/nucypher.conf /etc/zabbix/zabbix_agentd.d/
#chmod 755 /etc/zabbix/scripts/*.sh
#service zabbix-agent restart
fi
