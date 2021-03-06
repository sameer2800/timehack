#!/bin/bash

#  _  ___   _ _   _  ____   _____ _   _ ______   __           ____ ___ _____ 
# | |/ / | | | \ | |/ ___| |  ___| | | |  _ \ \ / /    _     / ___|_ _|_   _|
# | ' /| | | |  \| | |  _  | |_  | | | | |_) \ V /   _| |_  | |  _ | |  | |  
# | . \| |_| | |\  | |_| | |  _| | |_| |  _ < | |   |_   _| | |_| || |  | |  
# |_|\_\\___/|_| \_|\____| |_|    \___/|_| \_\|_|     |_|    \____|___| |_|  
#                                                                                                                        
# A bash script in the theme of Kung Fury, utilizing git --date to commit 
# in the past. Effectivly hacking you back in time.

# Git commits are done on a once per-day psuedo-random coin flip basis from the
# chosen start date. Simply run this again if your desired commit density is
# less than desired.

# Watch this to get GUI movie References: https://youtu.be/bS5P_LAqiVg?t=9m52s

# Author: William Golembieski
# Email: BillGolembieski@projectu23.com

###############################################################################

# Wanted to see how many times this is run. Simple google analytics.
export analytics_id="UA-89577187-1"
export category="AppCounter"
export action="CountAction"
export label="CountLabel"
export value="1"

curl -s -X POST \
        -d 'v=1&tid='"$analytics_id"'&cid=555&t=event&ec='"$category"\
        '&ea='"$action"'&el='"$label"'&ev='"$value"'' \
        -H "User-Agent: AppSpecific" \
        https://www.google-analytics.com/collect > /dev/null &
        
###############################################################################

# Check if user is root
if [ "$EUID" -ne 0 ]; then
	echo "Please run as root. Try sudo bash timehack"
	exit
fi

###############################################################################

# Load Complete
dialog --backtitle "GitHub Time Hacker" --infobox "LOAD COMPLETE." 3 20
sleep 1.25

###############################################################################

# Initializing Hack Sequence
export hacker_github_name=""
export hacker_email=""

exec 3>&1

dialog --separate-widget $'\n' --ok-label "Submit" \
	--backtitle "GitHub Time Hacker" \
	--title "INITIALIZING HACK SEQUENCE" \
	--form "\nEnter GitHub information:\nUse arrows or click to move" \
	12 50 0 \
	"Username:" 1 1 "$hacker_github_name" 1 10 20 0 \
	"Email:" 2 1 "$hacker_email" 2 10 40 0 \
2>&1 1>&3 |{
	read -r hacker_github_name
	read -r hacker_email
	exitcode=$?

	if [ "$exitcode" = 0 ]; then
		git config --global credential.helper cache
		git config --global credential.helper 'cache --timeout=600'
		git config --global user.email "$hacker_email"
		git config --global user.name "$hacker_github_name"
		git config --global push.default simple

	else
		echo
		echo "Aborted"
		exit
	fi
}
exec 3>&-
    
###############################################################################

# Initalizing Time Portal Screens
dialog --backtitle "GitHub Time Hacker" \
	--infobox "INITIALIZING TIME PORTAL." 3 31
sleep .9

dialog --backtitle "GitHub Time Hacker" \
	--infobox "INITIALIZING TIME PORTAL.." 3 31
sleep .9

dialog --backtitle "GitHub Time Hacker" \
	--infobox "INITIALIZING TIME PORTAL..." 3 31
sleep .9

###############################################################################

# Calender & Commit
date_picked=$(dialog --stdout --title "TIME PORTAL" \
		--backtitle "GitHub Time Hacker" \
		--no-cancel \
		--date-format '%Y%m%d' \
		--calendar "\nSelect a date to hack\nback in time to:" \
		0 0)
                 
if [ "$date_picked" != "" ]; then
	d1=$(date -d "00:00" +%s)
	d2=$(date -d $date_picked +%s)
	days_diff=$(( ($d1-$d2) / 86400 ))
else
    echo
    echo "Aborted"
	exit
fi

daysHacked=0
until [ "$daysHacked" -eq "$days_diff" ]
do
	FLIP=$(($RANDOM%10))
	
	if [ $FLIP -ge 2 ]; then 
	d=$(date -d "$date_picked + $daysHacked days" +%b" "%d" 00:00 "%Y)
	git commit --quiet --allow-empty --date="$d" -m "Hacked Time"
		if [ $FLIP -ge 4 ]; then 
	git commit --quiet --allow-empty --date="$d" -m "Hacked Time 2x"
	git commit --quiet --allow-empty --date="$d" -m "Hacked Time 2x"
			if [ $FLIP -ge 8 ]; then
	git commit --quiet --allow-empty --date="$d" -m "Hacked Time 3x"
	git commit --quiet --allow-empty --date="$d" -m "Hacked Time 3x"
	git commit --quiet --allow-empty --date="$d" -m "Hacked Time 3x"
				if [ $FLIP = 9 ]; then 
	git commit --quiet --allow-empty --date="$d" -m "Hacked Time 4x"
	git commit --quiet --allow-empty --date="$d" -m "Hacked Time 4x"
				fi
			fi
		fi
	fi
((daysHacked++))
done

###############################################################################

# E = mc2 Converter
COUNT=10
(
while test $COUNT != 110
do
	echo $COUNT
	echo "XXX"
	echo "CONVERSION ALGORITHMS RUNNING"
	echo "XXX"
	COUNT=`expr $COUNT + 10`
	sleep .5
done
) | dialog --title "E = mc2 CONVERTER" --gauge "" 8 70 0

###############################################################################

# E = mc3 message
dialog --backtitle "GitHub Time Hacker" \
	--infobox "E = mc3" 3 31
sleep .9

dialog --backtitle "GitHub Time Hacker" \
	--infobox " " 3 31
sleep .9

dialog --backtitle "GitHub Time Hacker" \
	--infobox "E = mc3" 3 31
sleep .9

dialog --backtitle "GitHub Time Hacker" \
	--infobox " " 3 31
sleep .9
dialog --backtitle "GitHub Time Hacker" \
	--infobox "E = mc3" 3 31
sleep .9

###############################################################################

# You are about to hack time are you sure?
dialog --backtitle "GitHub Time Hacker" \
	--title "WARNING" \
	--yesno "\nYOU'RE ABOUT\nTO HACK TIME,\nARE YOU SURE?" 10 30
       
yn_response=$?
case $yn_response in
	0) git push;;
	1) echo "Aborted";;
	255) echo "Aborted";;
esac