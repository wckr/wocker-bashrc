wocker_commands() {
  echo 'Usage: wocker COMMAND'
  echo ''
  echo 'Commands:'
  echo '    run [--name=""] [Image]  Run a container.'
  echo '                             Default container name: wocker'
  echo '                             Default docker image: ixkaito/wocker:latest'
  echo '    stop all                 Stop all running containers.'
  echo '    kill all                 Kill all running containers.'
  echo '    rm all                   Force remove all containers.'
}

wocker() {

  #
  # $ wocker run
  #
  if [ "$1" = 'run' ]; then

    NAME='wocker'
    IMAGE='ixkaito/wocker:latest'

    if [ "$2" = '--name' ]; then
      NAME=$3
      IMAGE=${4:-$IMAGE}
    elif [[ "$2" =~ ^--name=(.*)$ ]] ; then
      NAME=${BASH_REMATCH[1]}
      IMAGE=${3:-$IMAGE}
    else
      IMAGE=${2:-$IMAGE}
    fi

    # Run a Wocker container named "wocker" using "ixkaito/wocker:latest" by default
    if [ -f ~/data/wordpress/wp-config.php ]; then
      docker run -d --name $NAME -p 80:80 -v ~/data/wordpress:/var/www/wordpress:rw $IMAGE
    else
      docker run -d $IMAGE && \
      docker cp $(docker ps -l -q):/var/www/wordpress ~/data && \
      docker rm -f $(docker ps -l -q) && \
      docker run -d --name $NAME -p 80:80 -v ~/data/wordpress:/var/www/wordpress:rw $IMAGE
    fi

  #
  # $ wocker stop
  #
  elif [ "$1" = 'stop' ]; then

    # Stop all running containers
    if [ "$2" = '--all' || "$2" = '-a' ]; then
      CONTAINER='$(docker ps -a -q)'
    else
      CONTAINER=$2
    fi

    docker stop $CONTAINER

  #
  # $ wocker kill
  #
  elif [ "$1" = 'kill' ]; then

    # Kill all running containers
    if [ "$2" = '--all' || "$2" = '-a' ]; then
      CONTAINER='$(docker ps -a -q)'
    else
      CONTAINER=$2
    fi

    docker kill $CONTAINER

  #
  # $ wocker rm
  #
  elif [ "$1" = 'rm' ]; then

    # Force remove all containers
    if [ "$2" = '--all' || "$2" = '-a' ]; then
      CONTAINER='$(docker ps -a -q)'
    else
      CONTAINER=$2
    fi

    docker rm -f $CONTAINER

  #
  # $ wocker usage
  #
  elif [ "$1" = '--help' || "$1" = '-h' ]; then
    wocker_commands

  #
  # $ wocker usage
  #
  else
    wocker_commands
  fi
}
