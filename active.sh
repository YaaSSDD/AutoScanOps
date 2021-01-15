#!/bin/sh
###
#skkrtskkkrt
###
  ./installDependencies.sh
  cd docker-elk
  docker-compose up &
  cd ..
  ./betterTesh.sh
###
#wait to start ELK cluster and open your favorit browser goto http://localhost:5601
###

#V2 coming soon catch custom log JSON and import auto-dashboard kibana



