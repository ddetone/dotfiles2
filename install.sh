# Add symlinks to home directory.
echo "\n==> Adding symlinks to my home directory"
set -ex
cd $HOME
ln -sf ~/code/dotfiles2/.zshrc .
ln -sf ~/code/dotfiles2/.tmux.conf .
ln -sf ~/code/dotfiles2/.vimrc .
ln -sf ~/code/dotfiles2/keybindings.json /Users/ddetone/Library/Application\ Support/Code/User/keybindings.json
