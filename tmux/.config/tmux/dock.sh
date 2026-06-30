#!/usr/bin/env zsh

owner="$1"
dir="$2"
side="${3:-left}"
size="${4:-40%}"
park="_dock_${owner#@}"
cmd="${DOCK_CMD:-claude}"

ensure_park() { tmux has-session -t "=$park" 2>/dev/null || tmux new-session -d -s "$park"; }

pane="$(tmux list-panes -a -F '#{pane_id} #{@dock}' | awk -v o="$owner" '$2==o {print $1; exit}')"

if [ -n "$pane" ] && [ "$(tmux display -p -t "$pane" '#{window_id}')" = "$owner" ]; then
  [ "$(tmux display -p -t "$owner" '#{window_zoomed_flag}')" = "1" ] \
    && [ "$(tmux display -p -t "$owner" '#{pane_id}')" = "$pane" ] \
    && tmux resize-pane -Z -t "$pane"
  ensure_park
  tmux join-pane -s "$pane" -t "$park:"
  exit 0
fi

if [ -z "$pane" ]; then
  ensure_park
  pane="$(tmux new-window -dP -F '#{pane_id}' -t "$park:" -c "$dir" "$cmd")"
  tmux set -p -t "$pane" @dock "$owner"
fi

if [ "$side" = "right" ]; then
  tmux join-pane -h  -l "$size" -s "$pane" -t "$owner"
else
  tmux join-pane -hb -l "$size" -s "$pane" -t "$owner"
fi
tmux select-pane -t "$pane"
