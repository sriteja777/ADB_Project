#!/bin/bash

string=''
store_IFS="$IFS"                # Storing current IFS value
IFS=                            # Setting IFS to Null to space characters to enter
while true              
do
    read -sN 1 k                 # -n for reading byte by byte  and -s is to suppress the printing of input.

    if [ "$k" = $'\n' ]
    then
     	adb shell "input keyevent KEYCODE_SEARCH"   
    fi

    

    if [ "$k" = $'\177' ] && [ -n "$string" ]    # Check whether it is backspace and string is not empty
    then
        printf %b "\b \b"         # '\b' moves the cursor 1 unit left and then printing '\b' then again moves the cursor left so that it looks like a character erased :)
        string=${string::-1}     # Now remove the last character from the string
        adb shell "input keyevent KEYCODE_DEL" &

        continue
    fi

    # Now check for each delimiter you want.
    # case $k in
    # [Ee])
    #     break   
    #     ;;  
    # esac

    # Now Concatenate that byte with the previous input string
    string+=$k
    adb shell "input text '$k'" &
    printf '%s' "$k"  # Now print the current inputted char
done
IFS="$store_IFS"        # Restoring IFS value
printf '\n%s\n' "Your string -> $string"