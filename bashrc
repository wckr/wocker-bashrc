# Run a VCDW container named "vcdw" by default
vcdwrun() {
  if [ -f ~/share/wordpress/wp-config.php ]; then
    docker run -d --name ${1:-vcdw} -p 80:80 -v /home/core/share/wordpress:/var/www/wordpress:rw ${2:-ixkaito/vcdw}
  else
    docker run -d ${2:-ixkaito/vcdw} && \
    docker cp $(docker ps -l -q):/var/www/wordpress /home/core/share && \
    docker rm -f $(docker ps -l -q) && \
    docker run -d --name ${1:-vcdw} -p 80:80 -v /home/core/share/wordpress:/var/www/wordpress:rw ${2:-ixkaito/vcdw}
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
