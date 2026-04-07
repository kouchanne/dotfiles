#!/bin/bash
query=$(cat | jq -r '.query')
cd "$CLAUDE_PROJECT_DIR"

if RG=$(command -v rg 2>/dev/null) && "$RG" --version &>/dev/null; then
  RG_CMD="$RG"
else
  RG_CMD="claude --ripgrep"
fi

$RG_CMD --files --hidden --glob '!.git' | grep -i "$query" | head -20
