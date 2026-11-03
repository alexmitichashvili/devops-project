#!/usr/bin/env bash
# Blue-Green deploy: new version is put in inactive directory, the old one stops, new starts.
set e

PROD = production
mkdir -p $PROD

# Which directory is active right now? If deploys did not happen before - "none"
ACTIVE=$(cat $PROD/active 2>/dev/null || echo "none")
if [ "$ACTIVE" = "blue" ]; then NEW=green; else NEW=blue; fi
echo "Active: $ACTIVE -> deploy in: $NEW"

# Copying new code in incative directory
rm -rf $PROD/$NEW
mkdir -p $PROD/$NEW
cp -r app requirements.txt $PROD/$NEW/

# Stopping old version (It's PID is in app.pid)
if [ -f $PROD/app.pid ]; then kill $(cat $PROD/app.pid) 2>/dev/null || true; sleep 1; fi

# Starting new version in background and remembering it's PID
cd $PROD/$NEW
nohup python -m app.main > ../app.log 2>&1 &
echo $! > ../app.pid
cd ../..
sleep 3

# Remembering what was before (for rollback) and what is acrive now
echo "$ACTIVE" > $PROD/previous
echo "$NEW" > $PROD/active
echo "Deploy finished: active directory $NEW"
