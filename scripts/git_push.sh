#!/bin/bash

# --- CONFIG ---
GITHUB_USERNAME="Naser507"
GITHUB_REPO="Audio_Transformer_Suite_79"
TOKEN_FILE="$HOME/.github_token"
USE_EDITOR=false   # true -> nano/vim, false -> inline commit

# --- READ TOKEN ---
if [ ! -f "$TOKEN_FILE" ]; then
    echo "❌ Token file not found at $TOKEN_FILE"
    exit 1
fi

GITHUB_TOKEN=$(cat "$TOKEN_FILE")

# --- INPUT COMMIT MESSAGE ---
if [ "$USE_EDITOR" = true ]; then
    TEMPFILE=$(mktemp)
    nano "$TEMPFILE"
    COMMIT_MSG=$(cat "$TEMPFILE")
    rm "$TEMPFILE"
else
    read -p "Enter commit message: " COMMIT_MSG
fi

# --- GIT COMMANDS ---
git add .
git commit -m "$COMMIT_MSG"

# --- PUSH ---
git push https://$GITHUB_USERNAME:$GITHUB_TOKEN@github.com/$GITHUB_USERNAME/$GITHUB_REPO.git main

echo "✅ Push completed!"
