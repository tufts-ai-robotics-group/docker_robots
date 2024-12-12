FROM ros:galactic
ENV DEBIAN_FRONTEND=noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt update && apt upgrade -y
RUN apt install ros-galactic-rmw-fastrtps-cpp -y
RUN apt install python3-pip -y
RUN bash -c "pip3 install transforms3d"
RUN bash -c "pip3 install modern-robotics"
RUN apt install keyboard-configuration -y
RUN apt install curl -y
RUN bash -c "curl 'https://raw.githubusercontent.com/Interbotix/interbotix_ros_rovers/main/interbotix_ros_xslocobots/install/xslocobot_remote_install.sh' > xslocobot_remote_install.sh"
RUN bash -c "chmod +x xslocobot_remote_install.sh"
RUN bash -c "./xslocobot_remote_install.sh -d galactic -b create3 -n"
