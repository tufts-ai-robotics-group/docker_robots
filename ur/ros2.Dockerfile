# This file effectively transcribing the installation steps defined in
# https://github.com/Kinovarobotics/ros2_kortex in a dockerfile.

ARG ROS_DISTRO=jazzy

FROM ros:${ROS_DISTRO}

ARG ROS_DISTRO

RUN rm -f /etc/apt/sources.list.d/ros2* && \
    apt-get update && apt-get install -y --no-install-recommends curl gnupg2 lsb-release && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    sh -c 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" > /etc/apt/sources.list.d/ros2.list' && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
ENV ROS_DISTRO=${ROS_DISTRO}

RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
    ros-${ROS_DISTRO}-rmw-cyclonedds-cpp \
    ros-${ROS_DISTRO}-ur \
    && rm -rf /var/lib/apt/lists/*

RUN echo "export RMW_IMPLEMENTATION=$RMW_IMPLEMENTATION" >> ~/.bashrc
