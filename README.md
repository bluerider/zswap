# zramswap

Edit the size,algo,threads, and num_devices variables to configure swap devices
Defaults to a single lzo multithreaded half-ram device

Run:
# zswap.sh start

Stop:
# zswap.sh stop

Restart:
# zswap.sh restart

If you use the systemd units, move  zswap.service to /usr/lib/systemd/system/
Enable zswap with:

Run on boot:
# systemctl enable zswap

Run:
# systemctl start zswap

Stop:
# systemctl stop zswap

Restart:
# systemctl restart zswap 
