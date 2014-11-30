alias vcdw="docker run --name vcdw -p 80:80 -v /home/core/share:/share:rw -d ixkaito/vcdw"
alias vcdwstopall="docker stop `docker ps -a -q`"
alias vcdwrmall="docker rm -f `docker ps -a -q`"

vcdwrun() {
  docker run --name $1 -p 80:80 -v /home/core/share:/share:rw -d ixkaito/vcdw
}
