#!/bin/bash

docker_dir=/path/to/container/directory/
containers=(authelia bitwarden_rs) # Is a list of directories under above path having docker-compose.yml file

echo "Docker directory: ${docker_dir}"
echo "Containers: ${#containers[*]}"

for container in ${containers[@]}; do
	container_dir=${docker_dir}/${container}
	echo ""
	echo "Starting ${container}"
	cd ${container_dir}
	docker-compose up -d
done
