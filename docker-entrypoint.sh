#!/bin/bash

if [[ ! -z "$WORKER_UID" ]]; then
    gosu root usermod -u ${WORKER_UID} worker
fi
if [[ ! -z "$WORKER_GID" ]]; then
    gosu root groupmod -g ${WORKER_GID} worker
fi

gosu worker iinit ${IRODS_PASSWORD}
gosu worker "$@"