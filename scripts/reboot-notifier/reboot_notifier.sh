#!/bin/bash

# Check if the system requires a reboot
if [ -f /var/run/reboot-required ]; then  
  HOST="$(hostname -f)"
  
  curl --request POST \
    --url ${DISCORD_WEBHOOK_UPDATE_NOTIFIER} \
    --header 'Content-Type: application/json' \
    --data '{
    "username": "Server Reboot",
    "avatar_url": "https://i.imgur.com/4M34hi2.png",
    "embeds": [
        {
        "title": ":fire: Reboot Required",
        "color": 14590998,
        "fields": [
            {
            "name": "Server",
            "value": "'"$HOST"'",
            "inline": true
            }
        ]
        }
    ]
    }'
fi
