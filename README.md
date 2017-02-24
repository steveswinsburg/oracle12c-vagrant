# oracle12c-vagrant
A vagrant box that provisions Oracle 12c automatically, using only Vagrant and a shell script.

## Getting started
* Clone this repository
* Download Oracle Linux Base Box from [here](http://cloud.terry.im/vagrant/oraclelinux-7-x86_64.box)
* Move the base box to base-box directory
* Download the Oracle Database 12c binaries from http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html and unzip to `database/` 
  * `linuxamd64_12102_database_1of2.zip`
  * `linuxamd64_12102_database_2of2.zip` 
* Ensure you unzip into the same directory and they merge. There are some common directories in each. On the commandline, you can run `unzip '*.zip'` to do this for you.
* Install Virtualbox
* Install Vagrant
* Install VirtualBox plugin `vagrant plugin install vagrant-vbguest`
* Run `vagrant up`
*  6. The first time you run this it will provision everything and may take a while. Ensure you have a good internet connection!
* Connect to the database.
* You can shutdown the box via the usual `vagrant halt` and the start it up again via `vagrant up`.
    9. Note that on the next `vagrant up`, the box will automatically update the VirtualBox Guest Additions.

## Connecting to Oracle
* Hostname: `localhost`
* Port: `1521`
* SID: `orcl`
* All passwords are `welcome1`.

## Other info

* If you need to, you can connect to the machine via `vagrant ssh`.
* You can `sudo su - oracle` to switch to the oracle user.
* The Oracle installation path is `/opt/oracle/`
* On the guest OS, the directory `/vagrant` is a shared folder and maps to wherever you have this file checked out.

## Known issues
### Connection time after startup
Once Oracle and the listener starts up, it may take a few moments until you are able to connect to the DB, eg via SQL Developer.
