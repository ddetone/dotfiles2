# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/ddetone/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/ddetone/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ddetone/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/ddetone/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# My aliases.
alias ez="vi $HOME/.zshrc"
alias sz="source $HOME/.zshrc"
alias pyserver="python3 -m http.server"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
set -o noclobber
alias duh='du -ch -d=1'
alias dus='du -hs * | sort -h'
alias tre='tree -A -C -L 2'
alias ll='ls -FGlAhp'
alias ls='ls -FGhp'

# Prompt
setopt PROMPT_SUBST
autoload -U colors && colors
BOLD="%B"
RESET="%b%f"
RED="%F{red}"
GREEN="%F{green}"
parse_git_branch() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local branch status
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --always)
    status=$(git status --porcelain 2>/dev/null)
    if [[ -n "$status" ]]; then
      echo "(${RED}${branch}*${RESET})"
    else
      echo "(${GREEN}${branch}${RESET})"
    fi
  fi
}
conda_env() {
  [[ -n "$CONDA_DEFAULT_ENV" ]] && echo "%F{blue}($CONDA_DEFAULT_ENV)%f"
}

PROMPT='${BOLD}%~${RESET} $(conda_env) $(parse_git_branch)$ '
