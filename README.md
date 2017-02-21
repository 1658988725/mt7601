# mt7601
mt7061 start ap by hostapd



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

if [ $1 == "sta" ];then   
        echo "sta mode"
       	/app/wifi/wpa_supplicant -B -iwlan0 -c /app/wifi/wpa_supplicant.conf
		    udhcpc -i wlan0 -s /app/wifi/default.script
elif [ $1 == "ap" ];then
        echo "ap mode"
        ifconfig lo up
        ifconfig wlan0 192.168.100.2 up
        /app/wifi/hostapd -B /app/wifi/hostapd.conf
        udhcpd /app/wifi/udhcpd.conf
else
	    echo " param sta or ap."
fi 


详细见hisitest/
