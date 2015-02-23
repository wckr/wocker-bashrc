wocker_usage() {
  echo 'Usage: wocker COMMAND'
  echo ''
  echo 'Commands:'
  echo '    run [--name=""] [IMAGE]  Run a new container.'
  echo '                             Default container name: wocker'
  echo '                             Default docker image: ixkaito/wocker:latest'
  echo ''
  echo '    stop CONTAINER           Stop a running container by sending SIGTERM and then SIGKILL after a grace period.'
  echo '                             "CONTAINER" can be a container name or container ID.'
  echo '    stop -a|--all            Stop all running containers.'
  echo ''
  echo '    kill CONTAINER           Kill a running container using SIGKILL or a specified signal.'
  echo '                             "CONTAINER" can be a container name or container ID.'
  echo '    kill -a|--all            Kill all running containers.'
  echo ''
  echo '    rm CONTAINER             Force remove one or more containers.'
  echo '                             "CONTAINER" can be container names or container IDs.'
  echo '    rm -a|--all              Force remove all containers.'
}

wocker() {

  local name='wocker'
  local image='ixkaito/wocker:latest'
  local container

  #
  # $ wocker run
  #
  if [ "$1" = 'run' ]; then

    if [ "$2" = '--name' ]; then
      name=$3
      image=${4:-$image}
    elif [[ "$2" =~ ^--name=(.*)$ ]]; then
      name=${BASH_REMATCH[1]}
      image=${3:-$image}
    else
      image=${2:-$image}
    fi

    # Run a Wocker container named "wocker" using "ixkaito/wocker:latest" by default
    if [ -f ~/data/wordpress/wp-config.php ]; then
      docker run -d --name $name -p 80:80 -v ~/data/wordpress:/var/www/wordpress:rw $image
    else
      docker run -d $image && \
      docker cp $(docker ps -l -q):/var/www/wordpress ~/data && \
      docker rm -f $(docker ps -l -q) && \
      docker run -d --name $name -p 80:80 -v ~/data/wordpress:/var/www/wordpress:rw $image
    fi

  #
  # $ wocker stop
  #
  elif [ "$1" = 'stop' ]; then

    # Stop all running containers
    if [[ "$2" = '--all' || "$2" = '-a' ]]; then
      container=$(docker ps -a -q)
    else
      container=$2
    fi

    docker stop $container

  #
  # $ wocker kill
  #
  elif [ "$1" = 'kill' ]; then

    # Kill all running containers
    if [[ "$2" = '--all' || "$2" = '-a' ]]; then
      container=$(docker ps -a -q)
    else
      container=$2
    fi

    docker kill $container

  #
  # $ wocker rm
  #
  elif [ "$1" = 'rm' ]; then

    # Force remove all containers
    if [[ "$2" = '--all' || "$2" = '-a' ]]; then
      container=$(docker ps -a -q)
    else
      container=$2
    fi

    docker rm -f $container

  #
  # $ wocker usage
  #
  elif [[ "$1" = '--help' || "$1" = '-h' ]]; then
    wocker_usage

  #
  # $ wocker usage
  #
  else
    wocker_usage
  fi
}
