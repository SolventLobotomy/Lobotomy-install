#!/bin/sh
pwd=$(pwd)
clear
if [ $(id -u) -eq 0 ]; then
	echo ''
	echo 'This is the Lobotomy Installer script.'
	echo 'This script is only tested with ubuntu 14'
	echo 'Php might have problems with ubuntu 16 or php 7'
	echo ''
	echo 'The only requirements for this script to work:'
	echo 'A local user with the name solvent or modify the install script.'
	echo 'Supervisor will start the required scripts for lobotomy.'
	echo ''
	echo 'This script installs supervisor.'
	echo ''
	echo 'Press any key to continue'
	echo ''
	read tmp
	
	echo "Enter password for mysql : "
	read mysqlpassword

	apt update
	echo "mysql-server-5.5 mysql-server/root_password password ${mysqlpassword}" | debconf-set-selections
	echo "mysql-server-5.5 mysql-server/root_password_again password ${mysqlpassword}" | debconf-set-selections

	apt install -y apache2 libapache2-mod-php5 mysql-server libapache2-mod-auth-mysql php5-mysql libmysqlclient-dev git python-all python-all-dev python-pyrex python-pip exiftool yara ssdeep libfuzzy-dev libfuzzy2 testdisk php5-curl samba unzip sleuthkit supervisor

	pip install distorm3 yara-python pycrypto pyinotify configobj MySQL-python python-magic python-dateutil psutil numpy bitstring pydeep
	pip install pip/construct-2.5.2-py2.py3-none-any.whl
	pip install pip/python-pefile_1.2.10.139.orig.tar.gz
	cd pip/pyssdeep/
	python setup.py build
	python setup.py install
	cd $pwd

	cd pip/volatility-master/
	python setup.py build
	python setup.py install
	cd $pwd
	
	echo '' >> /etc/samba/smb.conf
	echo '[dumps]' >> /etc/samba/smb.conf
	echo 'comment = Memory dumps folder' >> /etc/samba/smb.conf
	echo 'browseable = yes' >> /etc/samba/smb.conf
	echo 'path = /dumps' >> /etc/samba/smb.conf
	echo 'guest ok = yes' >> /etc/samba/smb.conf
	echo 'read only = no' >> /etc/samba/smb.conf
	echo 'create mask = 0700' >> /etc/samba/smb.conf
	echo 'force user = solvent' >> /etc/samba/smb.conf
	echo 'force group = solvent' >> /etc/samba/smb.conf
	echo 'writable = yes' >> /etc/samba/smb.conf
	echo '' >> /etc/samba/smb.conf

	cp watchdirectory.conf /etc/supervisor/conf.d/
	cp processqueue.conf /etc/supervisor/conf.d/

	mkdir /dumps
	mkdir /srv/lobotomy
	mkdir /srv/lobotomy/lob_scripts
	mkdir /srv/lobotomy/dumps
	
	chmod 777 /dumps
	chown -R solvent:solvent /srv/lobotomy
	
	service smbd restart
	
	echo 'Cloning Lobotomy python files'
	if [ ! -f lobotomy_scripts.zip ]; then
		git clone https://github.com/SolventLobotomy/lobotomy-core.git /srv/lobotomy/lob_scripts
	else
		unzip lobotomy_scripts.zip -d /srv/lobotomy/lob_scripts
	fi

	chmod +x /srv/lobotomy/lob_scripts/mcb_pescanner.py
	
	echo 'Writing Lobotomy ini file.'
	
	echo '# this is the lobotomy ini file. ' > /srv/lobotomy/lob_scripts/lobotomy.ini
	echo 'dumpdir: /dumps/' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo 'homedir: /srv/lobotomy/' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo 'copydir: /srv/lobotomy/dumps/' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo 'plugindir: /srv/lobotomy/lob_scripts/' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo 'database: mysql' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo 'mysqlhost: localhost' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo 'mysql_username: root' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo "mysql_password: ${mysqlpassword}" >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo 'mysql_template: template' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo 'yararules: /srv/lobotomy/lob_scripts/yara_rules/' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo 'lobotomy_logfile: /srv/lobotomy/lobotomy.log' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo 'lobotomy_caselogdir: lobotomy.log' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo '#' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo '# The settings below are for the new plugin folders' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo '# They are not yet in use' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo '#' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo 'lobotomy_plugindir: /srv/lobotomy/lob_scripts/plugins/lobotomy' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo 'volatility_plugindir: /srv/lobotomy/lob_scripts/plugins/volatility' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo '#' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo '####################################################################' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo '# Some plugins require bulk insert.' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo '# You can here specify the amount that will be used to bulk insert' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo '####################################################################' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo 'bulkinsert: 10000' >> /srv/lobotomy/lob_scripts/lobotomy.ini
	echo '' >> /srv/lobotomy/lob_scripts/lobotomy.ini

	# Inserting database
	echo 'Creating Lobotomy Database'
	mysql -uroot -p${mysqlpassword} -e "create database lobotomy;"
	mysql -uroot -p${mysqlpassword} lobotomy < lobotomy.sql
	
	# Copy website template
	mv /var/www/html /var/www/html_

	echo 'Cloning Lobotomy front end'
	if [ ! -f lobotomy_web.zip ]; then
		echo .
		#git clone https://github.com/SolventLobotomy/lobotomy-core.git /srv/lobotomy/lob_scripts
	else
		unzip lobotomy_web.zip -d /var/www/html
	fi

	sudo mkdir /var/www/html/templates_c/
	sudo chmod 777 -R /var/www/html/templates_c/

	
	echo 'Writing Lobotomy database.php file.'
	
	echo '<?php' > /var/www/html/includes/database.php
	echo 'try {' >> /var/www/html/includes/database.php
	echo "\$dbh = new PDO(\"mysql:host=localhost;dbname=lobotomy\", \"root\", \"${mysqlpassword}\" , array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));"  >> /var/www/html/includes/database.php
	echo '} catch (PDOException $e) {' >> /var/www/html/includes/database.php
	echo 'print "Error!: " . $e->getMessage() . "<br/>";' >> /var/www/html/includes/database.php
	echo 'die();' >> /var/www/html/includes/database.php
	echo '}' >> /var/www/html/includes/database.php

	service	supervisor restart
	
	echo 'Done installing Lobotomy'
	echo 'Please reboot youre machine'
	
else
	echo "Only root can install Lobotomy"
	exit 2
fi

