#!/usr/bin/env bash
set -euo pipefail

# Define paths
DUMP_DIR="/dump"
TAR_NAME="external_node.tar.gz"
DUMP_TAR="${DUMP_DIR}/${TAR_NAME}"
DUMP_LIST="${DUMP_DIR}/external_node/pg_restore.list"
EXTRACTED_DUMP="${DUMP_DIR}/external_node/dump"
INIT_FLAG="${DUMP_DIR}/.initialized"

if [ -n "${PG_SNAPSHOT}" ]; then
  echo "[*] Downloading snapshot file"
  aria2c -c -x6 -s6 --auto-file-renaming=false --conditional-get=true --allow-overwrite=true -d "$DUMP_DIR" -o "$TAR_NAME" "${PG_SNAPSHOT}"

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
