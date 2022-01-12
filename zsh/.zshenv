if [ -f $HOME/.bash_profile ]; then
  source $HOME/.bash_profile
fi

if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi
