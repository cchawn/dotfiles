#!/bin/bash
# Read JSON input from stdin
input=$(cat)

# Extract values from JSON
time_now=$(date +%H:%M)
username=$(whoami)
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')
model_name=$(echo "$input" | jq -r '.model.display_name')
output_style=$(echo "$input" | jq -r '.output_style.name')
vim_mode=$(echo "$input" | jq -r '.vim.mode // empty')

# Context window info
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // 0')

# Colour palette
ORANGE="\e[96m"
YELLOW="\e[33m"
GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

# Start building the status line
output=""

# Time
output+=$(printf "🔮 %s " "$time_now")

# Directory
if [ -n "$current_dir" ]; then
  # Get just the directory name if in a git repo, otherwise show last 2 path components
  if git -C "$current_dir" rev-parse --git-dir >/dev/null 2>&1; then
    dir_name=$(basename "$current_dir")
  else
    dir_name=$(echo "$current_dir" | awk -F'/' '{if (NF>2) print $(NF-1)"/"$NF; else print $0}')
  fi
  output+=$(printf "🏰 %s " "$dir_name")
fi

# Git info
if [ -n "$current_dir" ] && git -C "$current_dir" rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(git -C "$current_dir" branch --show-current 2>/dev/null || echo "detached")
  output+=$(printf " %s " "$branch")
fi


# Set colour based on usage percentage
if [ "$used" -lt 25 ]; then
  colour_code=$GREEN
elif [ "$used" -lt 50 ]; then
  colour_code=$ORANGE
else
  colour_code=$RED
fi

# Colour coded model and usage
output+=$(printf "${colour_code}👸 %s${RESET}" "$model_name")
if [ -n "$used" ] && [ "$used" != "null" ]; then
  output+=$(printf " ${colour_code}(%s%%)${RESET}" "$used")
fi

# Vim mode indicator if present
if [ -n "$vim_mode" ]; then
  if [ "$vim_mode" = "INSERT" ]; then
    output+=$(printf " ${GREEN}[INSERT]${RESET}")
  else
    output+=$(printf " ${RED}[NORMAL]${RESET}")
  fi
fi

printf "%b\n" "$output"
