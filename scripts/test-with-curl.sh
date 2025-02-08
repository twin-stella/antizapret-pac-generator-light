#!/bin/bash

function curl_open() {
    local WEBSITE="$1"

    curl --max-time 10 --compressed --fail --fail-early \
         -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0 antizapret.prostovpn.org anti-censorship tester' \
         "http://$WEBSITE" &> /dev/null
    RESULT_HTTP="$?"
    curl --max-time 10 --compressed --fail --fail-early \
         -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0 antizapret.prostovpn.org anti-censorship tester' \
         -k "https://$WEBSITE" &> /dev/null
    RESULT_HTTPS="$?"

    if [ "$RESULT_HTTP" -ne 0 ] && [ "$RESULT_HTTPS" -ne 0 ]; then
        # If both HTTP and HTTPS failed, the website doesn't work
        return 1
    fi
    return 0
}

WEBSITE="$1"
curl_open "$WEBSITE"
ERRCODE="$?"
if [ "$ERRCODE" -ne 0 ]; then
    #echo "$WEBSITE does not respond, marking as failed, not adding to the PAC list"
    echo "$WEBSITE"
fi
exit $ERRCODE
