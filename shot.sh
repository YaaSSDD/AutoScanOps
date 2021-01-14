#!/bin/sh

  Shot ()
  {
    NOOK=false

    while [ "NOOK" != "true" ] ; do
	C1=192;
	C2=168;
	C3=1;
	C4=$((1 + RANDOM % 255))
	#nmap $C1.$C2.$C3.$C4
	ThisIp=$( echo $C1.$C2.$C3.$C4 )
	mkdir $ThisIp
	chmod 755 $ThisIp
	cp ./php_tools/parser.php $ThisIp
	cd $ThisIp
	touch rapport-nmap.txt
    ###
    ##if you use this command use all available capacity 
    ##	nohup nmap -sV -Pn -O $ThisIp >> rapport-nmap.txt &
    ###   
    nmap -sV -Pn -O $ThisIp >> rapport-nmap.txt
    php parser.php

	#mv parser.php ../
	cd ../
    done
  }


  Shot