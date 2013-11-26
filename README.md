yt2mpd
======

youtube to mpd scripts, using bash-cgi and youtube-dl to download and play youtube videos on a mpd

youtube2mpd.sh
==============
cgi-script, that needs to be run by a cgi-webserver
you only need to configure the path to the youtube-new file

ytgetter.sh
===========
bashscript to be run in the background as a deamon, used to make the slow downloads asyncronous to the website-part.
you will need to change path to youtube-new, youtube-old and the fullpath to the youtube-dl directory, just like the relative path used by mpd