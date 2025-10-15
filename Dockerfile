# Dockerfile
FROM ros:humble-ros-base

# Set noninteractive for apt installs
ENV DEBIAN_FRONTEND=noninteractive

# Install ROS2 desktop, Gazebo, Python, and other tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ros-humble-desktop-full \
    python3-colcon-common-extensions \
    python3-pip \
    git \
    xvfb \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Set ROS environment
SHELL ["/bin/bash", "-c"]
ENV ROS_DISTRO humble
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
ENV PATH="/opt/ros/$ROS_DISTRO/bin:$PATH"

# Create workspace directory
WORKDIR /ros2_ws

# Copy your workspace into container
COPY . /ros2_ws

# Install Python dependencies (if requirements.txt exists)
RUN if [ -f src/my_sim_pkg/requirements.txt ]; then \
        pip install --no-cache-dir -r src/my_sim_pkg/requirements.txt; \
    fi

# Build workspace
RUN source /opt/ros/$ROS_DISTRO/setup.bash && colcon build --symlink-install

# Set entrypoint to source ROS and workspace
ENTRYPOINT ["/bin/bash", "-c", "source /opt/ros/$ROS_DISTRO/setup.bash && source /ros2_ws/install/setup.bash && bash"]
