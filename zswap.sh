#!/bin/bash

## mem_size is total ram size in megabytes
## size        : array   : accepts integer sizes in K,M,G
## num_devices : integer : number of devices requested
## threads     : array   : accepts integers for # threads to use
## algo        : array   : accepts lzo or lz4
mem_array=($(free -m))
declare -r mem_size=${mem_array[7]}
unset mem_array;
declare -a size=($[mem_size/2]M)
declare -a algo=(lzo)
declare -a threads=($(nproc))
declare -r num_devices=1

makeSwap() {
 mkswap "$1"
 swapon --priority 100 "$1"
}

stopSwap() {
 swapoff "$1";
 zramctl -r "$1";
}

resetSwap() {
 swapoff "$1";
 swapon -f --priority 100 "$1";
}

## makeSwap function accepts integer as $1
enableZmodule() {
 makeSwap "$(zramctl -f -s ${size[$1]} -a ${algo[$1]} -t ${threads[$1]})"
}

case $1 in
  start)
    count() {
      echo $#
    }
    ## if no zram devices. ensure there is 2 more than needed
    if [ ! -b "/dev/zram0" ]; then
       modprobe zram num_devices=$[num_devices+2];
    fi;
    ## check if there are enough devices; there are 7 lines per device in zramctl
    if [[ $[$(count /dev/zram*)-$(count $(zramctl -n --raw))/7] -ge $num_devices ]]; then
       for ((i=0;i<$num_devices;i++)); do
           enableZmodule $i;
       done;
      else
       echo "Not enough zram devices";
    fi;;
  stop)
    for a in $(swapon --noheadings); do
      if [[ "$a" == /dev/zram* ]]; then
         stopSwap "$a";
      fi;
    done;;
  restart)
    for a in $(swapon --noheadings); do
      if [[ "$a" == /dev/zram* ]]; then
         resetSwap "$a";
      fi;
    done;;
  *)
    echo "Not a valid option";;
esac;
