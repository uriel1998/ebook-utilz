#!/bin/bash

java -jar /home/USER/epubcheck-3.0b5.jar "$1" 2>&1| zenity --text-info --width 1200 --height 400

