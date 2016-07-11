# oracle12c-vagrant
A vagrant box with Oracle 12c.

## Getting started
1. Clone this repository
2. Download the Oracle Database 12c binaries `linuxamd64_12c_database_1of2.zip` and `linuxamd64_12c_database_2of2.zip`
from http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html and unzip to `database/`
3. Install Virtualbox
4. Install Vagrant
5. Install VirtualBox plugin `vagrant plugin install vagrant-vbguest`
6. Run `vagrant up`

## Connecting to Oracle
SID: `orcl`
Installation path: `/opt/oracle/`

All passwords are `password`.
