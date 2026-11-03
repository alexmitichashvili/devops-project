#!/usr/bin/env bash
# Checking if app responds and writing the result in logs/health.log
URL=${1:-http://127.0.0.1:8000/health}
mkdir -p logs

# curl returns only HTTP response (000 if server does not respond)
CODE=$(curl -s --noproxy '*' -o /dev/null -w "%{http_code}" --max-time 5 "$URL")
TIME=$(date '+%Y-%m-%d %H:%M:%S')

if [ "$CODE" = "200" ]; then
  echo "$TIME | $URL | UP | HTTP $CODE" >> logs/health.log
  echo "Health check OK: app works"
  exit 0
else
  echo "$TIME | $URL | DOWN | HTTP $CODE" >> logs/health.log
  echo "Health check FAILED: app is unavailable"
  exit 1
fi
