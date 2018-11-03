# Introduction
This repository contains a script to login automatically on the captive portal from the Proximus FON hotspot. This is only useful for FON customers since Proximus customers can use secured WiFi and authenticate using PEAP.

# How to install on OpenWrt router
- Rename belgacom-fon to 99-proximus-fon and copy to /etc/hotplug.d/iface 
- Add the following line to /etc/crontabs/root (or another user)
*/10 * * * * sh /etc/hotplug.d/iface/99-proximus-fon
- Enable cron if not yet done (see documentation OpenWrt)

# Remarks and limitations
Note that the current script does not check the certificate and is therefore unsafe. You need to install/configure the certificates on the OpenWrt router to make it work safely.