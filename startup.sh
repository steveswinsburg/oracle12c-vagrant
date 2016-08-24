#!/bin/sh
echo 'STARTUP: Starting Oracle'
echo "startup;" > /vagrant/startup.sql
su -l oracle -c "sqlplus / as sysdba @/vagrant/startup.sql"
su -l oracle -c "lsnrctl start"
rm /vagrant/startup.sql