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
ENV COLCON_WS=/root/workspace/ros2_kortex_ws
ENV ROS_DISTRO=${ROS_DISTRO}

RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
    python3-colcon-common-extensions \
    python3-vcstool \
    python3-rosdep \
    ros-${ROS_DISTRO}-rmw-cyclonedds-cpp \
    && rm -rf /var/lib/apt/lists/*

WORKDIR $COLCON_WS/src
RUN git clone https://github.com/Kinovarobotics/ros2_kortex.git ros2_kortex

WORKDIR $COLCON_WS

RUN vcs import src --skip-existing --input src/ros2_kortex/ros2_kortex.${ROS_DISTRO}.repos && \
    vcs import src --skip-existing --input src/ros2_kortex/ros2_kortex-not-released.${ROS_DISTRO}.repos

RUN rm -rf src/ros2_control \
           src/ros2_controllers \
           src/gz_ros2_control \
           src/ros_gz

# swap out gripper with gen3 lite 2
RUN sed -i "s/moveit_active:=false\"/moveit_active:=false gripper:=''\"/" \
    src/ros2_kortex/kortex_description/arms/gen3_lite/6dof/urdf/gen3_lite_macro.xacro

RUN apt-get update && \
    if [ ! -f /etc/ros/rosdep/sources.list.d/20-default.list ]; then rosdep init; fi && \
    rosdep update && \
    rosdep install --ignore-src --from-paths src -y -r && \
    rm -rf /var/lib/apt/lists/*

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
    colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release

RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc && \
    echo "source $COLCON_WS/install/setup.bash" >> ~/.bashrc && \
    echo "export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp" >> ~/.bashrc
