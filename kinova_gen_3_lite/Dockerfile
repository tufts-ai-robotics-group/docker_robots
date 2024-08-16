FROM ros:noetic
RUN apt update && apt upgrade -y

RUN apt install -y git \
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
