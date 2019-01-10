#!/bin/bash
#hdhomerun_config FFFFFFFF scan /tuner0 | grep -B 2 PROGRAM
echo 27\) WKRN Chan 2
echo 10\) WSMV 4
echo 25\) WTVF Chan 5
echo  8\) NPT Chan 8
echo 15\) WZTV Fox 17
echo 21\) WUXP 30
echo 36\) ION
echo 23\) CW58
echo
read -p "channel:" channel
hdhomerun_config  101A4AE9 set /tuner0/channel auto:$channel
#hdhomerun_config 101A4AE9 get /tuner0/target
sleep 2 
hdhomerun_config 101A4AE9  get /tuner0/status
hdhomerun_config  101A4AE9 get /tuner0/streaminfo
read -p "program:" program 
hdhomerun_config 101A4AE9 set /tuner0/program $program
vlc udp://@:1234 &> /dev/null & sleep 1
hdhomerun_config 101A4AE9 set /tuner0/target 10.0.0.10:1234
