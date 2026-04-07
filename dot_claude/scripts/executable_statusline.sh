#!/bin/bash
# Claude Code statusline script for carving (caream.jp)
# Shows: context usage (with color/emoji), rate limits (ring meter), session cost, model name, repo name, git branch (+ worktree)

input=$(cat)

# Extract all values in a single jq call
eval "$(echo "$input" | jq -r '
  @sh "model=\(.model.display_name)",
  @sh "pct=\(.context_window.used_percentage // 0 | floor)",
  @sh "current=\(.context_window.current_usage | .input_tokens + .cache_creation_input_tokens + (.cache_read_input_tokens // 0))",
  @sh "size=\(.context_window.context_window_size // 0)",
  @sh "rl_five_pct=\(.rate_limits.five_hour.used_percentage // 0 | floor)",
  @sh "rl_seven_pct=\(.rate_limits.seven_day.used_percentage // 0 | floor)",
  @sh "cost=\(.cost.total_cost_usd // 0)",
  @sh "project_dir=\(.workspace.project_dir // "")"
')"

# ANSI colors
red=$'\x1b[31m'
yellow=$'\x1b[33m'
green=$'\x1b[32m'
reset=$'\x1b[0m'

# Context usage with color and emoji
if [ "$pct" -ge 90 ]; then
    emoji="🔴"; color="$red"
elif [ "$pct" -ge 70 ]; then
    emoji="🟡"; color="$yellow"
else
    emoji="🟢"; color="$green"
fi

# Format token counts (e.g., 1.5M, 200.0K)
format_tokens() {
    local n="$1"
    if [ "$n" -ge 1000000 ]; then
        awk -v n="$n" 'BEGIN { printf "%.1fM", n/1000000 }'
    elif [ "$n" -ge 1000 ]; then
        awk -v n="$n" 'BEGIN { printf "%.1fK", n/1000 }'
    else
        echo "$n"
    fi
}

context_info="${emoji} $(format_tokens "$current")/$(format_tokens "$size") (${color}${pct}%${reset})"

# Ring meter for rate limits
ring() {
    local p="$1"
    if   [ "$p" -ge 100 ]; then printf '●'
    elif [ "$p" -ge 75  ]; then printf '◕'
    elif [ "$p" -ge 50  ]; then printf '◑'
    elif [ "$p" -ge 25  ]; then printf '◔'
    else                        printf '○'
    fi
}

color_for_pct() {
    local p="$1"
    if   [ "$p" -ge 75 ]; then printf '%s' "$red"
    elif [ "$p" -ge 50 ]; then printf '%s' "$yellow"
    else                        printf '%s' "$green"
    fi
}

rl_info="5h $(color_for_pct "$rl_five_pct")$(ring "$rl_five_pct") ${rl_five_pct}%${reset}  7d $(color_for_pct "$rl_seven_pct")$(ring "$rl_seven_pct") ${rl_seven_pct}%${reset}"

# Git branch; detect worktree (when .git is a file, not a directory)
if [ -n "$project_dir" ] && [ -e "$project_dir/.git" ]; then
    branch=$(cd "$project_dir" && git branch --show-current 2>/dev/null || echo "no-branch")
    if [ -f "$project_dir/.git" ]; then
        wt_name=$(basename "$project_dir")
        branch="${branch} (wt:${wt_name})"
    fi
else
    branch="no-git"
fi

# Session cost
cost_formatted=$(printf '$%.2f' "$cost")

printf '%s | %s | %s | %s | %s | %s' "${context_info}" "${rl_info}" "$cost_formatted" "$model" "$branch"
