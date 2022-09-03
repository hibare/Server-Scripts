# /etc/profile.d/ssh_login_alert.sh

if [ -n "$SSH_CLIENT" ]; then
    USER="${USER}"
    HOST="$(hostname -f)"
    IP="$(echo $SSH_CLIENT|awk '{print $1}')"
    curl --request POST \
    --url <DISCORD_WEBHOOK> \
    --header 'Content-Type: application/json' \
    --cookie '__dcfduid=02a5cd2e1b2f11ed8765468f320d6606; __sdcfduid=02a5cd2e1b2f11ed8765468f320d6606797678dd30562f3264189e08596be9d00b508cd40758e24373b2e5709368bb99; __cfruid=3f8ffd757b569362eeffda5d533230c19d983406-1660412424' \
    --data '{
    "username": "Server Notifications",
    "avatar_url": "https://i.imgur.com/4M34hi2.png",
    "embeds": [
        {
        "title": ":fire: New Login",
        "description": "New successful login detected",
        "color": 16711680,
        "fields": [
            {
            "name": "Server",
            "value": "'"$HOST"'",
            "inline": true
            },
            {
            "name": "User",
            "value": "'"$USER"'",
            "inline": true
            },
            {
            "name": "Source IP",
            "value": "'"$IP"'"
            }
        ]
        }
    ]
    }'
fi
