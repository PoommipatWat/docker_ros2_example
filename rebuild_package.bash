sudo rm -rf abu2024_ws
sed -i '/source \/home\/abu2024_ws\/install\/setup\.bash/d' docker/bashrc
git clone https://github.com/Entity014/abu2024_ws.git
docker compose build abu_compose
docker compose up -d
docker compose exec -it abu_compose bash -c "source .bashrc && cd ~/abu2024_ws/src/abu_description && rm -rf worlds && git clone https://github.com/PoommipatWat/worlds.git"
docker compose exec -it abu_compose bash -c "source .bashrc && cd ~/abu2024_ws/src && rm -rf abu_moveit && rm -rf abu_moveit_config"
docker compose exec -it abu_compose bash -c "source .bashrc && cd ~/abu2024_ws && colcon build && source install/setup.bash"
docker compose down
echo "source /home/abu2024_ws/install/setup.bash" >> docker/bashrc

xhost +
read -p "Do you want to run the program now? (y/n): " choice
if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
    docker compose up -d
else
    echo "Exiting the script."
    exit 0
fi
