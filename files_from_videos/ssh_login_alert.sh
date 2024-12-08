#!/bin/bash
WEBHOOK_URL="http://192.168.1.106:3033/api/push/Ea4FNgAEWo?status=up&msg=OK&ping=>
# Let's capture only open_session and close_session events (login and logout).
case "$PAM_TYPE" in
     open_session)
         PAYLOAD=" { \"content\": \"$PAM_USER logged in (remote host: $PAM_RHOST)>
         ;;
     close_session)
         PAYLOAD=" { \"content\": \"$PAM_USER logged out (remote host: $PAM_RHOST>
         ;;
esac
# Let's only perform a request if there is an actual payload to send.
if [ -n "$PAYLOAD" ] ; then
     curl "$WEBHOOK_URL"
fi
