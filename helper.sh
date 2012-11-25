#!/bin/bash

# CODE FOR DOING IMAGES
# <div id="" width="100%" class="center"><img width="100" src="images/9780983263111.png" alt="divider"/></div>
# set div width, then img width is to the div!

#base html document for OEPBS files
base="/home/USER/Vault/base.html"

echo "What is this run for? [i]nitial, [c]ontent.opf, [t]oc.ncx, [s]pecial (e.g. TOC), [Q]uit?"
echo "You are currently in $PWD,"
echo "which should be your OEPBS directory."
read option
case "$option" in 
	# create content.opf
	[Cc]*)
		echo '<?xml version="1.0" encoding="UTF-8"?>' > content.opf
		echo '<package xmlns="http://www.idpf.org/2007/opf" unique-identifier="BookId" version="2.0">' >> content.opf
		echo '<metadata xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:opf="http://www.idpf.org/2007/opf">' >> content.opf
		echo "What is the title of the eBook?"
		read booktitle
		echo '	<dc:title>'$booktitle'</dc:title>' >> content.opf
		echo "Remember that you have to add authors, descriptions, and BISAC codes manually."
		echo '	<dc:creator opf:file-as="" opf:role="aut">AuthorFirst AuthorLast</dc:creator>' >> content.opf
		echo '	<dc:subject>Subject in Plain Language</dc:subject>' >> content.opf
		echo '	<dc:description>Back cover blurb goes here</dc:description>' >> content.opf
		echo '	<dc:publisher>Alliteration Ink</dc:publisher>' >> content.opf
		createdate=$(date +%F)
		echo '	<dc:date>'$createdate'</dc:date>' >> content.opf
		echo "What is your ISBN?"
		read ISBN
		echo '	<dc:identifier id="BookId" opf:scheme="ISBN">'$ISBN'</dc:identifier>' >> content.opf	
		#change if not in English, obvs.
		echo '	<dc:language>en</dc:language>' >> content.opf
		echo '	<dc:rights>All rights reserved by publisher or author as applicable.</dc:rights>' >> content.opf
		echo '	<dc:relation>http://alliterationink.com</dc:relation>' >> content.opf
		echo "What is your SRP?"
		read srp
		echo '	<meta name="srp-usd" content="'$srp'"/>' >> content.opf
		echo '	<meta name="eISBN" content="'$ISBN'"/>' >> content.opf

		#We presume that images are in a subdirectory named images
		#We presume that your cover filename starts with the ISBN
		#We presume that you're using either JPG or PNG or JPEG
		#We presume that you're not doing them ALL like a moron.

		if [ -f "$PWD/images/$ISBN.jpeg" ]; then
			coverfile=$(echo "$ISBN.jpeg")
		fi
		if [ -f "$PWD/images/$ISBN.jpg" ]; then
			coverfile=$(echo "$ISBN.jpg")
		fi
		if [ -f "$PWD/images/$ISBN.png" ]; then
			coverfile=$(echo "$ISBN.png")
		fi
		
		echo '	<meta name="cover" content="images_'$coverfile'"/>' >> content.opf
		echo '	<meta name="BISAC" content="BISACCODE HERE"/>' >> content.opf
		echo '</metadata>' >> content.opf
		echo '<manifest>' >> content.opf
		echo '	<item id="ncx" href="toc.ncx" media-type="application/x-dtbncx+xml"/>' >> content.opf
		echo '	<item id="style" href="style.css" media-type="text/css"/>' >> content.opf

		# now to run through the html files in the manifest
		b=$(echo "1")
		for f in *.html; do 
		echo '		<item id="a_0'$b'" href="'$f'" media-type="application/xhtml+xml"/>' >> content.opf
		b=$(echo "scale=0; $b+1" | bc)
		done
	
		# now for the images - note that the cover is accounted for here as well
		# substitute the appropriate extension
		# substitute the appropriate mimetype - for example, ppm is image/x-portable-pixmap	
		# reference is here:  http://www.w3schools.com/media/media_mimeref.asp
		for i in ./images/*.png; do
		if [ -f $i ];then
			NUMBER=$[ ( $RANDOM % 900 )  + 1 ]
			# necessary to get rid of extra stuff ...
			imgfile=$(echo "$i" | /bin/sed -e 's/\.\/images\///g')
			echo '	        <item id="i_'$imgfile'_'$NUMBER'" href="images/'$imgfile'" media-type="image/png" />' >> content.opf
		fi
		done        
		for i in ./images/*.jpg; do
		if [ -f $i ];then
			NUMBER=$[ ( $RANDOM % 900 )  + 1 ]
			imgfile=$(echo "$i" | /bin/sed -e 's/\.\/images\///g')			
			echo '	        <item id="i_'$imgfile'_'$NUMBER'" href="images/'$imgfile'" media-type="image/jpeg" />' >> content.opf
		fi
		done        
		for i in ./images/*.jpeg; do
		if [ -f $i ];then
			NUMBER=$[ ( $RANDOM % 900 )  + 1 ]
			imgfile=$(echo "$i" | /bin/sed -e 's/\.\/images\///g')			
			echo '	        <item id="i_'$imgfile'_'$NUMBER'" href="images/'$imgfile'" media-type="image/jpeg" />' >> content.opf
		fi
		done        	
		for i in ./images/*.gif; do
		if [ -f $i ];then
			NUMBER=$[ ( $RANDOM % 900 )  + 1 ]
			imgfile=$(echo "$i" | /bin/sed -e 's/\.\/images\///g')			
			echo '	        <item id="i_'$imgfile'_'$NUMBER'" href="images/'$imgfile'" media-type="image/gif" />' >> content.opf
		fi
		done        

		# repeat for the spine
		echo '</manifest>' >> content.opf
		echo '<spine toc="ncx">' >> content.opf
		b=$(echo "1")
		for f in *.html; do 
		echo '	<itemref idref="a_0'$b'"/>' >> content.opf
		b=$(echo "scale=0; $b+1" | bc)
		done
		echo '</spine>' >> content.opf

		echo '<guide>' >> content.opf
		echo '        <reference type="cover" title="Book Cover" href="images/'$coverfile'" />' >> content.opf
	
		# I suppose we could use the title trick (see below) to autofill, but...
		echo '        <reference type="toc" title="Table of Contents" href="section_002.html" />' >> content.opf
		echo '        <reference type="copyright-page" title="Copyright Page" href="section_001.html" />' >> content.opf
		echo '</guide>' >> content.opf
		echo '</package>' >> content.opf
		echo "content.opf created."				
	;;
	# create toc.ncx
	[Tt]*)
		echo "What is the title of the eBook?"
		read booktitle
		echo "What is your ISBN?"
		read ISBN
		# putting the header on 
		echo '<?xml version="1.0" encoding="utf-8" ?>' > toc.ncx
		echo '<!DOCTYPE ncx PUBLIC "-//NISO//DTD ncx 2005-1//EN" "http://www.daisy.org/z3986/2005/ncx-2005-1.dtd"> ' >> toc.ncx
		echo '<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" xml:lang="en" version="2005-1">' >> toc.ncx
		echo '	<head>' >> toc.ncx
		echo '		<meta name="dtb:uid" content="'$ISBN'" />' >> toc.ncx
		echo '		<meta name="dtb:depth" content="1" />' >> toc.ncx
		echo '		<meta name="dtb:totalPageCount" content="0" />' >> toc.ncx
		echo '		<meta name="dtb:maxPageNumber" content="0" />' >> toc.ncx
		echo '	</head>' >> toc.ncx
		echo '  <docTitle>' >> toc.ncx
		echo '		<text>'$booktitle'</text>' >> toc.ncx
		echo '  </docTitle>' >> toc.ncx
		echo '  <navMap>' >> toc.ncx
		# now for the fun part... it is VITAL that the files are in the right order...
		# numbering starts at one...
		b=$(echo "1")
		for f in *.html; do 
		echo '		<navPoint id="navPoint-'$b'" playOrder="'$b'">' >> toc.ncx
		echo '			<navLabel>' >> toc.ncx
		chaptitle=$(grep "<title>" $f | awk -F ">" '{print $2}' |awk -F "<" '{print $1}')
		#errorchecking
		if [ "$chaptitle" = "" ]; then
			chaptitle=$(echo "$booktitle")
		fi
		echo '				<text>'$chaptitle'</text>' >> toc.ncx
		echo '			</navLabel>' >> toc.ncx
		echo '			<content src="'$f'" />' >> toc.ncx
		echo '		</navPoint>' >> toc.ncx
		b=$(echo "scale=0; $b+1" | bc)
		done
		echo '	      </navMap>' >> toc.ncx
		echo '	</ncx>  ' >> toc.ncx
		echo "toc.ncx created."		
	;;
	[Ss]*)
		echo "Creating ToC to be cut-and-pasted as $PWD/toc.tmp"
		# now for the fun part... it is VITAL that the files are in the right order...
		# numbering starts at one...
		b=$(echo "1")
		for f in *.html; do 
		chaptitle=$(grep "<title>" $f | awk -F ">" '{print $2}' |awk -F "<" '{print $1}')
		#errorchecking
		if [ "$chaptitle" = "" ]; then
			chaptitle=$(echo "$booktitle")
		fi
		echo '<p class="toc"><a href="'$f'">'$chaptitle'</a></p>' >> toc.tmp
		done
		echo "ToC created.  Cut and paste, then delete tempfile."		
	;;
	# create base documents
	[Ii]*)
		echo "How many base documents do you wish to create in $PWD?"
		echo "This is # of chapters, plus cover, front matter, about author, toc."
		echo "Usually add 4-5 sections.  Extra are better at this stage."
		read LIMIT
		# Double parentheses, and "LIMIT" with no "$".
		for ((a=0; a <= LIMIT ; a++))  
			do
			name=$(printf '%03d' $a)
			echo "Writing $PWD/section_$name.html"
			cp "$base" "$PWD/section_$name.html"
			b=$(echo "scale=0; $a+1" | bc)			
			done
		echo "Base documents created."
	;;
	# exit
	*)
		echo "So long, sweetie!"
	;;
esac
