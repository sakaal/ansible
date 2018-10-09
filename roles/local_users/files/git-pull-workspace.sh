#!/bin/bash

echo "Updating every working copy under `echo ~/workspace`"

find ~/workspace -type d -name '.git' -print0 |sort -z |uniq -z |while IFS= read -r -d $'\0' git_dir; do

    echo
    working_copy=`echo "$git_dir" | sed -r 's|/[^/]+$||'`
    cd "$working_copy"
    pwd

    git fetch

    local=`git rev-parse HEAD`
    remote=`git rev-parse @{u}`
    base=`git merge-base HEAD @{u}`

    if [ "$local" = "$remote" ]; then
        echo "Up to date."
        git status --short
    elif [ "$local" = "$base" ]; then
        echo "Pulling..."
        git --no-pager log ..@{u} --decorate=short --show-signature --date=iso
        git pull --rebase
    elif [ "$remote" = "$base" ]; then
        echo "Need to push!"
        git status --branch --short
    else
        echo "Diverged!"
        git --no-pager log ..@{u} --decorate=short --show-signature --date=iso
    fi
done
