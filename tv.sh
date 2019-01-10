#!/bin/sh
# Simple, ugly scipt to tune the HDHomerun to a channel on Linux.
# Your channels will vary. Scan channels with:
#   hdhomerun_config FFFFFFFF scan /tuner0 | grep -B 2 PROGRAM

$DIALOG=${DIALOG=dialog}
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15

ip="$(ip addr | grep 'state UP' -A2 | tail -n1 | awk -F'[/ ]+' '{print $3}')"

vlc udp://@:1234 &> /dev/null & sleep 1 

tune_in () {
    hdhomerun_config FFFFFFFF set /tuner0/channel auto:$1; sleep 1
    hdhomerun_config FFFFFFFF get /tuner0/status
    hdhomerun_config FFFFFFFF get /tuner0/streaminfo
    hdhomerun_config FFFFFFFF set /tuner0/program $2
    hdhomerun_config FFFFFFFF set /tuner0/target $ip:1234
} 

while true; do
	$DIALOG --clear --title "HDHomerunner" \
        --menu "Choose Channel:" 20 51 27      \
        "2.1"  "WKRN-D"                        \
        "2.2"  "MeTV"                          \
        "2.3"  "JUSTICE"                       \
        "2.4"  "GRIT"                          \
        "4.1"  "WSMV-H"                        \
        "4.2"  "Escape"                        \
        "4.3"  "Cozi"                          \
        "5.1"  "WTVF"                          \
        "5.2"  "NC5+"                          \
        "5.3"  "LAFF"                          \
        "8.1"  "NPT-1"                         \
        "8.2"  "NPT-2"                         \
        "8.3"  "NPT-3"                         \
        "17.1" "WZTV"                          \
        "17.2" "TBD"                           \
        "17.3" "Ant. TV"                       \
        "30.1" "WUXP-HD"                       \
        "30.2" "GetTV"                         \
        "30.3" "CometT"                        \
        "28.1" "ION"                           \
        "28.2" "qubo"                          \
        "28.3" "IONLife"                       \
        "28.4" "Shop"                          \
        "28.5" "QVC"                           \
        "28.6" "HSN"                           \
        "58.1" "CW58"                          \
        "58.2" "STAD"                          \
        "58.3" "Charge" 2> $tempfile

retval=$?
choice=`cat $tempfile`

case $retval in
  0)
    case $choice in 
        "2.1")  tune_in 27 3 ;;
	"2.2")  tune_in 27 4 ;;
        "2.3")  tune_in 27 5 ;;
        "2.4")  tune_in 27 6 ;;
        "4.1")  tune_in 10 3 ;;
        "4.2")  tune_in 10 4 ;;
        "4.3")  tune_in 10 5 ;;
        "5.1")  tune_in 25 3 ;;
        "5.2")  tune_in 25 4 ;;        
	"5.3")  tune_in 25 5 ;;
        "8.1")  tune_in  8 3 ;;         
        "8.2")  tune_in  8 4 ;;
        "8.3")  tune_in  8 5 ;;
        "17.1") tune_in 15 3 ;;
        "17.2") tune_in 15 4 ;;
        "17.3") tune_in 15 5 ;;
        "28.1") tune_in 36 3 ;;
        "28.2") tune_in 36 4 ;;
        "28.4") tune_in 36 5 ;;
        "28.5") tune_in 36 6 ;;
        "28.6") tune_in 36 7 ;;
	"30.1") tune_in 21 3 ;;
        "30.2") tune_in 21 4 ;;
        "30.0") tune_in 21 5 ;;
        "58.1") tune_in 23 3 ;;
        "58.2") tune_in 23 4 ;;
        "58.3") tune_in 23 5 ;;
    esac ;;
  1)
    exit ;;
  255)
    exit ;;
esac
done
