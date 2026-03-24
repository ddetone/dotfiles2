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
    ln -sf "$DOTFILES_DIR/vscode-settings.json" "$VSCODE_DIR/settings.json"
  fi
elif [[ "$(uname)" == "Linux" ]]; then
  VSCODE_DIR="$HOME/.config/Code/User"
  if [[ -d "$VSCODE_DIR" ]]; then
    ln -sf "$DOTFILES_DIR/keybindings.json" "$VSCODE_DIR/keybindings.json"
    ln -sf "$DOTFILES_DIR/vscode-settings.json" "$VSCODE_DIR/settings.json"
  fi
fi

# Claude Code notification sound
mkdir -p "$HOME/.local/bin"
ln -sf "$DOTFILES_DIR/claude-notify.sh" "$HOME/.local/bin/claude-notify.sh"

# Merge claude hooks into ~/.claude/settings.json
CLAUDE_SETTINGS="$HOME/.claude/settings.json"
if command -v jq &>/dev/null; then
  mkdir -p "$HOME/.claude"
  if [[ -f "$CLAUDE_SETTINGS" ]]; then
    jq -s '.[0] * .[1]' "$CLAUDE_SETTINGS" "$DOTFILES_DIR/claude-settings.json" > "$CLAUDE_SETTINGS.tmp" \
      && mv "$CLAUDE_SETTINGS.tmp" "$CLAUDE_SETTINGS"
    echo "==> Merged claude hooks into $CLAUDE_SETTINGS"
  else
    cp "$DOTFILES_DIR/claude-settings.json" "$CLAUDE_SETTINGS"
    echo "==> Created $CLAUDE_SETTINGS"
  fi
else
  echo "==> WARN: jq not found, skipping claude settings merge"
fi

echo "==> Done!"
