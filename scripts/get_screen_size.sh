#!/bin/bash

# store_ifs="$IFS"

output="$(adb shell wm size)"
redundant_text="Physical size: "
output="${output/$redundant_text/}"
output="${output/x/ }"


echo "$output"

# IFS='x'
# sizes=()
# j=0
# for i in $output
# do
# 	sizes[$j]=$i
# 	j=$((j+1))
# done

# IFS="$store_ifs"
# echo "${sizes[@]}"