#!/usr/bin/env zsh
[[ -z "$1" ]] && exit 0

branch="$(git -C "$1" symbolic-ref --short --quiet HEAD 2>/dev/null)"

dir=" ${1:t}"
[[ -n "$branch" ]] && branch=" $branch"
printf '%s  %s' "$branch" "$dir"
