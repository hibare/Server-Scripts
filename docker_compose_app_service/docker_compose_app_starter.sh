#!/bin/bash

docker_dir=/home/shubham/server_data/docker
containers=(authelia bitwarden_rs caddy diun minio mysql outline pihole planka portainer postgres postwoman redis site_hibare traefik wireguard)

echo "Docker directory: ${docker_dir}"
echo "Containers: ${#containers[*]}"

for container in ${containers[@]}; do
	container_dir=${docker_dir}/${container}
	echo ""
	echo "Starting ${container}"
	cd ${container_dir}
	docker-compose up -d
done
