#!/bin/sh
insmod /app/wifi/rfkill.ko
insmod /app/wifi/cfg80211.ko
insmod /app/wifi/mac80211.ko
insmod /app/wifi/mtprealloc.ko 
insmod /app/wifi/mt7601Usta.ko 
ifconfig lo up
ifconfig wlan0 up