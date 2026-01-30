ARG ROS_DISTRO=noetic

FROM ros:${ROS_DISTRO}

ARG ROS_DISTRO

RUN rm -f /etc/apt/sources.list.d/ros*.list && \
    apt-get update && apt-get install -y --no-install-recommends curl gnupg2 lsb-release && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    sh -c 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV ROS_DISTRO=${ROS_DISTRO}

RUN apt-get update && apt-get install -y \
    git \
    python3-pip

RUN bash -c "mkdir -p ~/catkin_ws/src"
RUN bash -c "git clone https://github.com/Kinovarobotics/ros_kortex.git ~/catkin_ws/src"
RUN bash -c "python3 -m pip install conan==1.59 && \
             conan config set general.revisions_enabled=1 && \
             conan profile new default --detect > /dev/null && \
             conan profile update settings.compiler.libcxx=libstdc++11 default"
RUN bash -c "source /opt/ros/noetic/setup.bash && \
            cd ~/catkin_ws/ && \
            rosdep install --from-paths src --ignore-src -y && \
            catkin_make"
RUN echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
