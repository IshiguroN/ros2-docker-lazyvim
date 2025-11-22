FROM osrf/ros:humble-desktop

ENV DEBIAN_FRONTEND=noninteractive

# Environment variables (use ENV, not RUN export)
ENV LIBGL_ALWAYS_SOFTWARE=1
ENV GAZEBO_PLUGIN_PATH=/opt/ros/humble/lib
# ENV LD_LIBRARY_PATH=/opt/ros/humble/lib:${LD_LIBRARY_PATH}

# Install language
RUN apt-get update && apt-get install -y --no-install-recommends \
  locales \
  && locale-gen ja_JP.UTF-8 \
  && update-locale LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8 \
  && rm -rf /var/lib/apt/lists/*
ENV LANG=ja_JP.UTF-8

# Install timezone
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y --no-install-recommends tzdata \
  && dpkg-reconfigure --frontend noninteractive tzdata \
  && rm -rf /var/lib/apt/lists/*

# Default powerline10k theme, no plugins installed
RUN apt-get update && apt-get install -y \
  wget \
  curl \
  && rm -rf /var/lib/apt/lists/*
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.2.1/zsh-in-docker.sh)"

# Install system dependencies
RUN apt-get update && apt-get install -y \
  cmake \
  build-essential \
  libgl1-mesa-glx \
  libgl1-mesa-dri \
  libx11-xcb1 \
  python3-pip \
  python3-dev \
  python3-venv \
  python3-opengl \
  swig \
  xvfb \
  x11-apps \
  libglib2.0-0 \
  libglib2.0-dev \
  tk-dev \
  python3.10-tk \
  vim \
  git \
  clangd \
  unzip \
  sudo \
  && rm -rf /var/lib/apt/lists/* \
  && ldconfig \
  && ls -l /usr/lib/x86_64-linux-gnu/libGL.so* \
  && ls -l /usr/lib/x86_64-linux-gnu/libgthread-2.0.so*

# install nodev20.x
RUN apt-get update \
  && curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - \
  && apt-get install -y nodejs \
  && rm -rf /var/lib/apt/lists/*

# Install ROS2 dependencies
RUN apt-get update && apt-get install -y \
  ros-dev-tools \
  python3-colcon-mixin \
  ros-humble-gazebo-* \
  ros-humble-cartographer \
  ros-humble-cartographer-ros \
  ros-humble-navigation2 \
  ros-humble-nav2-bringup \
  && rm -rf /var/lib/apt/lists/* 

# cloning dependencies for oh-my-zsh
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install neovim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
RUN tar -C /opt -xzf nvim-linux-x86_64.tar.gz && rm -rf nvim-linux-x86_64.tar.gz

# Install LazyVim
RUN git clone https://github.com/LazyVim/starter ~/.config/nvim && rm -rf ~/.config/nvim/.git


WORKDIR /turtlebot3_ws
CMD ["/usr/bin/zsh"]
