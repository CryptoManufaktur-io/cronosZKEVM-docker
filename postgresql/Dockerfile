ARG DOCKER_TAG=${DOCKER_TAG:-latest}
ARG DOCKER_REPO=${DOCKER_REPO:-postgres}

FROM ${DOCKER_REPO}:${DOCKER_TAG}

RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
