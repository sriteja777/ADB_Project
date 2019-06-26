#!/bin/bash

cd /home/sriteja/adb/contacts
dir=$(pwd)
if [ "$dir" == /home/sriteja/adb/contacts ]
then
	rm *
fi
adb shell "su -c \"sqlite3 /data/data/com.android.providers.contacts/databases/contacts2.db 'select number, name from view_v1_phones'\"" | uniq | while read i
do
	number=$(echo $i | cut -d '|' -f 1)
	name=$(echo $i | cut -d '|' -f 2)
	name=${name%$'\r'}
	number=${number%$'\r'}
	name=${name//\//-}
	#echo $name
	#echo $number
	echo "$number" > "$name"
	#echo $name, $number
	#	echo  "$name"

	#echo "$number"

done
