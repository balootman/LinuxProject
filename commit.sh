#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "ERROR: needed 1 argument for Dev Description!"
    exit 1
fi

if [ ! -f "bugs.csv" ]; then
    echo "File 'bugs.csv' is not available."
    exit 1
fi

developer_description="$1"

# Get the current Git branch
current_branch=$(git rev-parse --abbrev-ref HEAD)

parameters=$(grep $current_barnch bugs.csv)

bug_id=$($parameters | cut -d',' -f1)
description=$($parameters | cut -d',' -f2)
date=$(date +"%Y-%m-%d %H:%M:%S")
dev_name=$($parameters | cut -d',' -f4)
priority=$($parameters | cut -d',' -f5)
github_url=$($parameters | cut -d',' -f6)

commit_message="${bug_id}:${date}:${current_branch}:${dev_name}:${priority}:${description}:${developer_description}"

git add .
git commit -m "$commit_message"
git push origin "$current_branch"