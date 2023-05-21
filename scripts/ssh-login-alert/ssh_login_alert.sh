# /etc/profile.d/ssh_login_alert.sh

if [ -n "$SSH_CLIENT" ]; then
    USER="${USER}"
    HOST="$(hostname -f)"
    IP="$(echo $SSH_CLIENT|awk '{print $1}')"
    curl --request POST \
    --url <DISCORD_WEBHOOK> \
    --header 'Content-Type: application/json' \
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
