#!/bin/bash

# -------------------------
# Simple Git Push Script
# -------------------------

# GitHub configuration
GITHUB_USERNAME="Naser507"
GITHUB_REPO="Audio_Transformer_Suite_79"

# Ask for commit message
read -p "Enter commit message: " COMMIT_MSG

# Ask for GitHub token
read -sp "Enter GitHub Personal Access Token: " GITHUB_TOKEN
echo ""

# Stage all changes
git add .

# Commit changes
git commit -m "$COMMIT_MSG"

# Detect current branch
CURRENT_BRANCH=$(git branch --show-current)

# Push using HTTPS with token
git push https://$GITHUB_USERNAME:$GITHUB_TOKEN@github.com/$GITHUB_USERNAME/$GITHUB_REPO.git $CURRENT_BRANCH

echo "✅ Push completed!"

