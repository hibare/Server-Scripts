#!/bin/bash

# Define the directory where your Docker Compose stacks are located
DOCKER_DIR="$HOME/docker"

# Flag to indicate whether it's a dry run
dry_run=false

# Function to print usage information
usage() {
    echo "Usage: $0 [-n]"
    echo "  -d: Dry run mode (do not execute Docker commands)"
    exit 1
}

# Parse command-line options
while getopts ":d" opt; do
    case ${opt} in
        d)
            dry_run=true
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            usage
            ;;
    esac
done
shift $((OPTIND -1))

# Get a list of running stack names
running_stacks=$(docker stack ls --format '{{.Name}}' 2>/dev/null)

# List all subdirectories in the Docker directory
for stack_dir in "$DOCKER_DIR"/*/; do
    echo "---"

    if [ -d "$stack_dir" ] && [ -f "$stack_dir/docker-compose.yml" ]; then
        stack_name=$(basename "$stack_dir")

        # Check if the current directory's name is in the list of running stack names
        if echo "$running_stacks" | grep -q -w "$stack_name"; then
            echo "⛔️ Skipping directory $stack_name (running as a stack)"
            continue
        fi

        echo "🔍 Checking stack $stack_name"

        # Get a list of previously running service names
        previous_running_services=$(docker compose -f "$stack_dir/docker-compose.yml" ps --services)

        # Check if any services from the stack were previously running
        if [ -z "$previous_running_services" ]; then
            echo "⚠️ No previously running services found in stack $stack_name. Skipping start... "
            continue
        fi

        echo "🚀 Previously running services: $previous_running_services"

        echo "🛑 Stopping services in stack $stack_name"
        if [ "$dry_run" = false ]; then
            echo "🔧 Executing: docker compose -f $stack_dir/docker-compose.yml down"
            docker compose -f "$stack_dir/docker-compose.yml" down
        else
            echo "🚫 Dry run: Skipping command: docker compose -f $stack_dir/docker-compose.yml down"
        fi

        echo "📥 Pulling latest images for stack $stack_name"
        if [ "$dry_run" = false ]; then
            echo "🚚 Executing: docker compose -f $stack_dir/docker-compose.yml pull"
            docker compose -f "$stack_dir/docker-compose.yml" pull
        else
            echo "🚫 Dry run: Skipping command: docker compose -f $stack_dir/docker-compose.yml pull"
        fi

        echo "🚀 Starting previously running services in stack $stack_name"
        if [ "$dry_run" = false ]; then
            for service in $previous_running_services; do
                echo "🔧 Executing: docker compose -f $stack_dir/docker-compose.yml up -d $service"
                docker compose -f "$stack_dir/docker-compose.yml" up -d "$service"
            done
        else
            echo "🚫 Dry run: Skipping command: docker compose -f $stack_dir/docker-compose.yml up -d"
        fi
    else
        echo "⛔️ Skipping directory $stack_dir (no docker-compose.yml file found)"
    fi
done
