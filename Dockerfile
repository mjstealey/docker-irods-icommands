FROM debian:jessie
MAINTAINER Michael J. Stealey <stealey@renci.org>

# explicitly set user/group IDs for docker worker
RUN groupadd -r worker --gid=999 \
    && useradd -m -g worker --uid=999 worker

# Install gosu
ENV GOSU_VERSION 1.9
RUN set -x \
    && apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && apt-get purge -y --auto-remove ca-certificates wget

# Install iCommands
ENV IRODS_VERSION 4.1.9
RUN apt-get update && apt-get install -y --no-install-recommends curl libfuse2 && rm -rf /var/lib/apt/lists/* \
    && curl ftp://ftp.renci.org/pub/irods/releases/4.1.9/ubuntu14/irods-icommands-4.1.9-ubuntu14-x86_64.deb -o irods-icommands.deb \
    && dpkg -i irods-icommands.deb \
    && apt-get -f install \
    && rm irods-icommands.deb \
    && apt-get purge -y --auto-remove curl

COPY docker-entrypoint.sh /
RUN mkdir /workspace \
    && chown worker:worker -R /workspace
WORKDIR /workspace

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /workspace
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 1247
CMD ["ihelp"]