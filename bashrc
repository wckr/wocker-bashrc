# Run a Wocker container named "wocker" by default
wocker() {
  if [ -f ~/share/wordpress/wp-config.php ]; then
    docker run -d --name ${1:-wocker} -p 80:80 -v ~/share/wordpress:/var/www/wordpress:rw ${2:-ixkaito/wocker}
  else
    docker run -d ${2:-ixkaito/wocker} && \
    docker cp $(docker ps -l -q):/var/www/wordpress ~/share && \
    docker rm -f $(docker ps -l -q) && \
    docker run -d --name ${1:-wocker} -p 80:80 -v ~/share/wordpress:/var/www/wordpress:rw ${2:-ixkaito/wocker}
  fi
}

# Stop all running containers
dockerstopall() {
  docker stop $(docker ps -a -q);
}

# Kill all running containers
dockerkillall() {
  docker kill $(docker ps -a -q);
}

# Force remove all containers
dockerrmall() {
  docker rm -f $(docker ps -a -q);
}
