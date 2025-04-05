# Overview

Docker Compose for CronosZKEVM node.

the `./cronoszkevm` script can be used as a quick-start:

`./cronoszkevm install` brings in docker-ce, if you don't have Docker installed already.

`cp default.env .env`

`nano .env` and adjust variables as needed

`./cronoszkevm up`

To update the software, run `./cronoszkevm update` and then `./cronoszkevm up`

If you want the CronosZKEVMRPC ports exposed, use `rpc-shared.yml` in `COMPOSE_FILE` inside `.env`.

If meant to be used with [central-proxy-docker](https://github.com/CryptoManufaktur-io/central-proxy-docker) for traefik
and Prometheus remote write; use `:ext-network.yml` in `COMPOSE_FILE` inside `.env` in that case.

This is CronosZKEVM Docker v1.1.0
