ARG DOCKER_TAG=16-bookworm
FROM postgres:${DOCKER_TAG}

RUN mkdir -p /dump && chown -R postgres:postgres /dump

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y aria2
