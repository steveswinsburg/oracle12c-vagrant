#!/bin/sh

echo 'INSTALLER: Starting up'

# convert into Oracle Linux 6
curl -O https://linux.oracle.com/switch/centos2ol.sh
sh centos2ol.sh

echo 'INSTALLER: Now running Oracle Linux 6'

# get up to date
yum install -y MAKEDEV
yum install -y nano
yum upgrade -y

echo 'INSTALLER: System updated'

# fix locale warning
yum reinstall -y glibc-common
echo LANG=en_US.utf-8 >> /etc/environment
echo LC_ALL=en_US.utf-8 >> /etc/environment

echo 'INSTALLER: Locale set'

# install Oracle Database prereq packages
yum install -y oracle-rdbms-server-12cR1-preinstall

echo 'INSTALLER: Oracle preinstall complete'

# create directories
mkdir /opt/oracle /opt/oraInventory /opt/datafile
chown oracle:oinstall -R /opt

echo 'INSTALLER: Oracle directories created'

# set environment variables
echo "export ORACLE_BASE=/opt/oracle" >> /home/oracle/.bash_profile \
 && echo "export ORACLE_HOME=/opt/oracle/product/12.1.0.2/dbhome_1" >> /home/oracle/.bash_profile \
 && echo "export ORACLE_SID=orcl" >> /home/oracle/.bash_profile \
 && echo "export PATH=\$PATH:\$ORACLE_HOME/bin" >> /home/oracle/.bash_profile

echo 'INSTALLER: Environment variables set'

# install Oracle
sudo su - oracle
/vagrant/database/runInstaller -silent -showProgress -ignorePrereq -responseFile /vagrant/db_install.rsp
exit
sudo /opt/oraInventory/orainstRoot.sh
sudo /opt/oracle/product/12.1.0.2/dbhome_1/root.sh

echo 'INSTALLER: Oracle installed'

# create listener via netca
sudo su - oracle
netca -silent -responseFile $ORACLE_HOME/assistants/netca/netca.rsp

echo 'INSTALLER: Listener created'


# create database
dbca -silent -createDatabase -responseFile /vagrant/dbca.rsp

echo 'INSTALLER: Database created'

echo 'INSTALLER:Installation complete'
echo '!!!!!!!!!!!! woot !!!!!!!!!!!!!'