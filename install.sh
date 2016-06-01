#!/bin/sh

# convert into Oracle Linux 6
curl -O https://linux.oracle.com/switch/centos2ol.sh
sh centos2ol.sh
yum upgrade -y

# fix locale warning
echo LANG=en_US.utf-8 >> /etc/environment
echo LC_ALL=en_US.utf-8 >> /etc/environment

# install Oracle Database prereq packages
yum install -y oracle-rdbms-server-12cR1-preinstall

# install UEK kernel
yum install -y elfutils-libs
yum update -y --enablerepo=ol6_UEKR3_latest
yum install -y kernel-uek-devel --enablerepo=ol6_UEKR3_latest
grubby --set-default=/boot/vmlinuz-3.8*

# confirm
cat /etc/oracle-release