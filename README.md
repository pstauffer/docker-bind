# Bind9 Docker Image

## Description

This docker image provides a [bind service](https://www.isc.org/downloads/bind/) based on [Alpine Linux](https://hub.docker.com/_/alpine/).

## Usage

### Bind Configuration
To pass your configuration directory with all configs and files, you've to mount the volume into the docker container with the docker option:
```
-v <config-dir>:/etc/bind
```

Please verify, that the owner of the files is set equal to the user-id of the named user in the container.
```
chown 1000:101 <config-dir>/*
```

### Bind Logfiles
To log the bind logs on your docker host, just mount a directory into the docker container:
```
-v <logdir>:/var/log/named
```

Please verify, that the owner of the files is set equal to the user-id of the named user in the container.
```
chown 1000:101 <config-dir>/*
```

### Docker Run
Use this docker command to run the bind container.
```
docker run -d -it -v /bindconfig:/etc/bind -v /bindlog:/var/log/named --publish 53:53/udp pstauffer/bind
```

### Docker Compose
Or check out the docker-compose file in the [git repo](https://raw.githubusercontent.com/pstauffer/docker-bind9/master/Dockerfile).
```
docker-compse up -d
```
