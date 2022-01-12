#!/usr/bin/env bash

# script base from https://betterdev.blog/minimal-safe-bash-script-template/

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] [-f] -p param_value arg1 [arg2...]

Install dotfiles

Available options:

-h, --help      Print this help and exit
-v, --verbose   Print script debug info
EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

parse_params() {
  # default values of variables set from params
  flag=0
  param=''

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose) set -x ;;
    --no-color) NO_COLOR=1 ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  return 0
}

parse_params "$@"
setup_colors

# script logic here

# keyboard
ln -snf $script_dir/keyboard/* $HOME/.keyboard/hammerspoon/

# tmux
ln -snf $script_dir/tmux $HOME/

# vscode
rm -f $HOME/Library/Application\ Support/Code/User/settings.json
rm -f $HOME/Library/Application\ Support/Code/User/keybindings.json
rm -rf $HOME/Library/Application\ Support/Code/User/snippets

ln -snf $script_dir/vscode/* $HOME/Library/Application\ Support/Code/User/


# zsh
rm -f $HOME/.zshrc
rm -f $HOME/.zshenv
rm -f $HOME/.p10k.zsh

ln -snf $script_dir/zsh/.zshrc $HOME/.zshrc
ln -snf $script_dir/zsh/.zshenv $HOME/.zshenv
ln -snf $script_dir/zsh/.p10k.zsh $HOME/.p10k.zsh

# git
rm -f $HOME/.gitconfig
ln -snf $script_dir/git/.gitconfig $HOME/.gitconfig
