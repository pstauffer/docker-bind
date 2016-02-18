# Bind9 Docker Image

## Description

This docker image provides a [bind service](https://www.isc.org/downloads/bind/) based on [Alpine Linux](https://hub.docker.com/_/alpine/).

## Usage

### Docker Run
Use this docker command to run the bind container.
```
docker run -d -it -v /bindconfig:/etc/bind -v /bindlog:/var/log/named --publish 53:53/udp pstauffer/bind
```

### Docker Compose
Or check out the docker-compose file in the [git repo](https://raw.githubusercontent.com/pstauffer/docker-bind/master/Dockerfile).
```
docker-compse up -d
```

## Bind Stuff

### Bind Configuration
To pass your configuration directory with all configs and files, you've to mount the volume into the docker container with the docker option:
```
-v <confdir>:/etc/bind
```

Please verify, that the owner of the files is set equal to the user-id of the named user in the container.
```
chown 1000:101 <confdir>/*
```

## Bind Logfiles
To log the bind logs on your docker host, just mount a directory into the docker container:
```
-v <logdir>:/var/log/named
```

Please verify, that the owner of the files is set equal to the user-id of the named user in the container.
```
chown 1000:101 <confdir>/*
```

## Bind Sample Configuration
A working bind configuration is provided in the [git repo](https://github.com/pstauffer/docker-bind/tree/master/bindconfig).
Just mount this example folder into the docker container and you're bind should work. You can test the dns responses with `dig`:
```
dig webmail.example.com localhost
```
