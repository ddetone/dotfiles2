#!/bin/bash
# Install dotfiles - works on macOS and Fedora

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Adding symlinks from $DOTFILES_DIR"

# Shell config
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"

# VSCode keybindings (macOS only)
if [[ "$(uname)" == "Darwin" ]]; then
  VSCODE_DIR="$HOME/Library/Application Support/Code/User"
  if [[ -d "$VSCODE_DIR" ]]; then
    ln -sf "$DOTFILES_DIR/keybindings.json" "$VSCODE_DIR/keybindings.json"
  fi
elif [[ "$(uname)" == "Linux" ]]; then
  VSCODE_DIR="$HOME/.config/Code/User"
  if [[ -d "$VSCODE_DIR" ]]; then
    ln -sf "$DOTFILES_DIR/keybindings.json" "$VSCODE_DIR/keybindings.json"
  fi
fi

echo "==> Done!"
