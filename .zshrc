# Load Power10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
CASE_SENSITIVE="true"
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 13
COMPLETION_WAITING_DOTS="%F{green}...%f"
plugins=(git macos zsh-autosuggestions ssh-agent)
source $ZSH/oh-my-zsh.sh

# mvim
alias vim='mvim -v'
export PATH=$PATH:/Applications/MacVim.app/Contents/bin

# fzf
export FZF_PREVIEW_COMMAND="bat --style=numbers,changes --wrap never --color always {} || cat {} || tree -C {}"
export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info
--preview='bat --style=numbers --color=always {} || cat {}'
--preview-window='right:wrap'
--bind='?:toggle-preview'
--bind='ctrl-y:preview-up'
--bind='ctrl-e:preview-down'"

FD_OPTIONS="--follow --exclude .git --exclude node_modules"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"

export BAT_PAGER="less -R"

# git aliases
alias clean="git reset --hard && git clean -f -d"
alias hard-clean="git clean -f -i -d -x"
alias gl="git log --oneline"
alias filehistory="git log --follow -- "
alias gs="git status"
alias grb="git branch --sort=-committerdate | head"
alias rdiff='git diff $(git merge-base --fork-point main)'
alias main="git checkout main && git pull"

# quick edit
alias vv="vim ~/.vimrc"
alias zz="vim ~/.zshrc"
alias cc="claude --dangerously-skip-permissions"
alias ccw="claude --dangerously-skip-permissions --worktree"

# utility
kill_port() {
  if [ -n "$1" ]; then
    lsof -ti :"$1" | xargs kill -9
  else
    echo "Pass in the port number."
  fi
}
alias oports="sudo lsof -i -P | grep LISTEN"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# powerlevel10k
source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

. "$HOME/.local/bin/env"

# bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# expo
export EXPO_UNSTABLE_MCP_SERVER=1
