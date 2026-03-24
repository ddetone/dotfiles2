
# fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--bind 'ctrl-k:kill-line'"
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
# alias pip=pip3 # make pip and pip3 the same
# alias python3=python
#alias condapip=~/miniconda3/bin/pip

# Share history across tmux panes.
setopt inc_append_history
setopt SHARE_HISTORY       # Share command history between all sessions
setopt INC_APPEND_HISTORY  # Add commands to history as soon as they’re entered
setopt HIST_IGNORE_DUPS    # Don't record duplicate commands
setopt HIST_FIND_NO_DUPS   # Don't show duplicates when searching
# ✅ Make history instantly updated across sessions
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

export META_CLAUDE_CODE_RELEASE=latest


# Prompt                                                             
setopt PROMPT_SUBST
autoload -U colors && colors
BOLD="%B"
RESET="%b%f"                                                                                                                              
RED="%F{red}"
GREEN="%F{green}"
BLUE="%F{blue}"
YELLOW="%F{yellow}"                                                  
parse_git_branch() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local branch dirty                                               
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --always)
    dirty=$(git status --porcelain 2>/dev/null)    
    if [[ -n "$dirty" ]]; then                                       
      echo "(${RED}${branch}*${RESET})"
    else             
      echo "(${GREEN}${branch}${RESET})"
    fi                                                               
  fi                                                                 
}                
conda_env() {
  [[ -n "$CONDA_DEFAULT_ENV" ]] && echo "${BLUE}[$CONDA_DEFAULT_ENV]${RESET}"
}                                                                                                                                         
os_type() {                                                                                                                               
  case "$(uname -s)" in                                                                                                                   
    Darwin) echo "${YELLOW}[mac]${RESET}" ;;                                                                                              
    Linux)
      if [[ -f /etc/os-release ]]; then
        local distro=$(grep -oP '^ID=\K\w+' /etc/os-release 2>/dev/null)
        echo "${YELLOW}[${distro:-linux}]${RESET}"
      else                                                           
        echo "${YELLOW}[linux]${RESET}"                                                                                                   
      fi             
      ;;                 
    *) echo "${YELLOW}[$(uname -s)]${RESET}" ;;
  esac                                                                                                                                    
}                                                                    
PROMPT='${BOLD}%~${RESET} $(os_type) $(conda_env) $(parse_git_branch)$ '

# Paths
export PATH=$PATH:"/opt/homebrew/bin"

# Fb related
export FED="100.118.83.38"
alias fbf="cd $HOME/fbsource/fbcode/surreal/fov3d"
alias fbb="cd $HOME/fbsource/arvr/projects/surreal/boxy"
alias fbe="cd $HOME/fbsource/arvr/projects/surreal/experiments/efm"
alias fcb="cd $HOME/code/boxer"
export PYTHONPATH=$PYTHONPATH:$HOME/fbsource/fbcode
export PYTHONPATH=$PYTHONPATH:$HOME/fbsource
export PYTHONPATH=$PYTHONPATH:$HOME/code/ca1m
export PYTHONPATH=$PYTHONPATH:$HOME/code/fish
#b is for buck
autoload -Uz compinit
compinit
source $HOME/fbsource/arvr/scripts/twhelan/b/b-completion.bash
export PATH="$HOME/fbsource/arvr/scripts/twhelan/b/:$PATH"


# Option+Backspace: delete previous word
bindkey '^[^?' backward-kill-word
# Option+Left/Right: move by word
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word

export CONDA_CHANGEPS1=no # don't let conda change prompt

# >>> conda initialize >>>
__conda_setup="$('/Users/ddetone/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
eval "$__conda_setup"
# <<< conda initialize <<<

