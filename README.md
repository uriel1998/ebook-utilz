ebook-utilz
===========

Utilities I use for ePub Creation  YMMV.

###doc2html
This will use OpenOffice and/or LibreOffice to produce pretty darn clean HTML at the backend, fit for our use with ePub.  Uses HTMLTidy and some specific SED expressions to smarten (yes, smarten) your quotes near-automagically.  It also embeds it into the base.html included in this repository.

###helper.sh
It helps us, it does.  Run in your OEPBS directory.

###refent.sh and refent.txt
A bash script and text file to bring up examples of reference entities and their corresponding codes.

###version_ebook.sh
So I can have versions without using (ironically, perhaps) Git.

###epubcheck.sh
A bash script to automagically call epubcheck and output the results to Zenity

###style.css
My style.css

###base.html
My base document when creating ePubs.

###content.opf
An example content.opf

##ReadMeFirst.md
This is a file included with eBooks to help readers get the books onto their device(s).  Note - you'll want to have a pandoc template with these options (as explained [here](http://tex.stackexchange.com/questions/823/remove-ugly-borders-around-clickable-cross-references-and-hyperlinks/12408#12408).   
<pre>\usepackage{xcolor}
\definecolor{dark-red}{rgb}{0.4,0.15,0.15}
\definecolor{dark-blue}{rgb}{0.15,0.15,0.4}
\definecolor{medium-blue}{rgb}{0,0,0.5}
\hypersetup{
    colorlinks, linkcolor={dark-red},
    citecolor={dark-blue}, urlcolor={medium-blue}
}</pre>
