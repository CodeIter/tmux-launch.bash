#!/usr/bin/env bash

# Setup GnuPG agent
# Set GPG_TTY needed by tmux
# See https://bbs.archlinux.org/viewtopic.php?id=262296
export GPG_TTY=$(tty)

# Start tmux if installed
if [[ -z "${TMUX:-}" ]] \
&& [[ -z "${TMUX_PANE:-}" ]] \
; then
  if type tmux &> /dev/null ; then
    if [[ -z "${TMUX_MAIN_SESSION:-}" ]] ; then
      for _i in main default master 0 ; do
        if tmux has-session -t "${_i}" &> /dev/null ; then
          export TMUX_MAIN_SESSION="${_i}"
          if [[ "${_i}" == "0" ]] ; then
            tmux rename-session t "${_i}" main \
            && export TMUX_MAIN_SESSION="main"
          fi
          break
        fi
      done
      unset _i
    fi
    if [[ -n "${TMUX_MAIN_SESSION:-}" ]] ; then

      _tmux_sess_group="${TMUX_MAIN_SESSION}_grp"

      # Open new session
      _tmux_sess_nbre="$(tmux list-sessions | wc -l)"
      _tmux_sess_nbre="${_tmux_sess_nbre:-1}"
      ((_tmux_sess_nbre++))
      _tmux_new_sess="${TMUX_MAIN_SESSION}${_tmux_sess_nbre}"
      tmux new-session -d -s "${_tmux_new_sess}" -n main
      exec tmux -l new-session -A -s "${_tmux_new_sess}" -t "${_tmux_sess_group}" &> /dev/null

      # Or open new window in main (first) session
      #_tmux_win_nbre="$(tmux list-window -t "${TMUX_MAIN_SESSION}" | wc -l)"
      #_tmux_win_nbre="${_tmux_win_nbre:-1}"
      #((_tmux_win_nbre++))
      #_tmux_new_win="main${_tmux_win_nbre}"
      #tmux new-session -A -d \
      #  -s "${TMUX_MAIN_SESSION}" \
      #  -n "${TMUX_MAIN_SESSION}" \; \
      #  new-window -a \
      #    -t "${TMUX_MAIN_SESSION}" \
      #    -n "${_tmux_new_win}" \; \
      #  detach \
      #  &> /dev/null
      #exec tmux -l new-session -A \
      #  -s "${TMUX_MAIN_SESSION}" \
      #  -t "${_tmux_sess_group}" \
      #  &> /dev/null

    else

      # Open new session when there is no "main" session
      export TMUX_MAIN_SESSION="main"
      tmux new-session -d -s main -n main
      exec tmux -l new-session -A -s main -t main_grp &> /dev/null

      # Or open last session ,if not open new "main" session
      #tmux list-sessions &> /dev/null \
      #&& exec tmux -l attach-session \
      #|| { tmux new-session -d -s main -n main ; exec tmux -l new-session -A -s main -t main_grp &> /dev/null ; }

    fi
  fi
fi
unset _tmux_new_win
unset _tmux_win_nbre
unset _tmux_sess_group

