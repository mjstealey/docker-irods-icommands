#!/bin/bash
set -e

# if WORKER_UID and WORKER_GID are not set, then run as root user
if [[ -z "$WORKER_UID" ]] && [[ -z "$WORKER_GID" ]]; then
    gosu root iinit ${IRODS_PASSWORD}
    gosu root "$@"
# if WORKER_UID and WORKER_GID are set, then run as worker user
elif [[ ! -z "$WORKER_UID" ]] || [[ ! -z "$WORKER_GID" ]]; then
    if [[ ! -z "$WORKER_UID" ]]; then
        gosu root usermod -u ${WORKER_UID} worker
    fi
    if [[ ! -z "$WORKER_GID" ]]; then
        gosu root groupmod -g ${WORKER_GID} worker
    fi
    gosu worker iinit ${IRODS_PASSWORD}
    gosu worker "$@"
fi

exit 0;