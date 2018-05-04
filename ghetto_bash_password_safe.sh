#!/bin/bash
#
# Can't install a password manager on a locked down windows box?
#   cygwin-setup --no-admin  
#   cobbled together to at least not store passwords on
#    Win10 Sticky Notes or even worse, real sticky notes ...

function usage {
  echo "Usage: $0 [-veds]"
  echo "  -v    View respect.bin    "
  echo "  -e    Encrypt respect.txt "
  echo "  -d    Decrypt respect.bin "
  echo "  -s    Shred respect.txt   "
}

if [ $# -gt 0 ]
then
    while getopts ":veds" opt; do
        case $opt in
            v)  if [ ! -f ./respect.bin ]; then
                  echo "respect.bin not found!"
                else
                  echo "Viewing respect.bin"
                  openssl enc -aes-256-cbc -d -in respect.bin |  vim -m -n -R -
                fi ;;

            e)  if [ ! -f ./respect.txt ]; then
                  echo "respect.txt not found!"
                else
		  echo "Encrypting respect.txt"
                  openssl enc -aes-256-cbc -salt -in respect.txt -out respect.bin
                fi ;;

            d)  if [ ! -f ./respect.bin ]; then
                  echo "respect.bin not found!"
                else
                  echo "Dumping respect.txt";
                  openssl enc -aes-256-cbc -d -in respect.bin -out respect.txt
                fi ;;

            s)  if [ ! -f ./respect.txt ]; then
                  echo "respect.txt not found!"
                else
                  echo "Shredding respect.txt"
                  shred -z -u respect.txt
                fi ;;

            \?) echo "Invalid option: -$OPTARG" >&2 ;;
        esac
    done; exit
else
  usage
  exit
fi

# At least it's encrypted :P
