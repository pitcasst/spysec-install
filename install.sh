#!/bin/bash

DIR_INI=$(echo $PWD)

	function isRoot () {
		if [ "$EUID" -ne 0 ]; then
			return 1
		fi
		
	}
	
	function tunAvailable () {
		if [ ! -e /dev/net/tun ]; then
			return 1
		fi
	}
	
	function initialCheck () {
		if ! isRoot; then
			echo "Sorry, you need to run this as root"
			exit 1
		fi
		if ! tunAvailable; then
			echo "TUN is not available"
			exit 1
		fi
		
	}


function manageMenu () {
	clear
	echo "Welcome to SPYSEC-install!"
	echo "The git repository is available at: https://github.com/pitcasst/spysec-install"
	echo ""
	echo "It looks like SpySec is already installed."
	echo ""
	echo "What do you want to do?"
	echo "   1) Install Spysec"
	echo "   2) Install Spysec with GUI"
	echo "   3) Remove Spysec"
	echo "   4) Exit"
	until [[ "$MENU_OPTION" =~ ^[1-4]$ ]]; do
		read -rp "Select an option [1-4]: " MENU_OPTION
	done

	case $MENU_OPTION in
		1)
			newClient
		;;
		2)
			newClientGUI
		;;
		3)
			removeOpenVPN
		;;
		4)
			exit 0
		;;
	esac
}



function newClient () {
		echo ""
	read -rp "Do you really want to install SPYSEC? [y/n]: " -e -i n INSTALL
	if [[ "$INSTALL" = 'y' ]]; then	
		
		NIC=$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)' | head -1)

		
		
		DIRETC="/etc/spysec/"
		FILESH="/etc/spysec/server.sh"
		DIRAUDIOS="/var/spool/spysec/"
		DIRSERV=/etc/systemd/system/spysec.service
		mkdir $DIRETC
		touch $FILESH
		mkdir $DIRAUDIOS
		
				echo -e "#!/bin/bash" >> /etc/spysec/server.sh
				echo -e "while :" >> /etc/spysec/server.sh
				echo -e "do" >> /etc/spysec/server.sh
	
	
				echo 'DATE=$(date +"%F-%T")' >> /etc/spysec/server.sh
				echo 'UP="/usr/bin/arecord -D sysdefault:CARD=1 /home/pi/Desktop/Grabacion-$DATE.wav"' >> /etc/spysec/server.sh
				echo 'VALIDA="/usr/bin/pgrep" >> /etc/spysec/server.sh' >> /etc/spysec/server.sh
				echo 'SERVICIO="arecord"' >> /etc/spysec/server.sh
				echo '$VALIDA ${SERVICIO}' >> /etc/spysec/server.sh
				echo 'if [ $? -ne 0 ]' >> /etc/spysec/server.sh
				echo "then" >> /etc/spysec/server.sh
				echo '$UP | mail -s "Server Up in SPYSEC1 `date "+%c"`" pcastillo@conessis.com.mx' >> /etc/spysec/server.sh
				echo 'fi' >> /etc/spysec/server.sh
				echo 'sleep 30;' >> /etc/spysec/server.sh
				echo 'done' >> /etc/spysec/server.sh
				
		touch $DIRSERV

				echo -e "[Unit]
				Description=SPYSEC demo service
				After=network.target
				StartLimitIntervalSec=0
				[Service]
				Type=simple
				Restart=always
				RestartSec=1
				ExecStart=/bin/bash /etc/spysec/server.sh
				
				[Install]
				WantedBy=multi-user.target" >> $DIRSERV

		 chmod 644 $DIRSERV

		  #touch ./unistall.sh

			#	echo -e "#!/bin/bash" >> ./unistall.sh
			#	echo 'systemctl disable spysec' >> ./unistall.sh
			#	echo 'systemctl stop spysec' >> ./unistall.sh
			#	echo 'rm -rf /etc/spysec/' >> ./unistall.sh
			#	echo 'rm -f /etc/systemd/system/spysec.service' >> ./unistall.sh
			#	echo 'rm -rf /var/spool/spysec/' >> ./unistall.sh

		#chmod +x  ./unistall.sh

		echo "Install Spysec!"
	
	else
		echo ""
		echo "Install aborted!"
	fi
		
		
		 
}



function newClientGUI () {
	
	echo ""
	read -rp "Do you really want to install SPYSEC? [y/n]: " -e -i n INSTALL
	if [[ "$INSTALL" = 'y' ]]; then


		
	
	#echo ""
	#echo "Tell me a name for the client."
	#echo "Use one word only, no special characters."

	#until [[ "$CLIENT" =~ ^[a-zA-Z0-9_]+$ ]]; do
	#	read -rp "Client name: " -e CLIENT
	#done
	
		NIC=$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)' | head -1)

		apt-get update
		apt-get -y install apache2
		apt-get -y install mariadb-server
		apt-get -y install php php-mysql
		
		systemctl start mysql
		systemctl enable mysql
		
		 mysql -e "CREATE DATABASE spysec /*\!40100 DEFAULT CHARACTER SET utf8 */;"
		 mysql -e "CREATE USER 'spysec'@'localhost' IDENTIFIED BY '6u#roxe3L2u3oGUml2ij';"
		 mysql -e "GRANT ALL PRIVILEGES ON spysec.* TO 'spysec'@'localhost';"
		 mysql -e "FLUSH PRIVILEGES;"
		 
		 
		 
		 
		 
		 
		
	     mysql -u root spysec < spysecdb.sql
		
		
		
		APACHE2="/etc/apache2/spyrecord.conf"
		touch $APACHE2
		echo -e 'Alias /RECORDINGS/ "/var/spool/spysec/"' >> $APACHE2
		echo -e "<Directory "/var/spool/spysec/">" >> $APACHE2
		echo -e "Options Indexes MultiViews" >> $APACHE2
		echo -e "AllowOverride None" >> $APACHE2
		echo -e "Require all granted" >> $APACHE2
		echo -e "<files *.wav>" >> $APACHE2
		echo -e " Forcetype application/forcedownload" >> $APACHE2
		echo -e "</files>" >> $APACHE2
		echo -e "php_admin_value engine Off" >> $APACHE2
		echo -e "</Directory>" >> $APACHE2
		echo -e "" >> $APACHE2
        
        

		tar -xf spysec-V1.tar.gz --directory /var/www/html/
		
		
		
		DIRETC="/etc/spysec/"
		FILESH="/etc/spysec/server.sh"
		DIRAUDIOS="/var/spool/spysec/"
		DIRSERV=/etc/systemd/system/spysec.service
		mkdir $DIRETC
		touch $FILESH
		mkdir $DIRAUDIOS
		
				echo -e "#!/bin/bash" >> /etc/spysec/server.sh
				echo -e "while :" >> /etc/spysec/server.sh
				echo -e "do" >> /etc/spysec/server.sh
	
	
				echo 'DATE=$(date +"%F-%T")' >> /etc/spysec/server.sh
				echo 'UP="/usr/bin/arecord -D sysdefault:CARD=1 /home/pi/Desktop/Grabacion-$DATE.wav"' >> /etc/spysec/server.sh
				echo 'VALIDA="/usr/bin/pgrep" >> /etc/spysec/server.sh' >> /etc/spysec/server.sh
				echo 'SERVICIO="arecord"' >> /etc/spysec/server.sh
				echo '$VALIDA ${SERVICIO}' >> /etc/spysec/server.sh
				echo 'if [ $? -ne 0 ]' >> /etc/spysec/server.sh
				echo "then" >> /etc/spysec/server.sh
				echo '$UP | mail -s "Server Up in SPYSEC1 `date "+%c"`" pcastillo@conessis.com.mx' >> /etc/spysec/server.sh
				echo 'fi' >> /etc/spysec/server.sh
				echo 'sleep 30;' >> /etc/spysec/server.sh
				echo 'done' >> /etc/spysec/server.sh
				
		touch $DIRSERV

				echo -e "[Unit]
				Description=SPYSEC demo service
				After=network.target
				StartLimitIntervalSec=0
				[Service]
				Type=simple
				Restart=always
				RestartSec=1
				ExecStart=/bin/bash /etc/spysec/server.sh
				
				[Install]
				WantedBy=multi-user.target" >> $DIRSERV

		 chmod 644 $DIRSERV

		  #touch ./unistall.sh

			#	echo -e "#!/bin/bash" >> ./unistall.sh
			#	echo 'systemctl disable spysec' >> ./unistall.sh
			#	echo 'systemctl stop spysec' >> ./unistall.sh
			#	echo 'rm -rf /etc/spysec/' >> ./unistall.sh
			#	echo 'rm -f /etc/systemd/system/spysec.service' >> ./unistall.sh
			#	echo 'rm -rf /var/spool/spysec/' >> ./unistall.sh

		#chmod +x  ./unistall.sh


		echo "Install Spysec!"

	else
		echo ""
		echo "Install aborted!"
	fi
	
		 
}



function removeOpenVPN () {
	echo ""
	read -rp "Do you really want to remove SPYSEC? [y/n]: " -e -i n REMOVE
	if [[ "$REMOVE" = 'y' ]]; then
		# Get OpenVPN port from the configuration
		PORT=$(grep '^port ' /etc/spysec/server.sh | cut -d " " -f 2)


			systemctl disable spysec
			systemctl stop spysec
			rm -rf /etc/spysec/
			rm -f /etc/systemd/system/spysec.service
			rm -rf /var/spool/spysec/
			
			rm -rf /etc/apache2/spyrecord.conf
			
			rm -rf /var/www/html/
			
			
			
			
			apt-get remove -y --purge mysql\*
			apt-get remove -y apache2
			apt-get -y remove php php-mysql
			apt-get clean
			

			echo ""
		echo "Removed Spysec!"
	else
		echo ""
		echo "Removal aborted!"
	fi
}




	



# Check for root, TUN, OS...
initialCheck

# Check if OpenVPN is already installed
if [[ -e /etc/spysec/server.conf ]]; then
	manageMenu
else
	manageMenu
fi



