#!/bin/bash

# Date: 	2013-11-26
# Author: 	maxfragg
# Version:  0.1
# License:  wtfpl
# simple bash script downloading youtube videos and extracting the audio stream with youtube-dl (python)
# uses /tmp/youtube-new as way to communicate with the cgi script
# if download is successfull, the video gets added to the mpd-queue

while [[ true ]]; do
	inotifywait -e close_write /tmp/youtube-new

	YOUTUBE_NEW=$(comm -3 <(sort "/tmp/youtube-new" | uniq) <(sort "/tmp/youtube-old" | uniq))

	for URL in $YOUTUBE_NEW; do
		echo "downloading: "$URL
		echo "$URL" >> /tmp/youtube-old
		filename=""
		filename=`youtube-dl -x -o "/media/1tb-0/musik/youtube-dl/%(title)s.%(ext)s" --restrict-filename $URL | grep "avconv"| cut -d' ' -f3| cut -d'/' -f6`
		if [[ filename == "" ]]; then
			continue
		fi
		mpc update --wait "youtube-dl"
		echo "adding: youtube-dl/$filename"
		mpc add "youtube-dl/$filename"

		mpc playlist -f '%position% %file%' | grep -i "$filename" | head -n1 | cut - -d " " -f 1 | xargs mpc play
	done
done

