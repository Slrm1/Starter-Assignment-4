#!/bin/bash
# Script to start Django server for Codio
# Usage: ./start_codio.sh

echo "Starting Django server for Codio..."
echo "Server will be accessible at: https://$(echo $CODIO_HOSTNAME)-8000.codio.io"
echo ""
cd "$(dirname "$0")"
python3 manage.py runserver 0.0.0.0:8000

