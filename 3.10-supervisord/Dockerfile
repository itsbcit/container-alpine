FROM alpine:3.10

LABEL maintainer="jesse@weisner.ca, chriswood.ca@gmail.com"
LABEL build_id="1616000795"

ENV TZ America/Vancouver
ENV RUNUSER none
ENV HOME /

RUN apk upgrade --no-cache

# Add docker-entrypoint script base
ADD https://github.com/itsbcit/docker-entrypoint/releases/download/v1.5/docker-entrypoint.tar.gz /docker-entrypoint.tar.gz
RUN tar zxvf docker-entrypoint.tar.gz && rm -f docker-entrypoint.tar.gz \
 && chmod -R 555 /docker-entrypoint.* \
 && chmod 664 /etc/passwd /etc/group /etc/shadow \
 && chown 0:0 /etc/shadow \
 && chmod 775 /etc

# Add dockerize
ADD https://github.com/jwilder/dockerize/releases/download/v0.6.0/dockerize-alpine-linux-amd64-v0.6.0.tar.gz /dockerize.tar.gz
RUN [ -d /usr/local/bin ] || mkdir -p /usr/local/bin \
 && tar zxf /dockerize.tar.gz -C /usr/local/bin \
 && chown 0:0 /usr/local/bin/dockerize \
 && chmod 0555 /usr/local/bin/dockerize \
 && rm -f /dockerize.tar.gz

ENV DOCKERIZE_ENV production

# Add Tini
ADD https://github.com/krallin/tini/releases/download/v0.18.0/tini-static-amd64 /tini
RUN chmod +x /tini \
 && ln -s /tini /sbin/tini 

ENTRYPOINT ["/tini", "--", "/docker-entrypoint.sh"]

RUN apk add --no-cache \
        rsync \
        tzdata \
 && cp "/usr/share/zoneinfo/${TZ}" /etc/localtime

# Install & configure supervisor
RUN apk add --no-cache \
        supervisor \
 && mkdir -p /var/log/supervisor \
 && mkdir -p /etc/supervisor/conf.d
COPY supervisor.conf /etc/supervisor.conf

CMD ["supervisord", "-c", "/etc/supervisor.conf"]
