#!/bin/sh
IFS=$'\n\r'

 InstallDependenciesDebian ()
{
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
### à revoir problème de version golang pour install bettercap
  apt-get install -y build-essential ruby-dev libpcap-dev 
  apt-get install ruby -t stretch 
  apt-get install ruby-dev libpcap-dev -t stretch
  sudo gem install packetfu -v 1.1.11
  sudo gem install bettercap

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
#Install Docker-ELK
###
git clone "https://github.com/deviantony/docker-elk"

###
#Install Patator
###
apt-get install python curl -y
apt-get install python-paramiko -y 
apt-get install python3 -y
apt-get install python-pip -y
git clone "https://github.com/lanjelot/patator"

 }

 InstallDependenciesDebian
