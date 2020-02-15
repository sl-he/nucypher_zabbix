## Zabbix Monitoring For NuCypher Masternode

### How to install:
`curl -s https://raw.githubusercontent.com/sl-he/nucypher_zabbix/master/install.sh | bash`

## Shell scripts
Very needed for monitoring NuCypher masternode in zabbix monitoring system

### geth.sh
This script calculates the **blockheight** value and passes it to zabbix agent. Zabbix parameter **geth.blockheight**.

### git_update.sh
Scripts for cheking for new release from github and update all scripts.
#### Usage:
`curl -s https://raw.githubusercontent.com/sl-he/nucypher_zabbix/master/git_update.sh | bash`

### install.sh
Script for install other scripts
#### Usage:
`curl -s https://raw.githubusercontent.com/sl-he/nucypher_zabbix/master/install.sh | bash`

### nucypher-stats.sh
This script calculates a lot of NuCypher masternode parameters like tokens, nodes amount, etc and passes it to zabbix agent.
#### Usage:
`nucypher-stats.sh "$PARAMETER"`

### nucypher-version.sh
This script calculates a lot of NuCypher version parameters like local version and git version and passes it to zabbix agent. Zabbix parameters: **nucypher.version.local** and **nucypher.version.git**.
#### Usage:
`nucypher-version.sh "$PARAMETER"`

### zabbix-telegram.sh

#### Usage:
`zabbix-telegram.sh TelegramID Subject Message`
## Zabbix config file

### nucypher.conf

This file is include in addition to the main zabbix agent configuration file. It should be located in a directory with similar files described in the main configuration file by the parameter (example for Ubuntu Linux):

`Include=/etc/zabbix/zabbix_agentd.d/*.conf`

## Zabbix template files

### Template Module FAST ICMP Ping.xml

Template for fast ICMP checks. Must be installed first, needed for next template.

### Template Masternode NuCypher.xml

Main template for a lot of NuCypher parameters for Zabbix monitoring system
