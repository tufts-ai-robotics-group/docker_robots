You can more learn about docker at https://www.freecodecamp.org/news/the-docker-handbook/

# Building Dockerfile

- dockerfile can be built with `docker build -t kinova_gen_3_lite:latest .` (assuming you are in the directory of the dockerfile)

# Starting docker container

- Make sure the kinova is plugged in to a usb port on your machine
- Start this docker image with`docker run -it --rm  --device=/dev/bus/usb/ --net=host --env=NVIDIA_VISIBLE_DEVICES=all --env=NVIDIA_DRIVER_CAPABILITIES=all --env=DISPLAY --env=QT_X11_NO_MITSHM=1 -v /tmp/.X11-unix:/tmp/.X11-unix kinova_gen_3_lite:latest /bin/bash`
  - Note that `-it` will start the container interactively, alternatively you could start headless and use the steps in the interacting section to attach.
  - Note that `--net=host` will pass the host machines network namespace into the container. This may lead to port conflicts.
  - Note the `--device` is used to pass through access to the kinova gen3 lite 
- Once in the container the robot and rviz can be started with `roslaunch kortex_driver kortex_driver.launch arm:=gen3_lite gripper:=gen3_lite_2f dof:=6 start_rviz:=true`

# Interacting

You can also open additional interactive instances of your docker container

- `docker container ls`, this will show you some information including container ID. Copy down the container ID of your currently running image instance
- `docker exec -it {ContainerID} bash` will let you open up additional terminal instances
