FROM alpine:3.3

MAINTAINER pstauffer@confirm.ch

#
# Install all required dependencies.
#

RUN apk --update upgrade && \
    apk add --update bind inotify-tools && \
    rm -rf /var/cache/apk/*


#
# Add named init script.
#

ADD named.sh /named.sh
RUN chmod 750 /named.sh


#
# Define container settings.
#

VOLUME ["/etc/bind", "/var/log/named"]

EXPOSE 53/udp

WORKDIR /etc/bind


#
# Start named.
#

CMD ["/named.sh"]
