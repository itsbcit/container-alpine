# openshift-alpine

[![Build Status](https://travis-ci.org/itsbcit/openshift-alpine.svg?branch=master)](https://travis-ci.org/itsbcit/openshift-alpine)

Alpine Linux Docker image with OpenShift shims

## Supported Tags

* [`3.13-latest`](https://github.com/itsbcit/openshift-alpine/blob/master/3.13/Dockerfile), latest
* [`3.12-latest`](https://github.com/itsbcit/openshift-alpine/blob/master/3.12/Dockerfile)
* [`3.13-supervisord-latest`](https://github.com/itsbcit/openshift-alpine/blob/master/3.13-supervisord/Dockerfile)
* [`3.12-supervisord-latest`](https://github.com/itsbcit/openshift-alpine/blob/master/3.12-supervisord/Dockerfile)

## supervisord version

[http://supervisord.org/configuration.html]()

`COPY your-supervisor.conf /etc/supervisor/conf.d/`
