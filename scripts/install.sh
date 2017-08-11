#!/bin/sh

# Note that if you change the ORACLE_HOME or ORACLE_BASE in the response files
# then you will also need to update this script

echo 'INSTALLER: Starting up'

# add a new swapfile of 3G and attach it
# total swap approx 4G
dd if=/dev/zero of=/swapfile bs=1024 count=3072000
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab

echo 'INSTALLER: Expanded swap'

# convert into Oracle Linux 7
curl -O https://linux.oracle.com/switch/centos2ol.sh
sh centos2ol.sh
rm /home/vagrant/centos2ol

echo 'INSTALLER: Now running Oracle Linux 6'

# install required libraries
yum install -y nano
yum install -y libaio
yum install -y libaio-devel
yum install -y kernel-headers
yum install -y kernel-devel

# get up to date
yum upgrade -y
yum update -y

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
echo "export ORACLE_BASE=/opt/oracle" >> /home/oracle/.bashrc \
 && echo "export ORACLE_HOME=/opt/oracle/product/12.1.0.2/dbhome_1" >> /home/oracle/.bashrc \
 && echo "export ORACLE_SID=orcl" >> /home/oracle/.bashrc \
 && echo "export PATH=\$PATH:\$ORACLE_HOME/bin" >> /home/oracle/.bashrc

echo 'INSTALLER: Environment variables set'

# install Oracle
su -l oracle -c "yes | /vagrant/database/runInstaller -silent -showProgress -ignorePrereq -waitforcompletion -responseFile /vagrant/ora-response/db_install.rsp"
/opt/oraInventory/orainstRoot.sh
/opt/oracle/product/12.1.0.2/dbhome_1/root.sh

echo 'INSTALLER: Oracle installed'

# To workaround an installer bug, we need to ensure a missing library is in place, then rebuild and relink
# The actual Oracle installation appears to work, however the logs show this:
# INFO: /usr/bin/ld: cannot find -ljavavm12
# Which then causes a compilation failure and the oracle binary (and several others) end up being 0 bytes
# Ref: http://ruleoftech.com/2016/problems-with-installing-oracle-db-12c-ee-ora-12547-tns-lost-contact
# Optionally:
# make -kf ins_reports60w.mk install (on CCMgr server)
# make -kf ins_forms60w.install (on Forms/Web server)
# And then to fix the error on relinking, reinstall Perl:
# Ref: https://dbasolved.com/2015/08/24/issue-with-perl-in-oracle_home-during-installs/

ORACLE_HOME=/opt/oracle/product/12.1.0.2/dbhome_1

# Reinstall Perl
wget http://www.cpan.org/src/5.0/perl-5.14.4.tar.gz -P /tmp/
tar -xzf /tmp/perl-5.14.4.tar.gz -C /tmp/
cd /tmp/perl-5.14.4
./Configure -des -Dprefix=$ORACLE_HOME/perl
make
make install
chown oracle:oinstall $ORACLE_HOME/perl

# Recompile and relink
su -l oracle -c "mv $ORACLE_HOME/rdbms/lib/config.o $ORACLE_HOME/rdbms/lib/config.o.bad"
su -l oracle -c "cp $ORACLE_HOME/javavm/jdk/jdk6/lib/libjavavm12.a $ORACLE_HOME/lib/"
su -l oracle -c "chown oracle:oinstall $ORACLE_HOME/lib/libjavavm12.a"
su -l oracle -c "make -f $ORACLE_HOME/rdbms/lib/ins_rdbms.mk install"
su -l oracle -c "make -f $ORACLE_HOME/network/lib/ins_net_server.mk install"
su -l oracle -c "make -kf $ORACLE_HOME/sqlplus/lib/ins_sqlplus.mk install"
su -l oracle -c "$ORACLE_HOME/bin/relink all"

echo 'INSTALLER: Oracle installation fixed and relinked'

# create listener via netca
su -l oracle -c "netca -silent -responseFile /vagrant/ora-response/netca.rsp"
echo 'INSTALLER: Listener created'

# create database
su -l oracle -c "dbca -silent -createDatabase -responseFile /vagrant/ora-response/dbca.rsp"
echo 'INSTALLER: Database created'

sed '$s/N/Y/' /etc/oratab | sudo tee /etc/oratab > /dev/null
echo 'INSTALLER: Oratab configured'

# configure systemd to start oracle instance on startup
sudo cp /vagrant/scripts/oracle-rdbms.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable oracle-rdbms
sudo systemctl start oracle-rdbms
echo "INSTALLER: Created and enabled oracle-rdbms systemd's service"

echo 'INSTALLER: Installation complete'
