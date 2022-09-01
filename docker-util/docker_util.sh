#!/bin/bash

# Crontab entry: 45 22 * * * bash /home/shubham/scripts/docker_util.sh purge

docker_dir=/home/shubham/docker
containers=(redis mysql postgres adminer bookstack gitea gokapi homarr nextcloud portainer vaultwarden yts_bot authelia caddy go-container-status go-rss-hub pihole site_hibare wireguard)

for (( i=${#containers[@]}-1; i>=0; i-- )) do 
    reversed_containers[${#reversed_containers[@]}]=${containers[i]}
done

run_for_all_containers() {
    local command=$1
    shift
    local _containers=("$@")

    echo "[Command]: ${command}"
    echo ""

    for container in ${_containers[@]}; do
        container_dir=${docker_dir}/${container}
        echo ""
        echo "[Container]: ${container}"
        cd ${container_dir}
        eval "$command"
    done

}

container_up(){
    command='docker compose up -d'
    run_for_all_containers "$command" "${containers[@]}"
}

container_down(){
    command='docker compose down'
    run_for_all_containers "$command" "${reversed_containers[@]}"
}

container_restart(){
    container_down
    container_up
}

container_update(){
    command='docker compose down; docker compose pull; docker compose up -d'
    run_for_all_containers "$command" "${containers[@]}"
    docker system prune --all
}

container_log_purge(){
    container_down
    find /var/lib/docker/containers/ -type f -name “*.log” -delete
    container_up
}

case $1 in
    up)
        container_up
        ;;
    down)
        container_down
        ;;
    restart)
        container_restart
        ;;
    update)
        container_update
        ;;
    purge)
        container_log_purge
        ;;
    *)
        echo "[Error] No command supplied / Invalid command supplied."
esac