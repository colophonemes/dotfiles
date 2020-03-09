# Sam's `tmux` setup

## Installation

Copy/symlink all the files in this repo to your `$HOME` directory:

```
git clone https://github.com/colophonemes/dotfiles
cd dotfiles
cp ./tmux/.tmux* ~/
```

Then install as follows:

```sh
# Install tmux
brew install tmux
#Install reattach-to-user-namespace
brew install reattach-to-user-namespace
# Install tmuxinator
brew install tmuxinator
```

[`tmuxinator`](https://github.com/tmuxinator/tmuxinator) handles saved window layouts. It's configured by the `.yml` files in your `~/.tmuxinator` directory.

[`reattach-to-user-namespace`]() makes sure that the `M-a` text selection command copies to the system clipboard, and that `pbpaste`/`pbcopy` work as expected.

My config uses [`powerline`](https://github.com/powerline/powerline)), which is already copied in the `./.tmux` directory of this repo. If you want to use it, you should install a patched font from the [`powerline-fonts` repo](https://github.com/powerline/fonts), and then set that as your Terminal's default font (I use _Inconsolata-g_).

## Usage

You can start a naked `tmux` session with the `tmux` command, but you probably want to use a saved `tmuxinator` layout:

```sh
# opens the layout defined in ~/.tmuxinator/dev.yml
mux start dev
```
