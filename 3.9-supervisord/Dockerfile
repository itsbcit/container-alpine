FROM alpine:3.9
LABEL maintainer="jesse@weisner.ca, chriswood.ca@gmail.com"

ENV RUNUSER none
ENV HOME /

RUN apk upgrade --no-cache
RUN apk add --no-cache \
        tini

# Add docker-entrypoint script base
ENV DE_VERSION v1.5
ADD https://github.com/itsbcit/docker-entrypoint/releases/download/${DE_VERSION}/docker-entrypoint.tar.gz /docker-entrypoint.tar.gz
RUN tar zxvf docker-entrypoint.tar.gz && rm -f docker-entrypoint.tar.gz
RUN chmod -R 555 /docker-entrypoint.*

# Add dockerize
ADD https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-alpine-linux-amd64-v0.6.1.tar.gz /dockerize.tar.gz
RUN tar zxf /dockerize.tar.gz -C /usr/local/bin \
 && chown 0:0 /usr/local/bin/dockerize \
 && chmod 0555 /usr/local/bin/dockerize \
 && rm -f /dockerize.tar.gz

# Allow resolve-userid.sh script to run
RUN chmod 664 /etc/passwd /etc/group /etc/shadow \
 && chown 0:0 /etc/shadow \
 && chmod 775 /etc

ENTRYPOINT ["/sbin/tini", "--", "/docker-entrypoint.sh"]
# Install & configure supervisor
RUN apk add --no-cache \
    supervisor && \
    mkdir -p /var/log/supervisor && \
    mkdir -p /etc/supervisor/conf.d
COPY supervisor.conf /etc/supervisor.conf

CMD ["supervisord", "-c", "/etc/supervisor.conf"]
