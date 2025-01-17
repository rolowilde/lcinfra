#!/bin/bash
export CRONTAB_FILE=${CRONTAB_FILE:-/crontab}

[[ -z "$CRONTAB_SCHEDULE" ]] && echo "fatal: CRONTAB_SCHEDULE is empty" && exit 1
[[ -z "$CRONTAB_JOB" ]] && echo "fatal: CRONTAB_JOB is empty" && exit 1

echo "$CRONTAB_SCHEDULE $CRONTAB_JOB" > $CRONTAB_FILE
supercronic "$@" /crontab
