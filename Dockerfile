# Dockerfile
FROM ros:humble-ros-base

# Install Gazebo and other dependencies
RUN apt-get update && \
    apt-get install -y \
    ros-humble-desktop-full \
    python3-colcon-common-extensions \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set ROS environment
SHELL ["/bin/bash", "-c"]
ENV ROS_DISTRO humble
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
ENV PATH="/opt/ros/$ROS_DISTRO/bin:$PATH"

# Copy your workspace
COPY . /ros2_ws
WORKDIR /ros2_ws

# Install Python dependencies
RUN pip install --no-cache-dir -r src/my_sim_pkg/requirements.txt || true

# Build workspace
RUN source /opt/ros/$ROS_DISTRO/setup.bash && colcon build --symlink-install

# Set entrypoint
ENTRYPOINT ["/bin/bash", "-c", "source /ros2_ws/install/setup.bash && bash"]
