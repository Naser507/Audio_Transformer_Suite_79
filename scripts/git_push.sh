#!/bin/bash

# -------------------------
# Simple Git Push Script
# -------------------------

# GitHub configuration
GITHUB_USERNAME="Naser507"
GITHUB_REPO="Audio_Transformer_Suite_79"

# Token file path
TOKEN_FILE="${HOME}/.github_token"

# Check if token file exists
if [ ! -f "$TOKEN_FILE" ]; then
    echo "❌ Token file not found at $TOKEN_FILE"
    exit 1
fi

# Read token and strip newlines just in case
GITHUB_TOKEN=$(tr -d '\n' < "$TOKEN_FILE")

# Ask for commit message
read -p "Enter commit message: " COMMIT_MSG

# Stage all changes
git add .

# Commit changes
git commit -m "$COMMIT_MSG"

# Detect current branch
CURRENT_BRANCH=$(git branch --show-current)

# Push using HTTPS with token
git push https://$GITHUB_USERNAME:$GITHUB_TOKEN@github.com/$GITHUB_USERNAME/$GITHUB_REPO.git $CURRENT_BRANCH

echo "✅ Push completed!"
