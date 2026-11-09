#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

echo "Building the React frontend..."
npm run build --prefix frontend

echo "Starting the app at http://127.0.0.1:8000/ (index is prepared/verified during startup)"
python -m uvicorn backend.main:app --reload
