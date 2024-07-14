ARG ROS_DISTRO=humble

FROM osrf/ros:${ROS_DISTRO}-desktop-full

# Update and install basic packages
RUN apt-get update && apt-get install -y nano && rm -rf /var/lib/apt/lists/*

# Install basic apt packages
RUN apt-get update && apt-get install -y --no-install-recommends \
 git libcanberra-gtk-module libcanberra-gtk3-module fuse3 libfuse2 libqt5svg5-dev \
 python3-pip python3-opencv python3-tk python3-pyqt5.qtwebengine nano gedit

# Install Cartographer packages
RUN apt install -y ros-${ROS_DISTRO}-cartographer ros-${ROS_DISTRO}-cartographer-ros

# Install Nav2 packages
RUN apt install -y ros-${ROS_DISTRO}-navigation2 ros-${ROS_DISTRO}-nav2-bringup 

# Install Robot Localization packages
RUN apt install -y ros-${ROS_DISTRO}-robot-localization

# Install Gazebo Simulation packages
RUN apt install -y ros-${ROS_DISTRO}-turtlebot3-gazebo

# Install additional Python modules
RUN pip3 install matplotlib transforms3d numpy

# Use Cyclone DDS as middleware
RUN apt-get update && apt-get install -y --no-install-recommends \
 ros-${ROS_DISTRO}-rmw-cyclonedds-cpp
ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

# Set HOME environment variable
ENV HOME=/home

# Remove display warnings
RUN mkdir /tmp/runtime-root
ENV XDG_RUNTIME_DIR "/tmp/runtime-root"
RUN chmod -R 0700 /tmp/runtime-root
ENV NO_AT_BRIDGE 1

WORKDIR /home
