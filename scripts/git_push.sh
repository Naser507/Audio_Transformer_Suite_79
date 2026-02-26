#!/bin/bash

# -------------------------
# ATS79 Repo Push & Release Script
# -------------------------

# Path to your deploy key
DEPLOY_KEY="$HOME/.ssh/ats79_deploy_key"

# Ensure deploy key exists
if [ ! -f "$DEPLOY_KEY" ]; then
    echo "❌ Deploy key not found at $DEPLOY_KEY"
    exit 1
fi

# Ask for commit message
read -p "Enter commit message: " COMMIT_MSG

# -------------------------
# Commit source code only
# -------------------------
echo "📦 Staging source code..."
git add .
git commit -m "$COMMIT_MSG"

# Detect current branch
CURRENT_BRANCH=$(git branch --show-current)

# Push using deploy key
echo "🚀 Pushing source code to GitHub..."
GIT_SSH_COMMAND="ssh -i $DEPLOY_KEY -o IdentitiesOnly=yes" git push origin $CURRENT_BRANCH

if [ $? -ne 0 ]; then
    echo "❌ Git push failed!"
    exit 1
else
    echo "✅ Git push completed successfully!"
fi

# -------------------------
# GitHub Release
# -------------------------

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI 'gh' not found. Please install it to upload release assets."
    exit 1
fi

# Specify the main release executable explicitly
MAIN_EXE="Release/Beta/ATS79.exe"

if [ ! -f "$MAIN_EXE" ]; then
    echo "⚠️ $MAIN_EXE not found. Skipping GitHub Release."
    exit 0
fi

# Generate version tag based on date/time: vYYYYMMDDHHMM
VERSION_TAG="v$(date +%Y%m%d%H%M)"

# Create GitHub Release and upload the ATS79.exe
echo "🚀 Creating GitHub Release: $VERSION_TAG with asset $MAIN_EXE..."
gh release create "$VERSION_TAG" "$MAIN_EXE" \
    --title "ATS79 Build $(date +%Y-%m-%d)" \
    --notes "Automated release generated from branch $CURRENT_BRANCH."

if [ $? -eq 0 ]; then
    echo "✅ GitHub Release created successfully!"
else
    echo "❌ Failed to create GitHub Release."
fi
