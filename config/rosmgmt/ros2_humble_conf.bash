# Enviroment variables
export ROS_DOMAIN_ID=10 #Value by Default

# Direccionamiento a los espacios de trabajo de ROS2
source /opt/ros/humble/setup.bash
# Agrega los workspaces habilitados por default aqui

# Setup colcon tab completion
source /usr/share/colcon_cd/function/colcon_cd.sh
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
export _colcon_cd_root=/opt/ros/humble/

# Alias definitions
alias rosnet='__ros_network'
alias rosenv='__ros_print_env_vars'
## alias ros2path='echo -e ${AMENT_PREFIX_PATH//:/\\n}'
alias ros2path='sed "s/:/\n/g" <<< "$AMENT_PREFIX_PATH" | sort | uniq'
alias rospath='tr ":" "\n" <<< "$AMENT_PREFIX_PATH" | sort | uniq'
