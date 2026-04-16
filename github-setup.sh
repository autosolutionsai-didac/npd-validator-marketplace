#!/usr/bin/env bash
# ============================================================
# GitHub Setup Helper
# ============================================================
# Helps you push this marketplace to GitHub.
# Assumes you have:
#   - git installed
#   - a GitHub account
#   - GitHub CLI (gh) installed and authenticated (optional but easier)
# ============================================================

set -euo pipefail

REPO_NAME="${REPO_NAME:-npd-validator-marketplace}"
GITHUB_USER="${GITHUB_USER:-autosolutionsai-didac}"

echo ""
echo "============================================================"
echo "📦 GitHub Setup — NPD Validator Marketplace"
echo "============================================================"
echo ""
echo "Repo name: $REPO_NAME"
echo "GitHub user: $GITHUB_USER"
echo ""
read -p "Proceed with these values? (y/N): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "To change, set REPO_NAME and GITHUB_USER env vars:"
    echo "  REPO_NAME=my-repo GITHUB_USER=myuser bash github-setup.sh"
    exit 0
fi

# --- Initialize git -----------------------------------------
if [ ! -d .git ]; then
    echo "→ Initializing git repo..."
    git init
    git branch -M main
fi

echo "→ Staging files..."
git add .

if git diff --cached --quiet; then
    echo "No changes to commit."
else
    echo "→ Committing..."
    git commit -m "Initial release: NPD Validator marketplace v1.0.0

- Multi-agent product validation pipeline
- 8 specialized subagents (Research Coordinator + 5 Evaluators + Devil's Advocate + Consensus Director)
- Hardened across 7 rounds of autoresearch evaluation (45 test prompts, 100% pass rate)
- Ships as Claude Code plugin via marketplace format
- Includes OpenClaw deployment script"
fi

# --- Create GitHub repo -------------------------------------
if command -v gh &> /dev/null; then
    echo ""
    echo "→ Creating GitHub repo using gh CLI..."
    if gh repo view "$GITHUB_USER/$REPO_NAME" &> /dev/null; then
        echo "Repo already exists: https://github.com/$GITHUB_USER/$REPO_NAME"
    else
        gh repo create "$GITHUB_USER/$REPO_NAME" --public --source=. --remote=origin --push
        echo ""
        echo "✅ Repo created and pushed"
    fi
else
    echo ""
    echo "⚠️  gh CLI not installed. Manual steps:"
    echo ""
    echo "  1. Create the repo on GitHub:"
    echo "     https://github.com/new"
    echo "     Name: $REPO_NAME"
    echo "     Visibility: Public (so Claude Code can install it)"
    echo ""
    echo "  2. Add the remote and push:"
    echo "     git remote add origin git@github.com:$GITHUB_USER/$REPO_NAME.git"
    echo "     git push -u origin main"
fi

echo ""
echo "============================================================"
echo "✅ Done. Install in Claude Code with:"
echo ""
echo "   /plugin marketplace add $GITHUB_USER/$REPO_NAME"
echo "   /plugin install npd-validator@autosolutions-plugins"
echo ""
echo "============================================================"
