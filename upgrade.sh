#!/bin/bash
#

#
#main
#

UPGRADE_DATE="$(date +'%Y%m%d')"
RELEASE="bullseye"
APT_GET_PARMS="-qy"


echo "Upgrade started....."

echo "Cache cleanup.....started"  > ./$RELEASE-upgrade_$UPGRADE_DATE.log 2>&1
apt-get $APT_GET_PARMS clean >> ./$RELEASE-upgrade_$UPGRADE_DATE.log 2>&1
echo  "Cache cleanup.....complete"  >> ./$RELEASE-upgrade_$UPGRADE_DATE.log 2>&1

echo "Resync package indexes...started" >> ./$RELEASE-upgrade_$UPGRADE_DATE.log 2>&1
apt-get $APT_GET_PARMS update >> ./$RELEASE-upgrade_$UPGRADE_DATE.log 2>&1
echo "Resync package indexes...completed" >> ./$RELEASE-upgrade_$UPGRADE_DATE.log 2>&1

echo "Release Upgrade...Started" >> ./$RELEASE-upgrade_$UPGRADE_DATE.log 2>&1
apt-get $APT_GET_PARMS upgrade >> ./$RELEASE-upgrade_$UPGRADE_DATE.log 2>&1
echo "Release Upgrade...Completed" >> ./$RELEASE-upgrade_$UPGRADE_DATE.log 2>&1

ls -last $RELEASE-upgrade_$UPGRADE_DATE.log >> ./$RELEASE-upgrade_$UPGRADE_DATE.log 2>&1


echo "Distribution Upgrade...Started" > ./$RELEASE-dist-upgrade_$UPGRADE_DATE.log 2>&1
apt-get $APT_GET_PARMS dist-upgrade >> ./$RELEASE-dist-upgrade_$UPGRADE_DATE.log 2>&1
echo "Distribution Upgrade...Completed" >> ./$RELEASE-dist-upgrade_$UPGRADE_DATE.log 2>&1

echo "Removal of redundant packages...Started" >> ./$RELEASE-dist-upgrade_$UPGRADE_DATE.log 2>&1
apt-get $APT_GET_PARMS autoremove >> ./$RELEASE-dist-upgrade_$UPGRADE_DATE.log 2>&1
echo "Removal of redundant packages...Completed" >> ./$RELEASE-dist-upgrade_$UPGRADE_DATE.log 2>&1

ls -last $RELEASE-dist-upgrade_$UPGRADE_DATE.log >> ./$RELEASE-dist-upgrade_$UPGRADE_DATE.log 2>&1

echo ".....completed."
