#!/bin/bash
# Claude Code Stop hook - macOS notification
input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd // ""')
repo=$(basename "$cwd")
branch=$(git -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")

if [ -n "$branch" ]; then
  message="${repo} (${branch})"
else
  message="${repo}"
fi

osascript -e "display notification \"${message}\" with title \"Claude Code\" subtitle \"セッション終了\""
