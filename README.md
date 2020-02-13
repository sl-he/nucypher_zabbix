# nucypher_zabbix
## Zabbix Monitoring For NuCypher Masternode

## Shell scripts:
Very needed for monitoring NuCypher masternode in zabbix monitoring system

### geth.sh

This script calculates the **blockheight** value and passes it to zabbix agent. Zabbix parameter **geth.blockheight**.

### nucypher-stats.sh

This script calculates a lot of NuCypher masternode parameters like tokens, nodes amount, etc and passes it to zabbix agent.

### nucypher-version.sh

This script calculates a lot of NuCypher version parameters like local version and git version and passes it to zabbix agent. Zabbix parameters: **nucypher.version.local** and **nucypher.version.git**.

## Zabbix config file

### nucypher.conf

This file is include in addition to the main zabbix agent configuration file. It should be located in a directory with similar files described in the main configuration file by the parameter (example for Ubuntu Linux):

`Include=/etc/zabbix/zabbix_agentd.d/*.conf`

### crontab job
For correct work all of shell scripts need to have a this cron job:

`*/5 * * * * su $NUCYPHER_USER -c 'cd ~ && source nucypher-venv/bin/activate && nucypher status stakers --provider ~/.ethereum/goerli/geth.ipc --network cassandra > /tmp/nucypher.tmp && cp /tmp/nucypher.tmp /tmp/nucypher.txt'`

## Zabbix template files:

### Template Masternode NuCypher.xml

Main template for a lot of NuCypher parameters for Zabbix monitoring system

### Template Module FAST ICMP Ping.xml

Template for fast ICMP checks (needed for previous template).
