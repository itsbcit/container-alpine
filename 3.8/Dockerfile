FROM alpine:3.8
LABEL maintainer="jesse@weisner.ca, chriswood.ca@gmail.com"

ENV RUNUSER none
ENV HOME /

RUN apk upgrade --no-cache
RUN apk add --no-cache \
        tini

# Add docker-entrypoint script base
ENV DE_VERSION v1.3
ADD https://github.com/itsbcit/docker-entrypoint/releases/download/${DE_VERSION}/docker-entrypoint.tar.gz /docker-entrypoint.tar.gz
RUN tar zxvf docker-entrypoint.tar.gz && rm -f docker-entrypoint.tar.gz
RUN chmod -R 555 /docker-entrypoint.*


# Allow resolve-userid.sh script to run
RUN chmod 664 /etc/passwd /etc/group

ENTRYPOINT ["/sbin/tini", "--", "/docker-entrypoint.sh"]
