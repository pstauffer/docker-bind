# Bind9 Docker Image

## Description

This docker image provides a [bind service](https://www.isc.org/downloads/bind/) based on [Alpine Linux](https://hub.docker.com/_/alpine/).

## Usage

If you like to use this image, please use a specific version tag like `v1.0.0` or the tag `latest`, `develop` or `stable`. The other branches are only temporary and will be deleted after the merge into the other branches.

There are two options to start your Bind container.

### Docker Run
Use this docker command to run the bind container.
```
docker run -d --name bind --publish 53:53/udp \
-v /bindconfig:/etc/bind -v /bindlog:/var/log/named \
--restart=always pstauffer/bind:stable
```

### Docker Compose
Or check out the docker-compose file in the [git repo](https://raw.githubusercontent.com/pstauffer/docker-bind/master/Dockerfile).
```
docker-compse up -d
```

### Docker Environment Variables
It's possible to change the uid/gid of the technical bind user/group. Just pass the following variables via docker to the container:
```
NAMED_UID=666
NAMED_GID=666
```

or via docker-compose file:
```
    environment:
    - NAMED_UID=666
    - NAMED_GID=666
```

The default ids are in the alpine bind package are:
```
UID=1000
GID=101
```


## Bind Stuff

### Bind Configuration
To pass your configuration directory with all configs and files, you've to mount the volume into the docker container with the docker option:
```
-v <bindconfig>:/etc/bind
```

Please verify, that the owner of the files is set equal to the uid/gid of the named user/group in the container.
```
chown 1000:101 <bindconfig>/*
```

## Bind Logfiles
To log the bind logs on your docker host, just mount a directory into the docker container:
```
-v <logdir>:/var/log/named
```

Please verify, that the owner of the files is set equal to the uid/gid of the named user/group in the container.
```
chown 1000:101 <bindconfig>/*
```

## Bind Sample Configuration
A working bind configuration is provided in the [git repo](https://github.com/pstauffer/docker-bind/tree/master/bindconfig).
Just mount this example folder into the docker container and you're bind should work.

## Bind Test
You can test the dns responses with `dig` or `nslookup` on the docker host.
```
dig webmail.example.com @localhost

nslookup webmail.example.com localhost
```
