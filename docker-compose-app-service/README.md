# Docker compose service

A service to start all docker-compose stacks on system boot after docker service is loaded.

Clone the repository on server.

Edit `docker_compose_app_starter.sh` file. Change following lines

```
docker_dir=/path/to/container/directory/
containers=(authelia bitwarden_rs) # Is a list of directories under above path having docker-compose.yml file
```

Edit `docker_compose_app.service` file & change following line
```shell
ExecStart=/bin/bash /path/to/docker_compose_app_starter.sh
 ```
 
Copy `docker_compose_app.service` to `/etc/systemd/system/`

Run following command to enable service.
```shell
sudo systemctl enable  docker_compose_app
```
