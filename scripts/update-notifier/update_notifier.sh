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
    packages="$(/usr/lib/update-notifier/apt-check --package-names 2>&1)"
    joined_packages=""

    while IFS= read -r line; do
        joined_packages+="\n$line"
    done <<< "$packages"

    message="${message}\n\nThe following packages need to be updated:${joined_packages}"
    
    curl --request POST \
        --url ${DISCORD_WEBHOOK_UPDATE_NOTIFIER} \
        --header 'Content-Type: application/json' \
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