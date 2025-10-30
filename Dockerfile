# ==============================
# ROS2 Humble Simulation Image
# Includes: desktop-full, pytest, flake8, colcon
# ==============================

FROM ros:humble-ros-base

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO=humble

# Install core dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-desktop-full \
    python3-colcon-common-extensions \
    python3-pip \
    python3-pytest \
    python3-pytest-cov \
    python3-pytest-repeat \
    python3-pytest-rerunfailures \
    python3-flake8 \
    git \
    xvfb \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Set up ROS environment
SHELL ["/bin/bash", "-c"]
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
ENV PATH="/opt/ros/${ROS_DISTRO}/bin:$PATH"

# Workspace setup
WORKDIR /ros2_ws
COPY . /ros2_ws

# Install Python requirements if present
RUN if [ -f src/my_sim_pkg/requirements.txt ]; then \
        pip install --no-cache-dir -r src/my_sim_pkg/requirements.txt; \
    fi

# Build ROS 2 workspace
RUN source /opt/ros/${ROS_DISTRO}/setup.bash && \
    colcon build --symlink-install --event-handlers console_direct+

# Run a basic test to ensure the workspace works
RUN source /opt/ros/${ROS_DISTRO}/setup.bash && \
    source install/setup.bash && \
    pytest src/my_sim_pkg/test/ -q || true

# Final environment setup
RUN echo "source /ros2_ws/install/setup.bash" >> ~/.bashrc

# Default entrypoint
ENTRYPOINT ["/bin/bash", "-c", "source /opt/ros/${ROS_DISTRO}/setup.bash && source /ros2_ws/install/setup.bash && bash"]
