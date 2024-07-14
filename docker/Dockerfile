ARG ROS_DISTRO=humble

FROM osrf/ros:${ROS_DISTRO}-desktop-full

# Update and install basic packages
RUN apt-get update && apt-get install -y nano && rm -rf /var/lib/apt/lists/*

# Install basic apt packages
RUN apt-get update && apt-get install -y --no-install-recommends \
 git libcanberra-gtk-module libcanberra-gtk3-module fuse3 libfuse2 libqt5svg5-dev \
 python3-pip python3-opencv python3-tk python3-pyqt5.qtwebengine nano gedit

# Install Nav2 packages
RUN apt install -y ros-${ROS_DISTRO}-navigation2 ros-${ROS_DISTRO}-nav2-bringup 

# Install Robot Localization packages
RUN apt install -y ros-${ROS_DISTRO}-robot-localization

# Install Gazebo Simulation packages
RUN apt install -y ros-${ROS_DISTRO}-turtlebot3-gazebo

# Install additional Python modules
RUN pip3 install matplotlib transforms3d

# Use Cyclone DDS as middleware
RUN apt-get update && apt-get install -y --no-install-recommends \
 ros-${ROS_DISTRO}-rmw-cyclonedds-cpp
ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

# Set HOME environment variable
ENV HOME=/home

# Create Colcon workspace with external dependencies
RUN mkdir -p /home/workspace_ws/src
WORKDIR /home/workspace_ws/src
COPY docker/dependencies.repos .
RUN vcs import < dependencies.repos
RUN rm -rf dependencies.repos

# Build the workspace
WORKDIR /home/workspace_ws
RUN . /opt/ros/${ROS_DISTRO}/setup.sh && colcon build

# Download Groot2 AppImage and place it in the home folder.
WORKDIR /home
RUN curl -o Groot2.AppImage https://s3.us-west-1.amazonaws.com/download.behaviortree.dev/groot2_linux_installer/Groot2-v1.0.1-x86_64.AppImage \
 && chmod a+x Groot2.AppImage

# Remove display warnings
RUN mkdir /tmp/runtime-root
ENV XDG_RUNTIME_DIR "/tmp/runtime-root"
RUN chmod -R 0700 /tmp/runtime-root
ENV NO_AT_BRIDGE 1

WORKDIR /home
