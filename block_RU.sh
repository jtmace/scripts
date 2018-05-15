#!/usr/bin/env bash
# r = requests.post("http://www.find-ip-address.org/ip-country/", data={'country': 'RU', 'output': 'CIDR', 'prefix': ''})
# -----------------------------------------------------------------------
# Create ASA list of Russian IP ranges to throw in the DROP object group. 
#
#  "if you ever code something that 'feels like a hack but
#   it works' just remember that a CPU is literally a rock
#   that we tricked into thinking" -@daisyowl
#
# Example output:  
#    network-object 2.92.0.0 255.252.0.0
#    network-object 5.1.48.0 255.255.248.0
#    network-object 5.2.32.0 255.255.224.0
#    network-object 5.3.0.0 255.255.0.0

R=`curl -d "country=RU&output=CIDR" -X POST http://www.find-ip-address.org/ip-country/`
echo $R | sed -e 's/\s/\n/g' | sed 1,10d | while IFS="/" read IP SN; do 
        M=$(( 0xffffffff ^ ((1 << (32-SN)) -1) ))
        echo "  network-object $IP $(( (M>>24) & 0xff )).$(( (M>>16) & 0xff )).$(( (M>>8) & 0xff )).$(( M & 0xff ))"
done
