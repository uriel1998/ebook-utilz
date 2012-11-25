#!/bin/bash
#
#$1 - full path
#$2 - directory
#$3 - filename
#

	time=`date +_%Y%m%d_%H%M%S` 
	name=${3%.*}	
	newname=$(echo "$2$name$time.epub")
	cp $1 $newname
	kindlegen $newname
	tmpname=$(basename $newname)
	name=${tmpname%.*}
	kindlename=$(echo "$name.mobi")
	/usr/local/bin/kindlestrip.py $kindlename $2$kindlename.trim
	rm -f $2$kindlename
	mv -f $2$kindlename.trim $2$kindlename
