#!/bin/sh

# This is a dinky script to export Singularity slack on a daily basis
# using cron
# Here is how I made the cron job
# echo "00 00 * * * /bin/bash $PWD/export_slack.sh" >> crondude 
# crontab crondude
# Check with:
# crontab -l

# https://www.npmjs.com/package/slack-history-export
source .api-secrets
month=`date +%m`
day=`date +%d`
year=`date +%y`
dumphere="${year}/${month}/${day}"
mkdir -p $dumphere
slack-history-export -t "$SLACK_KEY" -T "channel" -c "#all" -F json -d $dumphere
git add $dumphere/*
git commit -m "Adding Singularity Slack for $dumphere"
git push origin master
