export ZSH="/Users/kais/.oh-my-zsh"
ZSH_THEME="risto"

# Oh-My-ZSH config
plugins=(git rbenv nvm bundler dotenv osx rake ruby brew docker docker-compose node npm ssh-agent vagrant vscode yarn zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Aliases and functions
alias vim='mvim -v'
alias setupTsJest='yarn add --dev jest @types/jest ts-jest @types/node typescript eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin'
alias szd='du -ksh'
alias lstp='lsof -nP -iTCP | grep LISTEN'
alias dos2unix="perl -pi -e 's/\r\n/\n/g'"

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
alias grb1="grb | awk 'NR==1 {print $1}' | xargs git checkout"
alias grb2="grb | awk 'NR==2 {print $1}' | xargs git checkout"
alias grb3="grb | awk 'NR==3 {print $1}' | xargs git checkout"
alias grb4="grb | awk 'NR==4 {print $1}' | xargs git checkout"
alias grb5="grb | awk 'NR==5 {print $1}' | xargs git checkout"
alias grb6="grb | awk 'NR==6 {print $1}' | xargs git checkout"
alias gmbd="git diff $(git merge-base --fork-point master)"
alias master="git checkout master && git pull"

# Rails
alias kill-rails="tail -n 1 tmp/pids/server.pid | xargs kill -9"

# PERSONAL: tstrap
function tstrap() {
  [ -z $1 ] && echo "project name not specified"  && echo "Usage: tstrap <project-name>" && return
  
   git clone --depth 1 git@github.com:GozaRuu/tstrap.git "$1"
   cd "$1"
   rm -rf .git
   git init
   yarn upgrade --latest
}

# Fzf magic
b() {
  local open ruby output
  open=xdg-open
  ruby=$(which ruby)
  output=$($ruby << EORUBY
# encoding: utf-8

require 'json'
FILE = 'Library/Application\ Support/Google/Chrome/Profile\ 1/Bookmarks'
CJK  = /\p{Han}|\p{Katakana}|\p{Hiragana}|\p{Hangul}/

def build parent, json
  name = [parent, json['name']].compact.join('/')  
  if json['type'] == 'folder'
    json['children'].map { |child| build name, child }
  else
    { name: name, url: json['url'] }
  end
end

def just str, width
  str.ljust(width - str.scan(CJK).length)
end

def trim str, width
  len = 0
  str.each_char.each_with_index do |char, idx|
    len += char =~ CJK ? 2 : 1
    return str[0, idx] if len > width
  end
  str
end

width = `tput cols`.to_i / 2
json  = JSON.load File.read File.expand_path FILE
items = json['roots']
        .values_at(*%w(bookmark_bar synced other))
        .compact
        .map { |e| build nil, e }
        .flatten

items.each do |item|
  name = trim item[:name], width
  puts [just(name, width),
        item[:url]].join("\t\x1b[36m") + "\x1b[m"
end
EORUBY
)

  echo -e "$output"                                            |
  fzf-tmux -u 30% --ansi --multi --no-hscroll --tiebreak=begin |
  awk 'BEGIN { FS = "\t" } { print $2 }'                       |
  xargs open &>/dev/null

}

# Go forward in commit history, towards particular commit
# usage: forward master
forward() {
  git checkout $(git rev-list --topo-order HEAD.."$*" | tail -1)
}
alias back='git checkout head~'

# robocop
#
rbc() {
   git status | grep  'modified:\|new file:.*\.rb' | cut -f2 -d: | sed 's/^ *//' | xargs rubocop -a
}


# Edit config Files
alias vv="vim ~/.vimrc"
alias zz="vim ~/.zshrc"

# Random
alias http-date="date -u +%a,\ %d\ %b\ %y\ %h:%m:%s\ gmt"
alias wt="curl wttr.in"
alias opports="netstat -ntl"
function raw-curl() {
  curl -ivs --raw "$1" | bat 
}


# Ctags
alias ctags="`brew --prefix`/bin/ctags"
alias gt="`brew --prefix`/bin/ctags -R --exclude=.git --exclude=dist --exclude=node_modules --exclude=log *"

# Some whacky shit
#

turnout() {
  echo "run 'rm  ~/Downloads/turnin*' download the file and give the candidte name as first argument kebab-case"
  cd ~/Downloads
  mkdir "$1"
  cp turnin.git.zip "$1"
  cd "$1"
  unzip turnin.git.zip
  git clone turnin.git
  mkdir ~/projects/job-applications/javascript/test-review-machine/src/candidates/"$1"
  cp ./turnin/src/* ~/projects/job-applications/javascript/test-review-machine/src/candidates/"$1"
  cd ~/projects/job-applications/javascript/test-review-machine
  git pull
  yarn
  yarn test "$1"
}

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


export PATH=$PATH:"$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# this is to solve rails related issue on mac
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# android emulator
export ANDROID_SDK=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK/emulator:$ANDROID_SDK/tools:$PATH

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


# python

export PATH=$PATH:"/Users/kais/Library/Python/3.7/bin"


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
