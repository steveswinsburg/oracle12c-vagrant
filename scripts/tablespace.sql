-- Create a tablespace in the host's filesystem so that we don't run out of space
CREATE TABLESPACE vagrant
DATAFILE
  '/vagrant/oradata/vagrant.dbf' SIZE 1000M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED
EXTENT MANAGEMENT
  LOCAL UNIFORM SIZE 128K
SEGMENT SPACE MANAGEMENT
  AUTO;
