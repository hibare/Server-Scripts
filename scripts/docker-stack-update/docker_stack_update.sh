#!/bin/bash

# Define the directory where your Docker Compose stacks are located
DOCKER_DIR="$HOME/docker"

# Array of directory names to skip
declare -a dirs_to_skip=("portainer")

# List all subdirectories in the Docker directory
for stack_dir in "$DOCKER_DIR"/*/; do
    
    if [ -d "$stack_dir" ] && [ -f "$stack_dir/docker-compose.yml" ]; then
        stack_name=$(basename "$stack_dir")
        
        # Check if the current directory's name is in the list of directories to skip
        skip_directory=false
        for dir_to_skip in "${dirs_to_skip[@]}"; do
            if [ "$stack_name" == "$dir_to_skip" ]; then
                echo "Skipping directory $stack_name."
                skip_directory=true
                break
            fi
        done

        # If the directory is marked for skipping, continue to the next one
        if [ "$skip_directory" == "true" ]; then
            continue
        fi

        echo "Checking stack $stack_name"

        # Get a list of running service names
        running_services=$(docker compose -f "$stack_dir/docker-compose.yml" ps --services)
        echo "Running services: $running_services"

        # Check if any services from the stack are running
        if [ -n "$running_services" ]; then
            echo "Stopping services in stack $stack_name..."
            docker compose -f "$stack_dir/docker-compose.yml" down
        fi

        # Pull the latest images
        echo "Pulling latest images for stack $stack_name..."
        docker compose -f "$stack_dir/docker-compose.yml" pull

        # Start only the running services
        if [ -n "$running_services" ]; then
            echo "Starting running services in stack $stack_name..."
            for service in $running_services; do
                echo "Starting service $service"
                docker compose -f "$stack_dir/docker-compose.yml" up -d "$service"
            done
        fi
    else
        echo "Skipping directory $stack_dir (no docker-compose.yml file found)"
    fi
done
