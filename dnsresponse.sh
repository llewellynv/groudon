#!/bin/bash
site=`cat ./dnsresponse_testsite.txt`
IPfile="`cat ./dnsresponse_dnssites.txt`"
samples=`cat ./dnsresponse_sample.txt`

#if [ ! -f "$IPfile" ] || ! echo "$samples"|egrep -q "[0-9]+" ; then
#  echo "test_dns_list_speed.sh <file-ip-list> <samples>"
#  echo "<file-ip-list>       newline separated list of DNS server IP adresses"
#  echo "<samples>            how many DNS resolution samples to take"
#  echo "PURPOSE:"
#  echo "          collect statistics about response times from list of DNS servers"
#  exit 1
#fi

typeset -i i

while [ $i -lt $samples ]; do
  i=$i+1
  for IP in `cat $IPfile`; do
    time=`dig @$IP $site| awk '/Query time:/ {print " "$4}'`
    IPtrans=`echo $IP|tr \. _`
    eval `echo result$IPtrans=\"\\$result$IPtrans$time\"`
  done
done

for IP in `cat $IPfile`; do
  IPtrans=`echo $IP|tr \. _`
  printf "%-15s " "$IP"; echo -e `eval "echo \\$result$IPtrans"`|tr ' ' "\n"|awk '/.+/ {rt=$1; rec=rec+1; total=total+rt; if (minn>rt || minn==0) {minn=rt}; if (maxx<rt) {maxx=rt}; }
             END{ if (rec==0) {ave=0} else {ave=total/rec}; printf "average %5i     min %5i     max %5i ms %2i responses\n", ave,minn,maxx,rec}'
done
