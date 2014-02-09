#! /bin/bash

# call by refent.sh [SECTION]

if [ "$1" == "" ]; then
	szAnswer=$(zenity --entry --text "What to search for?"); echo "$szAnswer"; awk -F "\t" -v matchme="${szAnswer}" 'tolower($4) ~ matchme' refent.txt | zenity --text-info --width 400 --height 400 --title="$szAnswer" 
else

	section=$(echo "${1^^}")
	case "$section" in
		"GR"*) cat refent.txt | sed -e '/./{H;$!d;}' -e 'x;/GREEK/!d;' | zenity --text-info --width 400 --height 400 --title="$1" ;;
		"SYM"*) cat refent.txt | sed -e '/./{H;$!d;}' -e 'x;/SYMBOL/!d;' | column  -c 2 | zenity --text-info --width 400 --height 400 --title="$1" ;;
		"ACC"*) cat refent.txt | sed -e '/./{H;$!d;}' -e 'x;/ACCENTS/!d;' | zenity --text-info --width 400 --height 400 --title="$1" ;;
		"MA"*) cat refent.txt | sed -e '/./{H;$!d;}' -e 'x;/MATHS/!d;' | column -c 2 | zenity --text-info --width 400 --height 400 --title="$1" ;;
		"*") echo "You need to choose an appropriate section" ;;		
	esac
fi

