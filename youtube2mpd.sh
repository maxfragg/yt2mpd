#!/bin/bash

# Date:     2013-11-26
# Author:   maxfragg
# Version:  0.1
# License:  wtfpl
# Based on http://www.yolinux.com/TUTORIALS/BashShellCgi.html

# Simple CGI Script recieving youtube urls via input field, and passing them
# to the ytgetter.sh running in background for asyncronous downloads
# Uses urldecode.sed from
# http://gimi.name/snippets/urlencode-and-urldecode-for-bash-scripting-using-sed/
# to decode the urlencoded youtubeurl

echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>youtube2mpd</title>'
#echo '<link rel="stylesheet" type="text/css"href="style.css" />'
echo '<style type="text/css">'
cat style.css
echo '</style>'
echo '</head>'
echo '<body>'
echo '<div id="youtube">'
echo 'youtube 2 mpd'
echo '</div>'
echo "<br>"
echo '<div id="container">'
  echo "<form method=GET action=\"${SCRIPT}\">"\
       '<table nowrap>'\
          '<tr><td>Input</TD><TD><input type="text" name="youtubeurl" size=12 id="input"></td></tr>'\
          '</tr></table>'

  echo '<br><input type="submit" value="get video" id="button">'\
       '<input type="reset" value="reset" id="button"></form>'

  # Make sure we have been invoked properly.

  if [ "$REQUEST_METHOD" != "GET" ]; then
        echo "<hr>Script Error:"\
             "<br>Usage error, cannot complete request, REQUEST_METHOD!=GET."\
             "<br>Check your FORM declaration and be sure to use METHOD=\"GET\".<hr>"
        exit 1
  fi

  # If no search arguments, exit gracefully now.

  if [ -n "$QUERY_STRING" ]; then
    # No looping this time, just extract the data you are looking for with sed:
    XX=`echo "$QUERY_STRING" | sed -n 's/^.*youtubeurl=\([^&]*\).*$/\1/p' | sed "s/%20/ /g" | sed -f urldecode.sed`

    echo "youtubeurl: " $XX

    echo $XX>>/tmp/youtube-new
     
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0
