from docker.io/ros:humble

# Basic Env Setup
run apt-get update && apt-get install -y tmux ripgrep neovim fd-find
run apt-get update && apt-get install -y ros-${ROS_DISTRO}-ros-gz
run apt-get update && apt-get install -y ros-${ROS_DISTRO}-turtlebot4-simulator \
                                ros-${ROS_DISTRO}-irobot-create-nodes 

workdir /workspace
run --mount=type=bind,source=./workspace/src,target=/workspace/src \
      . /opt/ros/${ROS_DISTRO}/setup.sh && colcon build --symlink-install

ARG USER_NAME=robot-sim
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd ${USER_NAME} --gid ${USER_GID}\
    && useradd -l -m ${USER_NAME} -u ${USER_UID} -g ${USER_GID} -s /bin/bash

RUN chown -R ${USER_NAME}:${USER_NAME} /workspace
USER ${USER_NAME}
# env GZ_SIM_SYSTEM_PLUGIN_PATH=/ardupilot_gazebo/build
env GZ_SIM_RESOURCE_PATH=/environment

cmd [ "tmux" ]
