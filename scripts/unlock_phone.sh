#!/bin/bash
#adb shell "dumpsys window | grep 'mAwake'"

PHONE_OFF='mWakefulness=Dozing'


state="$(adb shell "dumpsys power | grep 'mWakefulness='")"
password=${1:-"1523"}
# Remove white from the string state
state="${state// /}"

if [ "$state" == "$PHONE_OFF" ]
then
	echo "came here"
	adb shell "input keyevent 26"
fi
#adb shell "input keyevent 224"

if [ "$(adb shell "dumpsys window | grep -o 'mDreamingLockscreen=false'")" == '' ]
then
	adb shell "locksettings clear --old $password"
	adb shell "input swipe 300 1200 300 300 100"
	adb shell "input keyevent 4"
	adb shell "input swipe 300 1200 300 300 100"
	adb shell "locksettings set-pattern $password"
fi

