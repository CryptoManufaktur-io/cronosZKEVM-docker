# Use the official PostgreSQL 16 image as the base
FROM postgres:16

# Set environment variables for PostgreSQL
ENV POSTGRES_DB=zksync
ENV POSTGRES_USER=zksync
ENV POSTGRES_PASSWORD=password

RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/docker-entrypoint.sh

# Set the entrypoint to the custom script
ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
