#!/bin/bash

# set defaults
LOGFILE="/var/log/heartbeat/heartbeat_$(date +'%Y%m%d%H%M%S').log"
DELAY=`cat /home/llewellyn/heartbeat_delay.txt`

touch $LOGFILE

while true;
do
   #test connection to DNS server
   for DNS in `cat /home/llewellyn/heartbeat_dnsservers.txt`; do
      ping -c1 $DNS > /dev/null
      if [ $? -ne 0 ]
      then
         echo "$(date +'%D %T') : Unable to reach DNS - "$DNS >> $LOGFILE
      fi
   done

   sleep $DELAY

done


