# Run a VCDW container named "vcdw" by default
vcdwrun() {
  docker run --name $(vcdw) -p 80:80 -v /home/core/share:/share:rw -d ixkaito/vcdw;
}

# Stop all containers or containers selected
vcdwstop() {
  docker stop $(docker ps -a -q);
}

# Force remove all containers or containers selected
vcdwrm() {
  docker rm -f $(docker ps -a -q);
}
