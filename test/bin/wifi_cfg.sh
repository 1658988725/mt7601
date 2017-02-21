#!/bin/sh
killall -9 wpa_supplicant
killall -9 udhcpc
killall -9 udhcpd
killall -9 hostapd

ifconfig wlan0 down
rmmod mt7601Usta.ko 
rmmod mtprealloc.ko
sleep 1
insmod /app/wifi/mtprealloc.ko 
insmod /app/wifi/mt7601Usta.ko 

grep "<wifiMode>1</wifiMode>" /home/cdr_syscfg.xml >/dev/null

if [ $? -eq 0 ];then   
        echo "sta mode"
       	/app/wifi/wpa_supplicant -B -iwlan0 -c /app/wifi/wpa_supplicant.conf
		udhcpc -i wlan0 -s /app/wifi/default.script
else
        echo "ap mode"
        ifconfig lo up
        ifconfig wlan0 192.168.100.2 up
        /app/wifi/hostapd -B /app/wifi/hostapd.conf
        udhcpd /app/wifi/udhcpd.conf
fi 
