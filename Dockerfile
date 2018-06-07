
FROM ubuntu:14.06
MAINTAINER albatross1

docker pull linuxserver/plexrequests

sudo docker create --name=plexrequests \

--restart=always \
-v /etc/localtime:/etc/localtime:ro \
-v /home/docker/plexrequests/config:/config \
-e PGID=1001 -e PUID=1001 \
-e TZ=Europe/London \
-e URL_BASE= \
-p 3000:3000 \

linuxserver/plexrequests
