#?bin/bash

docker run -p 172.17.42.1:2379:2379 -p 172.17.42.1:4001:4001 -p 172.17.42.1:53:53/udp -p 172.17.42.1:53:53 --name dns --volume=/var/run/docker.sock:/tmp/docker.sock etopian/dns
#docker start dns
