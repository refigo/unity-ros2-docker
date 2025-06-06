FROM ros:humble-ros-base

RUN mkdir -p /home/dev_ws/src

COPY ./src/ /home/dev_ws/src

RUN git clone https://github.com/Unity-Technologies/ROS-TCP-Endpoint /home/dev_ws/src/ros_tcp_endpoint -b ROS2v0.7.0

RUN apt-get update && apt-get install -y \
    ros-humble-example-interfaces \
    ros-humble-common-interfaces \
    && rm -rf /var/lib/apt/lists/*

COPY ./unity-ros2-docker/source_ros.sh /home/dev_ws/source_ros.sh

RUN echo "cd home/dev_ws" >> ~/.bashrc

RUN cd home/dev_ws && . /opt/ros/humble/setup.sh && colcon build

RUN echo ". install/local_setup.bash" >> ~/.bashrc
