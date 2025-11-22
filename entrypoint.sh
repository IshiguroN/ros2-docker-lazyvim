#!/bin/sh

# neovim install
echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.zshrc

# Base
echo 'source /opt/ros/$ROS_DISTRO/setup.zsh' >> ~/.zshrc

# Turtlebot3 packages
echo 'export TURTLEBOT3_MODEL=waffle_pi' >> ~/.zshrc
echo 'source /turtlebot3_ws/install/setup.zsh' >> ~/.zshrc
echo 'source /usr/share/gazebo/setup.sh' >> ~/.zshrc

# argcomplete for ros2 & colcon
echo 'eval "$(register-python-argcomplete3 ros2)"' >> ~/.zshrc
echo 'eval "$(register-python-argcomplete3 colcon)"' >> ~/.zshrc

zsh -c 'source  ~/.zshrc'

