#!/usr/bin/env bash
set -euo pipefail

echo "🔄 Starting Postgres (in background)..."
docker compose up -d postgres

echo "⏳ Waiting for database to finish restoring..."
until docker exec cronos-zkevm-postgres test -f /dump/.initialized 2>/dev/null; do
  echo "⏱️  Still waiting for DB restore... ($(date))"
  sleep 30
done

echo "✅ Database restore complete!"
echo "🚀 Starting Cronos zkEVM node..."
docker compose up -d consensus

echo "🎉 Done! zkEVM node is starting. You can monitor with:"
echo "    docker compose logs -f consensus"
