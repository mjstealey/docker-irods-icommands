#!/bin/bash

gosu root iinit ${IRODS_PASSWORD}
exec "$@"