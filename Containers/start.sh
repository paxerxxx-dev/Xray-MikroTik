#!/bin/sh
echo "Starting setup container please wait"
sleep 1


#TUN_IFACE=$(ip -o link show | awk -F': ' '{print $2}' | grep -E 'tun' | head -n1 | cut -d'@' -f1)

echo '30      03       *       *       *      wget https://raw.githubusercontent.com/runetfreedom/russia-blocked-geosite/release/geosite.dat -O /tmp/xray/geosite.dat && service xray restart' >> /etc/crontabs/root
/usr/sbin/crond


echo "Xray preparing for launch"
#rm -rf /tmp/xray/ && mkdir /tmp/xray/
7z x /opt/xray/xray.7z -o/tmp/xray/ -y
chmod 755 /tmp/xray/xray
wget https://raw.githubusercontent.com/runetfreedom/russia-blocked-geosite/release/geosite.dat -O /tmp/xray/geosite.dat

echo "Start Xray core"
rc-service xray start

echo "Waiting for Xray SOCKS port 10800..."
for i in $(seq 1 10); do
    if nc -z 127.0.0.1 10800 2>/dev/null; then
        echo "SOCKS port is up!"
        break
    fi
    echo "Port Xray not ready, retrying..."
    sleep 1
done
ip rule add iif xray lookup 100

echo "Container customization is complete"

