#!/bin/bash

# 1. Check if Docker is installed, if not, install it
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Installing Docker..."
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # admin user to the docker group
    sudo groupadd docker
    sudo usermod -aG docker ${USER}
    su -s ${USER}
    docker run hello-world
fi

xhost +

# 2. Clone the repository and build docker compose
echo "Cloning repository and building docker compose..."

pip install vcstool
vcs import workspace_ws/src < docker/dependencies.repos

docker compose build exoreality_compose
docker compose up -d

docker compose exec -it exoreality_compose bash -c "cd ~/workspace_ws && colcon build --symlink-install"
docker compose down

read -p "Do you want to run the program now? (y/n): " choice
if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
    docker compose up -d
else
    echo "Exiting the script."
    exit 0
fi

