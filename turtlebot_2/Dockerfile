FROM ros:kinetic

RUN apt update && apt install  -y \
    udev \
    git \
    chrony \
    ros-kinetic-turtlebot \
    ros-kinetic-kobuki \
    ros-kinetic-ecl-streams \
    ros-kinetic-sound-play \
    ros-kinetic-roslint \
    ros-kinetic-rplidar-ros \
    ros-kinetic-map-server \
    ros-kinetic-move-base
    ros-kinetic-leg-detector
RUN mkdir -p ~/catkin_ws/src
RUN git clone https://github.com/tufts-ai-robotics-group/tufts_service_robots.git ~/catkin_ws/src
RUN bash -c "source /opt/ros/kinetic/setup.bash && \
            cd ~/catkin_ws/ && \
            catkin_make"
RUN echo "export TURTLEBOT_3D_SENSOR=astra" >> ~/.bashrc
RUN echo "export TURTLEBOT_BATTERY=/sys/class/power_supply/BAT0" >> ~/.bashrc
RUN echo "echo ROS_DISTRO=kinetic" >> ~/.bashrc
RUN echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
RUN echo "export TURTLEBOT_BASE=kobuki" >> ~/.bashrc
