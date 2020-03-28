export ZSH="/Users/kais/.oh-my-zsh"
ZSH_THEME="risto"

# Oh-My-ZSH config
plugins=(git rbenv nvm bundler dotenv osx rake ruby brew docker docker-compose node npm ssh-agent vagrant vscode yarn zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Aliases and functions

alias vim='mvim -v'
alias setupTsJest='yarn add --dev jest @types/jest ts-jest @types/node typescript'
alias sizedir='du -ksh'

# Doctolib Specific
alias serv="git pull && docker-compose start && bundle && HTTPS=1 rails db:migrate RAILS_ENV=development && rails s thin -b 127.0.0.1"
alias dev="yarn && yarn dev:https"

# Git
alias clean="git reset --hard && git clean -f -d"
alias hard-clean="git clean -f -i -d -x"
alias diff= "git difftool master head"
alias config-git="git config --global -e"
alias gl="git log --oneline"
alias filehistory="git log --follow -- "
alias gs="git status"
alias resetf="git checkout head --"
alias diffp="git diff head^"
alias repo-ignore="code .git/info/exclude"
alias git-hist="git log --name-status -10"
alias grb="git branch --sort=-committerdate | head"

# Rails
alias kill-rails="tail -n 1 tmp/pids/server.pid | xargs kill -9"

# Go forward in git commit hierarchy, towards particular commit
# usage: forward master, back
forward() {
  git checkout $(git rev-list --topo-order head.."$*" | tail -1)
}
alias back='git checkout head~'


# Edit config Files
alias vv="vim ~/.vimrc"
alias zz="vim ~/.zshrc"

# Random
alias http-date="date -u +%a,\ %d\ %b\ %y\ %h:%m:%s\ gmt"

# Ctags
alias ctags="`brew --prefix`/bin/ctags"
alias gt="`brew --prefix`/bin/ctags -R --exclude=.git --exclude=dist --exclude=node_modules --exclude=log *"

# Some whacky shit
#
google() {
    open -a "google chrome" https://www.google.com/search\?q\="$*"
}

chrome() {
    open -a "google chrome" https://$1
}

r() {
    open -a "google chrome" https://old.reddit.com/r/"$1"
}

# mkcd () {
#   mkdir "$1"
#   cd "$1"
# }

# Github

prs() {
    open -a "google chrome" https://github.com/doctolib/zipper-desktop/pulls
}

pr() {
    branch_name=$(git rev-parse --abbrev-ref HEAD)
    hub pr show -h $branch_name
}

# Env Vars

export nvm_dir="$home/.nvm"
[ -s "$nvm_dir/nvm.sh" ] && \. "$nvm_dir/nvm.sh"                   # this loads nvm
[ -s "$nvm_dir/bash_completion" ] && \. "$nvm_dir/bash_completion" # this loads nvm bash_completion

# rbenv
if which rbenv >/dev/null; then eval "$(rbenv init -)"; fi

# nvm
export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# this is to solve rails related issue on mac
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# android emulator
export ANDROID_SDK=$HOME/Library/Android/sdk
export PATH=$ANDROID_SDK/emulator:$ANDROID_SDK/tools:$PATH

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


# qt
export PATH=$PATH:~/Qt/5.12.4/clang_64/bin

# nvm
export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"

export YVM_DIR="/Users/kais/.yvm"
[ -s "$YVM_DIR/yvm.sh" ] && . "$YVM_DIR/yvm.sh"

# ps
export PS_FORMAT="pid,ppid,user,pri,ni,vsz,rss,pcpu,pmem,tty,stat,args"

# fzf
# export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}), f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)'"

export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='?:toggle-preview'"

FD_OPTIONS="--follow --exclude .git --exclude node_modules"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"

export BAT_PAGER="less -R"


# nim and nimble
export PATH=/Users/kais/.nimble/bin:$PATH


# auto nvm
#
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"
  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc


# vim mode
# bindkey -v

# Fzf zsh integration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
