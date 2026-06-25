#!/usr/bin/env zsh

[[ -z "$1" ]] && exit 0

dir=" ${1:t}"
branch="$(git -C "$1" symbolic-ref --short --quiet HEAD 2>/dev/null)"
if [[ -n "$branch" ]]; then
  [[ -n "$(git -C "$1" status --porcelain 2>/dev/null)" ]] && branch="$branch*"
  branch=" $branch"
fi

printf '%s  %s' "$branch" "$dir"
