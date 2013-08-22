#Introduction

Ever find yourself wanting to edit a story you wrote in Word and only have (gasp) Notepad available?  Or have to worry about changing a bunch of italics to bold or something like that when submitting to a publication?  Ever worry that the *next* version of word processing software won't be able to read your story?  Then markdown is for you.

[**Markdown**](http://daringfireball.net/projects/markdown/) is a markup syntax that lets you worry about your *words* without having to worry about *formatting*.  You will be able to - with one single tool called [pandoc](http://johnmacfarlane.net/pandoc/) - convert it to HTML, Word and Open Office documents, RTF, PDF (with LaTeX), and more.  Even better, it will be completely readable *and editable* pretty much to anyone, anywhere, with any kind of program - even Notepad!  Oh yeah - and it's free.

You can write in markdown in pretty much anything that can save to plain text.  All the markup happens afterward.

There is an *awful* lot of different "flavors" of markdown, and a lot of ways to do very fancy things - for example, [this cheat sheet is one of the simpler ones](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet).  But this is not for those people.  

This guide is for one group of people in particular:  Writers.  We use a lot of plain, straight text - but we do need a few basic formatting marks.  This is where Markdown excels.  (Markdown is *not* particularly good on its own for things like document revision, but we'll get to that.)  Markdown files are plain text files, and have a file extension (the bit to the right of the dot) of `md` or `mkd`.  And you can read them without any special software:

> The overriding design goal for Markdown’s formatting syntax is to make it as readable as possible. The idea is that a Markdown-formatted document should be publishable as-is, as plain text, without looking like it’s been marked up with tags or formatting instructions. While Markdown’s syntax has been influenced by several existing text-to-HTML filters, the single biggest source of inspiration for Markdown’s syntax is the format of plain text email.

Yeah, yeah, yeah.  So let's talk about what you actually need to have a story in standard manuscript format:

* Headers
* Paragraphs
* Italics
* Bold

That's what you *have* to know, and that's 99% of what you'll use.  "Advanced" formatting is after the bit on pandoc:

* Scene breaks
* Maybe a list
* Maybe a pagebreak

**NOTE:** There is often more than one way to do each thing.  I'm teaching you one.  There's a *lot* more you *can* do; check out [this cheatsheet.](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)

#Formatting  
##Headers  
You can have up to six levels of headers, based on how many # signs you have at the beginning of a line.  
###This is a third level heading  
####Fourth level...you get the idea.  

##Paragraphs  
Each paragraph is on a separate line *with a blank line inbetween*.  You can force a line break by leaving two spaces at the end of a line.  
This is a new line, for example.

##Italics and Bold  
Italics and bold are by surrounding the italics or bold character by one `*` for italics, and `**` for bold.  Bold *and* italics?  Use underscore.  
`*italics* **bold** **_bold and italics_**` becomes *italics* **bold** **_bold and italics_**

##Scene Breaks  
You already use it - three asterisks in a row, no spaces.  `***`  **Make sure you have your blank line before and after!**

***

#So why should I care?

Because this makes swapping formats *simple* and means that your story can - quite literally - be read by an `Apple ][e` that can read a plain text file.  Seriously - take a look at this file in "raw mode".  You can read it just fine.  Need to change italics to something else?  Replace them in the markdown file and then run pandoc on it again.  BDAOW.

#What is pandoc?

Pandoc is a free and GNU licensed program that converts... well, a whole ton of formats into other ones.  For our purposes, the most important conversion is markdown ([pandoc has a flavor of markdown too](http://johnmacfarlane.net/pandoc/demo/example9/pandocs-markdown.html) to HTML, OpenOffice, and Word.  Yes, it's a command-line tool.  It *does* have a frightening looking page full of instructions.  And it's *easy* to use for our purposes.

`pandoc myawesome.md -o myawesome.html`

That's it.  From that, it's a hop, skip, and a jump to Word, RTF, OpenOffice, and HTML.  You have to install LaTeX to get directly to PDF - [recommended installs for LaTeX for your operating system are here](http://johnmacfarlane.net/pandoc/installing.html).

-o means "output file".  Usually it can figure out what kind of output you want from the output file extension.  If you want to specify that manually, you use the -t switch.  For example:

* `pandoc myawesome.md -t docx -o myawesome.docx`
* `pandoc myawesome.md -t rtf -o myawesome.rtf`
* `pandoc myawesome.md -t odt -o myawesome.odt`
* `pandoc myawesome.md -t html -o myawesome.html`


##Pagebreak  
This is *only* for pandoc's conversion to PDF - you put `\pagebreak` at the beginning of the line. 

###If you see formatting marks  
You almost certainly didn't put a blank line inbetween two things or didn't put two spaces at the end of a line.  

#You mentioned revision tracking?  
Sort of.  Markdown is plain text.  Which means that you can use git, subversion, or other revision control software to track every change and who made it.  However, that's a wee bit nerdier than you probably want to be right now.
