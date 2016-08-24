# oracle12c-vagrant
A vagrant box with Oracle 12c.

## Getting started
1. Clone this repository
2. Download the Oracle Database 12c binaries `linuxamd64_12c_database_1of2.zip` and `linuxamd64_12c_database_2of2.zip`
from http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html and unzip to `database/`
2b. Ensure you unzip into the same directory and they merge. There are some common directories in each.
3. Install Virtualbox
4. Install Vagrant
5. Install VirtualBox plugin `vagrant plugin install vagrant-vbguest`
6. Run `vagrant up`

## Connecting to Oracle
SID: `orcl`
Installation path: `/opt/oracle/`

All passwords are `password`.

## Known issues

1. On `vagrant up` if you experience this issue:
````
default: Error: Authentication failure. Retrying...
default: Error: Authentication failure. Retrying...
default: Error: Authentication failure. Retrying...
default: Error: Authentication failure. Retrying...
default: Error: Authentication failure. Retrying...
````
Then you may have hit a bug in vagrant 1.8.5. See
http://stackoverflow.com/questions/22922891/vagrant-ssh-authentication-failure

The solution is to:
````
vagrant ssh 
password: vagrant 
chmod 0600 ~/.ssh/authorized_keys
exit
````

then `vagrant reload`.

2. Once Oracle and the listener starts up, it may take a few moments until you are able to connect to the DB, eg via SQL Developer.

