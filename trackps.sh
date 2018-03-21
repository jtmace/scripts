#!/bin/bash
# Track process changes 
function cleanup {
  echo -e "\033[0m" ; exit
}

IFS=$'\n'
o=$(ps -eo user,command)
trap cleanup SIGINT SIGQUIT SIGHUP

while true; do
  n=$(ps -eo user,command)
  diff <(echo "$o") <(echo "$n") |grep [\<\>] |egrep -v "ps -eo|sleep" |sed -e "s/^>/$(printf "\033[32m")/; s/^</$(printf "\033[31m")/"
  sleep 1
  o=$n
done

# For a simpler ver:
# ------------------
# !/bin/bash
# IFS=$'\n'
# o=$(ps -eo start,user,command)
# while true; do
#   n=$(ps -eo start,user,command)
#   diff <(echo "$o") <(echo "$n") | grep [\<\>] |egrep -v "ps -eo|sleep"
#   sleep 1
#   o=$n
# done
