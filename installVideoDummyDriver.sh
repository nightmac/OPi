#!/bin/bash


if [ "$(whoami)" != "root" ]; then
	echo "Please run this script with sudo due to the fact that it must do a number of sudo tasks.  Exiting now."
	exit 1
fi
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "This script is for devices that need the XOrg Video Dummy Driver to show up properly in VNC."
echo "Note that if you install the dummy driver, VNC will then work, but HDMI will no longer work since it is using the dummy driver instead"
echo "If the script has already run, instead of setting it up, it will uninstall the dummy driver and remove the conf file."

read -p "Do you wish to run this script? (y/n)" runscript
if [ "$runscript" != "y" ]
then
	echo "Quitting the script."
	exit
fi

if [ -e "/etc/X11/xorg.conf.d/10-videodummy.conf" ]
then
		read -p "The script was already run.  Do you wish to uninstall? (y/n)" uninstall
		if [ "$uninstall" == "y" ]
		then
			echo "Removing the dummy driver and the conf file as you requested."
			sudo apt-get -y remove xserver-xorg-video-dummy
			sudo rm /etc/X11/xorg.conf.d/10-videodummy.conf
		fi
		echo "Script Execution Complete.  The Video Dummy Driver is removed.  You should restart your computer."
		exit
fi


# This will install the Video Dummy Driver
sudo apt -y install xserver-xorg-video-dummy

# This will create the configuration file needed to support the dummy driver.
# Note:  Thanks to https://ubuntuforums.org/showthread.php?t=1297815&page=3 for all the modes.
##################
sudo bash -c 'cat > /etc/X11/xorg.conf.d/10-videodummy.conf' <<- EOF
Section "Monitor"
	Identifier "Monitor0"
    HorizSync 22 - 83
    VertRefresh 50 - 76
     #1024x768 @ 60.00 Hz (GTF) hsync: 47.70 kHz; pclk: 64.11 MHz
    Modeline "1024x768" 64.11 1024 1080 1184 1344 768 769 772 795 -HSync +Vsync
     #1280x800 @ 60.00 Hz (GTF) hsync: 49.68 kHz; pclk: 83.46 MHz
    Modeline "1280x800" 83.46 1280 1344 1480 1680 800 801 804 828 -HSync +Vsync
     #1440x900 @ 60.00 Hz (GTF) hsync: 55.92 kHz; pclk: 106.47 MHz
    Modeline "1440x900" 106.47 1440 1520 1672 1904 900 901 904 932 -HSync +Vsync
     #1920x1080 @ 60.00 Hz (GTF) hsync: 67.08 kHz; pclk: 172.80 MHz
    Modeline "1920x1080" 172.80 1920 2040 2248 2576 1080 1081 1084 1118 -HSync +Vsync
EndSection

Section "Device"
	Identifier "Card0"
	Option "NoDDC" "true"
	Option "IgnoreEDID" "true"
	Driver "dummy"
	VideoRam	16384
EndSection

Section "Screen"
	DefaultDepth 24
	Identifier "Screen0"
	Device "Card0"
	Monitor "Monitor0"
    SubSection "Display"
    	Depth 24
    	Modes "1024x768" "1280x800" "1440x900" "1920x1080"
    EndSubSection
EndSection
EOF
##################

echo "Script Execution Complete.  The Video Dummy Driver is set up.  You should restart your computer and log in via VNC."




	
