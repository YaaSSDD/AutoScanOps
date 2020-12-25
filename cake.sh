#!/bin/sh
#mode strict -e first error exit exit for true data | -u no accept undifined variable | -o pipefail logical error 
#set -euo pipefail
IFS=$'\n\r'


 InstallDependenciesDebian ()
{
  ###
  #Tester c'est douter :pppppp
  ###
  echo "deb http://ftp.de.debian.org/debian stretch main non-free" >> /etc/apt/sources.list

  cd /
  mkdir script
  cd script

  apt-get update && apt-get upgrade -y
  apt-get install -y fail2ban
  systemctl start fail2ban
  systemctl enable fail2ban

  ###
  #Install Docker-engine
  ###
  setxkbmap fr
  #  passwd root
  apt-get update

  apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common

  curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
  apt-key fingerprint 0EBFCD88

  add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable"

  apt-get update

  apt-get install -y docker-ce docker-ce-cli containerd.io

  docker run hello-world

###
#Install Bettercap
###
  apt-get install -y build-essential ruby-dev libpcap-dev 
  apt-get install ruby -t stretch 
  apt-get install ruby-dev libpcap-dev -t stretch
   gem install packetfu -v 1.1.11
   gem install bettercap

  ###
  #Install SCAN tools
  ###
  apt-get install nmap -y
  apt-get install nikto -y

  ###
  #Install DDOS tools
  ###
  git clone "https://github.com/jseidl/GoldenEye"
  git clone "https://github.com/gillesdubois/simplePerlDDoS"

  ###
  #Install Sqlmap 
  ###
  git clone "https://github.com/sqlmapproject/sqlmap"

  ###
  #Install Metasploit
  ###
  
  ###
  #Install Patator
  ###
  apt-get install python curl -y
  apt-get install python-paramiko -y 
  apt-get install python3 -y
  apt-get install python-pip -y
  git clone "https://github.com/lanjelot/patator"

}



GetServiceCurrentTarget ()
{

local Service
local IndexPeerTarget=0


#boucle ip in file.txt overrride
cat "ip.txt" | while  read ligne ; do

  AllIpTab[$index]="$ligne"
  #echo ${AllIpTab[$index]}
  
  #create directory content rapport 
  mkdir ${AllIpTab[$index]}
  chmod 755 ${AllIpTab[$index]}
  #cd ${AllIpTab[$index]}
  CURRENTPATHTARGET=$( pwd )

  touch pathFileTmp.txt
  echo $CURRENTPATHTARGET >> pathFileTmp.txt
  #mv ../ParseRapport.php 
  #DYNAMIC_TARGET=0
  DYNAMIC_TARGET=${AllIpTab[$index]}
  echo $DYNAMIC_TARGET
  touch rapportNmap.txt
  ThisTarget=${AllIpTab[$index]}
  #nmap -sS -O -p- -Pn $ThisTarget
  Service=$(  nmap $ThisTarget )
  echo $Service >> rapportNmap.-txt
   touch CleanNmap.txt
   chmod 755 CleanNmap.txt

  #echo $DYNAMIC_TARGET
  DYNAMIC_PATH_DIR=$( pwd )
  #pwd
  php ../ParseRapport.php

  rm pathFileTmp.txt
  #cd ../

  index=$(($index+1))
  IndexPeerTarget=$(($IndexPeerTarget+1))
  #nmap section you can add other flag (sC/sS)
  #cd $DYNAMIC_TARGET
  MatchRapportNmapToServices $DYNAMIC_TARGET

done
  #screen -S tf2 MatchRapportNmapToServices $DYNAMIC_TARGET

  #exit
  return $Service


}


ScanAir ()
{
  IpTab=()
  I=0
  StringLimite=endpoint
  ##call bettercap for scan localNetwork

  #!!!!decommenter pour activer le scan bettercap uner fois les test appliquer et bien-sur avec autorisation d'operer sur le network !!!!!!!
  # bettercap -eval "events.stream off; set events.stream.output ~/bettercap-events.log; events.stream on; net.sniff on"

  Path="~/bettercap-events.log"
  cp ~/bettercap-events.log .
  cat bettercap-events.log | while  read ligne ; do 
    IpTab[$I]="$ligne"
    #echo ${IpTab[$I]}
    OneLigne=${IpTab[$I]}
    #grep '(?<=endpoint:).*'
    ### parse logfile Bettercap 
    IpDetected=$(  echo $OneLigne | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | sort -u )
    echo $IpDetected >> ipTmp.txt
  done
 ###
 #Call php for parse log file extract unique IP for override to nmap
 ###
  php strcmp.php
  GetServiceCurrentTarget
}
 ScanAir
 

