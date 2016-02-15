FROM alpine:3.3

MAINTAINER pstauffer@confirm.ch

ENV USER=named

RUN apk --update upgrade && \
    apk add --update bind && \
    rm -rf /var/cache/apk/*

RUN chown -R ${USER}:${USER} /var/bind /etc/bind /var/run/named /var/log/named

USER ${USER}

VOLUME /etc/bind

CMD ["/usr/sbin/named", "-c", "/etc/bind/named.conf", "-f"]

