#!/bin/sh

[ "$RUNUSER" = "none" ] && exit 0

if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${RUNUSER}:x:$(id -u):0:OpenShift ${RUNUSER}:$HOME:/bin/bash" >> /etc/passwd
    echo "${RUNUSER}:x:$(id -u):${RUNUSER}" >> /etc/group
  fi
fi
