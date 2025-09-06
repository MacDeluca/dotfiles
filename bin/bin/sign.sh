#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <commit-hash>"
    exit 1
fi

commit_hash=$1

git checkout "$commit_hash"^

git cherry-pick "$commit_hash" -x -s

# Replace the old commit locally
git replace "$commit_hash" HEAD

git filter-branch -- --all
