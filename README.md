# Bind9 Docker Image based on Alpine Linux

## Description

This docker image provides a bind service based on Alpine Linux.

## Usage

### Bind Configuration
To pass your configuration files with the `named.conf` and the zone-files, you've to mount the volume into
the docker container with the docker option `-v`.

### Unprivileged User
To run the named service with an unprivileged user, it's needed to configure bind to use a port over 1024.
Edit your `named.conf` and add the following line in the `options` block:
```
listen-on port 10053 { any; };
``` 

### Run
Use this docker command to run the bind container.
```
docker run -d -it -v /tmp/bind9/config:/etc/bind --publish 53:10053/udp pstauffer/bind
```
