alias vcdw="docker run --name vcdw -p 80:80 -v /home/core/share:/share:rw -d ixkaito/vcdw"

vcdwrun() {
  docker run --name $1 -p 80:80 -v /home/core/share:/share:rw -d ixkaito/vcdw;
}

vcdwstop() {
  docker stop $(docker ps -a -q);
}

vcdwrm() {
  docker rm -f $(docker ps -a -q);
}
