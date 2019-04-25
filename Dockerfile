FROM alpine:3.9

MAINTAINER pstauffer@confirm.ch

#
# Install all required dependencies.
#

RUN apk --update upgrade && \
    apk add --update bind && \
    rm -rf /var/cache/apk/*


#
# Add named init script.
#

ADD init.sh /init.sh
RUN chmod 750 /init.sh


#
# Define container settings.
#

VOLUME ["/etc/bind", "/var/log/named"]

EXPOSE 53/udp

WORKDIR /etc/bind


#
# Start named.
#

CMD ["/init.sh"]
