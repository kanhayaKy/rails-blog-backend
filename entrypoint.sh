#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Create the database if it doesn't exist
rails db:create

# Run database migrations
rails db:migrate

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
