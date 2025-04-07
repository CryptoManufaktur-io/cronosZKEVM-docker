#!/bin/bash
set -e

echo "[*] Starting PostgreSQL with cronos zkEVM dump automation..."

# Start PostgreSQL in the background
/usr/local/bin/docker-entrypoint.sh postgres &

# Wait until PostgreSQL is accepting connections
until pg_isready -h localhost -p 5432; do
  echo "[-] Waiting for PostgreSQL to become ready..."
  sleep 2
done

# Define paths
DUMP_TAR="/dump/external_node.tar.gz"
DUMP_DIR="/dump"
DUMP_LIST="${DUMP_DIR}/external_node/pg_restore.list"
EXTRACTED_DUMP="${DUMP_DIR}/external_node/dump"
INIT_FLAG="${DUMP_DIR}/.initialized"

# Check if already initialized
if [ -f "$INIT_FLAG" ]; then
  echo "[*] Database already initialized. Skipping restore."
else
  echo "[*] Starting first-time database setup..."

  # Download the pgdump
  echo "[*] Downloading pgdump file..."
  wget -O "$DUMP_TAR" https://storage.googleapis.com/cronos-zkevm-mainnet-en-pgdump/external_node.tar.gz

  # Extract the dump
  echo "[*] Extracting pgdump..."
  tar -xvzf "$DUMP_TAR" -C "$DUMP_DIR"

  # Perform the restoration
  echo "[*] Restoring database..."
  pg_restore -x -O -j2 -L "$DUMP_LIST" -d "$POSTGRES_DB" -U "$POSTGRES_USER" "$EXTRACTED_DUMP"

  echo "[+] Database restoration complete."

  # Cleanup dump files
  echo "[*] Cleaning up dump files to save space..."
  rm -f "$DUMP_DIR/*"

  # Create initialization flag
  touch "$INIT_FLAG"
fi

# Bring the original postgres process back to the foreground
wait
