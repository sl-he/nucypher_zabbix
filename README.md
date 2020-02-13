# nucypher_zabbix
## Zabbix Monitoring For NuCypher Masternode

Shell files needed for monitoring NuCypher masternode in zabbix monitoring system.

## crontab
For correct work all of shell scripts need to have a this cron job:

`*/5 * * * * su $NUCYPHER_USER -c 'cd ~ && source nucypher-venv/bin/activate && nucypher status stakers --provider ~/.ethereum/goerli/geth.ipc --network cassandra > /tmp/nucypher.tmp && cp /tmp/nucypher.tmp /tmp/nucypher.txt'`

## geth.sh

This script calculates the **blockheight** value and passes it to zabbix agent. Zabbix parameter **geth.blockheight**.

## nucypher-stats.sh

This script calculates a lot of NuCypher parameters and passes it to zabbix agent.
