#!/bin/sh
echo "Starting setup container please wait"
sleep 1


#TUN_IFACE=$(ip -o link show | awk -F': ' '{print $2}' | grep -E 'tun' | head -n1 | cut -d'@' -f1)

#echo '30      03       *       *       *      wget https://raw.githubusercontent.com/runetfreedom/russia-blocked-geosite/release/geosite.dat -O /tmp/xray/geosite.dat && service xray restart' >> /etc/crontabs/root
#/usr/sbin/crond


echo "Xray preparing for launch"
#rm -rf /tmp/xray/ && mkdir /tmp/xray/
7z x /opt/xray/xray.7z -o/tmp/xray/ -y
chmod 755 /tmp/xray/xray
#wget https://raw.githubusercontent.com/runetfreedom/russia-blocked-geosite/release/geosite.dat -O /tmp/xray/geosite.dat

ip rule add iif xray lookup 100

echo "Container customization is complete"

