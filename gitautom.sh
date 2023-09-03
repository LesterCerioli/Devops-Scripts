#!/bin/bash

# GitHub repository information
github_username="YOUR_GITHUB_USERNAME"
github_repo="YOUR_GITHUB_REPO"
github_token="YOUR_GITHUB_ACCESS_TOKEN"  # You need a GitHub personal access token

# Bitbucket repository information
bitbucket_username="YOUR_BITBUCKET_USERNAME"
bitbucket_repo="YOUR_BITBUCKET_REPO"
bitbucket_password="YOUR_BITBUCKET_APP_PASSWORD"  # You should create an App Password on Bitbucket

# Branch to check out (develop in this case)
branch_name="develop"

# Clone the GitHub repository
git clone "https://github.com/$github_username/$github_repo.git"
cd "$github_repo"

# Check if the current branch is 'develop'
current_branch="$(git symbolic-ref --short HEAD)"
if [ "$current_branch" != "$branch_name" ]; then
    echo "This script should only be run on the 'develop' branch. Aborting."
    exit 1
fi

# Push the repository to Bitbucket
git remote set-url origin "https://$bitbucket_username:$bitbucket_password@bitbucket.org/$bitbucket_username/$bitbucket_repo.git"
git push -u origin --all
git push -u origin --tags

# Clean up the cloned repository
cd ..
rm -rf "$github_repo"

echo "GitHub repository has been uploaded to Bitbucket successfully."
