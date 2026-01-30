# unlike our other dockerfiles, we only support melodic here
FROM ros:melodic

# update gpg keys
RUN rm -f /etc/apt/sources.list.d/ros*.list && \
    apt-get update && apt-get install -y --no-install-recommends curl gnupg2 lsb-release && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    sh -c 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt update && apt install  -y \
    udev \
    git \
    chrony \
    ros-melodic-kobuki-msgs \
    ros-melodic-yocs-controllers \
    ros-melodic-ecl-streams \
    ros-melodic-sound-play \
    ros-melodic-roslint \
    ros-melodic-rplidar-ros \
    ros-melodic-map-server \
    ros-melodic-move-base \
    ros-melodic-urdf \
    ros-melodic-leg-detector \
    ros-melodic-cv-bridge \
    ros-melodic-joy \
    ros-melodic-xacro \
    ros-melodic-image-transport
RUN mkdir -p ~/catkin_ws/src
RUN git clone https://github.com/tufts-ai-robotics-group/tufts_service_robots.git ~/catkin_ws/src/tufts_service_robots
RUN git clone https://github.com/turtlebot/turtlebot.git ~/catkin_ws/src/turtlebot
RUN bash -c "source /opt/ros/melodic/setup.bash && \
            cd ~/catkin_ws/ && \
            catkin_make"
RUN echo "export TURTLEBOT_3D_SENSOR=astra" >> ~/.bashrc
RUN echo "export TURTLEBOT_BATTERY=/sys/class/power_supply/BAT0" >> ~/.bashrc
RUN echo "echo ROS_DISTRO=melodic" >> ~/.bashrc
RUN echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
RUN echo "export TURTLEBOT_BASE=kobuki" >> ~/.bashrc
