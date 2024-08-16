You can more learn about docker at https://www.freecodecamp.org/news/the-docker-handbook/

# Building Dockerfile

- dockerfile can be built with `docker build -t turtlebot:latest .` (assuming you are in the directory of the dockerfile)

# Starting docker container

- You can view all of your docker images with `docker image ls`
- You should see your recently built docker image `turtlebot:latest`
- Start this docker image with `docker run -it --device=/dev/kobuki:/dev/kobuki --net=host --device=/dev/bus/usb/ -v /sys/fs/cgroup:/sys/fs/cgroup:ro turtlebot:latest /bin/bash`
  - Note that `-it` will start the container interactively, alternatively you could start headlessly and use the steps in the interacting section to attach.
  - Note that `--net=host` will pass the host machines network namespace into the container. This may lead to port conflicts.

# Interacting

You can also open additional interactive instances of your docker container

- `docker container ls`, this will show you some information including container ID. Copy down the container ID of your currently running `turtlebot:latest` image instance
- `docker exec -it {ContainerID} bash` will let you open up additional terminal instances
