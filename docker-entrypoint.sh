#!/bin/sh

if [ -d ./docker-entrypoint.d ];then
    for i in ./docker-entrypoint.d/*.sh;do
        sh $i
    done
fi

exec "$@"
