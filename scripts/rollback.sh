#!/usr/bin/env bash
# Rollback: returns to previous directory (blue <-> green)

PROD=production
PREV=$(cat $PROD/previous 2>/dev/null || echo "none")

if [ "$PREV" = "none" ] || [ ! -d "$PROD/$PREV" ]; then
  echo "No previous version --- nowhere to rollback"
  exit 0
fi

# Stopping broken version and starting previous one
if [ -f $PROD/app.pid ]; then kill $(cat $PROD/app.pid) 2>/dev/null || true; sleep 1; fi
cd $PROD/$PREV
nohup python -m app.main > ../app.log 2>&1 &
echo $! > ../app.pid
cd ../..
sleep 3

echo "$PREV" > $PROD/active
echo "Rollback done: active directory $PREV"
