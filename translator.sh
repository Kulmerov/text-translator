#!/bin/bash
selected_text=$(xsel -o)
response_from_server=$(wget -U "Opera/9.80 (J2ME/MIDP; Opera Mini/4.5.33867/35.2883; U; en) Presto/2.8.119 Version/11.10" -qO - "https://translate.google.ru/m?hl=ru&sl=auto&tl=ru&ie=UTF-8&prev=_m&q=$(echo $selected_text)&num=0")
parsed_response=$(echo "$response_from_server" | grep -o -P '<b><\/b>\K.*(?=<br><br><\/div><form)' | sed 's/^....//' | sed "s/<br>/\n/g")
if [ "$parsed_response" == "" ]
then
	parsed_response=$(echo "$response_from_server" | grep -o -P '<div dir="ltr" class="t0">\K.*(?=<\/div><form)')
fi
echo $parsed_response
notify-send "$selected_text" "$parsed_response" -i accessories-dictionary