FROM alpine:latest
LABEL maintainer="jesse@weisner.ca"

ENV RUNUSER none
ENV HOME /

RUN apk add --no-cache \
        tini

ADD docker-entrypoint.sh /docker-entrypoint.sh
ADD docker-entrypoint.d /docker-entrypoint.d
RUN chmod -R 555 /docker-entrypoint.*

# Allow resolve-userid.sh script to run
RUN chmod 664 /etc/passwd /etc/group

ENTRYPOINT ["/sbin/tini", "--", "/docker-entrypoint.sh"]
