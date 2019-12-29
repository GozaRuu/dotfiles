# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/kais/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="risto"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git rbenv nvm bundler dotenv osx rake ruby brew docker docker-compose node npm ssh-agent vagrant vscode yarn)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.fƒF
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# use macVim as THE VIM
alias vim='mvim -v'

#Doctolib repo
alias serv="git pull && docker-compose start && bundle && HTTPS=1 rails db:migrate RAILS_ENV=development && rails s thin -b 127.0.0.1"
alias dev="yarn && yarn dev:https"

#git stuff
alias clean="git reset --hard && git clean -f -d"
alias hard-clean="git clean -f -i -d -x"
alias diff= "git difftool master HEAD"
alias config-git="git config --global -e"
alias gl="git log --oneline"
alias resetf="git checkout HEAD --"
alias diffp="git diff HEAD^"
alias repo-ignore="code .git/info/exclude"
alias git-hist="git log --name-status -10"

# edit .rc files
alias vv="vim ~/.vimrc"
alias zz="vim ~/.zshrc"

# random
alias http-date="date -u +%a,\ %d\ %b\ %Y\ %H:%M:%S\ GMT"

google() {
    open -a "Google Chrome" https://www.google.com/search\?q\="$*"
}


chrome() {
    open -a "Google Chrome" https://$1
}

r() {
    open -a "Google Chrome" https://old.reddit.com/r/"$1"
}

prs() {
    open -a "Google Chrome" https://github.com/doctolib/zipper-desktop/pulls
}

pr() {
    branch_name="$(git symbolic-ref HEAD 2>/dev/null)" || branch_name="(unnamed branch)" # detached HEAD
    branch_name=${branch_name##refs/heads/}
    hub pr show -h $branch_name
}

# Go forward in Git commit hierarchy, towards particular commit 
# Usage:
#  forward master
# Does nothing when the parameter is not specified.
forward() {
  git checkout $(git rev-list --topo-order HEAD.."$*" | tail -1)
}
alias back='git checkout HEAD~'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

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

# nvm
export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"

export YVM_DIR="/Users/kais/.yvm"
[ -s "$YVM_DIR/yvm.sh" ] && . "$YVM_DIR/yvm.sh"

# vim mode
bindkey -v

