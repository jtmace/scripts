#!/bin/bash
# Vigenère cipher

a="ABCDEFGHIJKLMNOPQRSTUVWXYZ"

#[[ "${*/-d/}" != "" ]] &&
#echo "Usage: $0 [-d]" && exit 1
m=${1:+-}

#t=`echo $1 | tr "[:lower:]" "[:upper:]"`
t="FPSQSEYUVKR"
k=`echo $1 | tr "[:lower:]" "[:upper:]"`

for ((i=0;i<${#t};i++)); do
  p1=${a%%${t:$i:1}*}
    p2=${a%%${k:$((i%${#k})):1}*}
      d="${d}${a:$(((${#p1}${m:-+}${#p2})%${#a})):1}"
      done
      echo "$d     Key: $k"
