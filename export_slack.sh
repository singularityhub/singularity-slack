#!/bin/bash

# This is a dinky script to export Singularity slack on a daily basis
# using cron
# Here is how I made the cron job
# echo "00 00 * * * /bin/bash $PWD/export_slack.sh" >> crondude 
# crontab crondude
# Check with:
# crontab -l

# Install node/npm for version 5
# http://www.hostingadvice.com/how-to/install-nodejs-ubuntu-14-04/#node-version-manager
# Then npm i -g slack-history-export
# https://www.npmjs.com/package/slack-history-export
source .api-secrets
month=`date +%m`
day=`date +%d`
year=`date +%y`
dumphere="${year}/${month}/${day}"
mkdir -p $dumphere
slack-history-export -t "$SLACK_KEY" -c "general" -F json -f $dumphere/general.json
slack-history-export -t "$SLACK_KEY" -c "singularity-hub" -F json -f $dumphere/singularity-hub.json
git add $dumphere/*
git commit -m "Adding Singularity Slack for $dumphere"
git push origin master
