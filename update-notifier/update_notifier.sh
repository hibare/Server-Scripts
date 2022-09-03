#!/bin/bash

message=""
server="$(hostname -f)"

IFS=';' read updates security_updates < <(/usr/lib/update-notifier/apt-check 2>&1)

if [ $updates -gt 0 ]
then
    message="${message}${updates} updates can be applied immediately."
fi

if [ $security_updates -gt 0 ]
then
    message="${message}\n${security_updates} of these updates are standard security updates."
fi

if [ ! -z "$message"  ]
then
    curl --request POST \
        --url <DISCORD_WEBHOOK> \
        --header 'Content-Type: application/json' \
        --cookie '__dcfduid=02a5cd2e1b2f11ed8765468f320d6606; __sdcfduid=02a5cd2e1b2f11ed8765468f320d6606797678dd30562f3264189e08596be9d00b508cd40758e24373b2e5709368bb99; __cfruid=00e54275ec73526a836ce2134b7f86f109a360ec-1661773699' \
        --data '{
        "username": "Server Notifications",
        "avatar_url": "https://i.imgur.com/4M34hi2.png",
        "embeds": [
            {
            "title": ":gear: Updates Available",
            "color": 16248591,
            "fields": [
                {
                "name": "Server",
                "value": "'"$server"'"
                }
            ],
                    "description": "```'"$message"'```"
            }
        ]
        }
        '
fi