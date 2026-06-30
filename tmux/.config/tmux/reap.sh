#!/usr/bin/env zsh

tmux list-windows -a -F '#{window_id}' 2>/dev/null | while read -r w; do
  tmux list-panes -t "$w" -F '#{@dock}' 2>/dev/null | grep -q '^$' ||
    tmux kill-window -t "$w" 2>/dev/null
done

existing=" $(tmux list-windows -a -F '#{window_id}' 2>/dev/null | tr '\n' ' ') "
tmux list-sessions -F '#{session_name}' 2>/dev/null | while read -r s; do
  case "$s" in
    _pop_*) n="${s#_pop_}" ;;
    _dock_*) n="${s#_dock_}" ;;
    *) continue ;;
  esac
  case "$existing" in
    *" @$n "*) ;;
    *) tmux kill-session -t "=$s" ;;
  esac
done
