# zswap

Zswap extends the amount of usable ram one has. It does this by utilizing compressed zram block devices.It is not related to the kernel zswap module!

Zswap defaults to use a single multithreaded lzo compressed half-ram swap disk
Edit the following parameters in zswap.sh to configure zswap:

Parameter     Usage                                     |  Example
------------|-------------------------------------------|---------------
size        | Set the size a block device(K,M,G)        |  size=(1G)
algo        | Set the compression algorithm (lzo|lz4)   |  algo=(lzo)
threads     | Set the # of threads to compress with     |  threads=(2)
num_devices | Set the # of swap devices from zswap      |  num_devices=1

Use the following commands to control zswap:

Command                    |  Usage
---------------------------|------------------------------------
zswap.sh start             |  Start zswap
zswap.sh stop              |  Stop zswap
zswap.sh restart           |  Restart zswap
systemctl enable zswap     |  Start zswap on boot using systemd
systemctl start zswap      |  Start zswap using systemd
systemctl stop zswap       |  Stop zswap using systemd
systemctl restart zswap    |  Restart zswap using systemd
