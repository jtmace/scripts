#!/bin/bash
# checklogs.sh - check access log for hyperactive IPs
# 0 * * * * sh /path/checklogs.sh
# YMMV, dependant on the log format.

VHOST="examplevhost"
DATE="`date +%Y%m%d`"
DIR="/var/log/httpd/$VHOST"
LOG="https_access_log"
MAILADDYS="admin@example.com"
THRESHOLD=9000

OUT="$(awk -vDate=`date -d'now-1 hours' +[%d/%b/%Y:%H:%M:%S` '{ if ($5 > Date) print }' $DIR/$LOG.$DATE | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' |sort |  uniq -c | sort -n -r | awk -v t=$THRESHOLD 'int($1)>=t')"
OIFS="${IFS}"
NIFS=$'\n'
IFS="${NIFS}"
MSG=$'`hostname` is experiencing a high volume of activity from one or more IP addresses.\n'
C=0
for LINE in ${OUT} ; do 
  C=$(expr $C + 1) 
  IFS="${OIFS}"
  MSG[$C]=$(echo The IP address `echo "${LINE}" | awk '{ print $2}'` has hit the server `echo "${LINE}" | awk '{ print $1}'` times in the last hour.)
  IFS="${NIFS}"
done
IFS="${OIFS}"
if [ $C -gt 0 ]
then
  printf "%s\n" "${MSG[@]}" | mailx -s "`hostname` Activity Alert" $MAILADDYS
fi
