#!/bin/bash


if [ ! -f "bugs.csv" ]; then
    echo "File 'bugs.csv' is not available."
    exit 1
fi

developer_description="$1"

# Get the current Git branch
current_branch=$(git rev-parse --abbrev-ref HEAD)

bug_id=$(grep $current_branch bugs.csv | cut -d ',' -f1)
description=$(grep $current_branch bugs.csv | cut -d ',' -f2)
date=$(date +"%Y-%m-%d %H:%M:%S")
dev_name=$(grep $current_branch bugs.csv | cut -d ',' -f4)
priority=$(grep $current_branch bugs.csv | cut -d ',' -f5)
github_url=$(grep $current_branch bugs.csv | cut -d ',' -f6)

commit_message="${bug_id}:${date}:${current_branch}:${dev_name}:${priority}:${description}:${developer_description}"

git add .
git commit -m "$commit_message"
git push origin "$current_branch"