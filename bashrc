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
  local cid
  local cids
  local dirname
  local dirnames
  local containers
  local force

  case "$1" in

    #
    # $ wocker run
    #
    'run' )

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
        docker run -d --name $name $image && \
        docker cp $(docker ps -l -q):/var/www/wordpress ~/data && \
        docker rm -f $(docker ps -l -q) && \
        docker run -d --name $name -p 80:80 -v ~/data/wordpress:/var/www/wordpress:rw $image
      fi

      ;;

    #
    # $ wocker stop | $ wocker kill
    #
    'stop' | 'kill' )

      cid=$(docker inspect --format='{{.Id}}' $2)
      dirname=$(docker inspect --format='{{.Name}}' $2)

      docker $1 $cid && \
      mv /home/core/data/wordpress/ /home/core/data${dirname}

      ;;

    #
    # $ wocker rm
    #
    'rm' )

      if [[ "$2" = '-f' || "$2" = '--force' || "$2" = '--force=true' ]]; then
        force='-f'
        containers=${@:3}
      else
        containers=${@:2}
      fi

      cids=$(docker inspect --format='{{.Id}}' $containers)
      dirnames=$(docker inspect --format='{{.Name}}' $containers)

      for cid in $cids; do
        docker rm $force $cid
      done

      for dirname in $dirnames; do
        rm -rf /home/core/data${dirname}
      done

      ;;

    'destroy' )

      for cid in $(docker ps -a -q); do
        dirname=$(docker inspect --format='{{.Name}}' $cid)
        rm -rf /home/core/data${dirname}
      done

      docker rm -f $(docker ps -a -q)

      ;;

    #
    # $ wocker usage
    #
    '--help' | '-h' )
      wocker_usage
      ;;

    #
    # $ wocker usage
    #
    * )
      wocker_usage
      ;;

  esac
}
