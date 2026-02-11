#!/bin/bash

# -------------------------
# Repo-specific SSH Push Script
# -------------------------

# Path to your deploy key (replace if you used a different filename)
DEPLOY_KEY="$HOME/.ssh/ats79_deploy_key"

# Ensure deploy key exists
if [ ! -f "$DEPLOY_KEY" ]; then
    echo "❌ Deploy key not found at $DEPLOY_KEY"
    exit 1
fi

# Ask for commit message
read -p "Enter commit message: " COMMIT_MSG

# Stage all changes
git add .

# Commit changes
git commit -m "$COMMIT_MSG"

# Detect current branch
CURRENT_BRANCH=$(git branch --show-current)

# Push using deploy key
echo "🚀 Pushing to GitHub..."
GIT_SSH_COMMAND="ssh -i $DEPLOY_KEY -o IdentitiesOnly=yes" git push origin $CURRENT_BRANCH

# Check if push succeeded
if [ $? -eq 0 ]; then
    echo "✅ Push completed successfully!"
else
    echo "❌ Push failed!"
fi


