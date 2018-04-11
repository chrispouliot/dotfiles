# Path to your oh-my-zsh installation.
export ZSH=/Users/christophepouliot/.oh-my-zsh

ZSH_THEME="geometry/geometry"
GEOMETRY_PROMPT_PLUGINS=(virtualenv git)

# How often update is checked
export UPDATE_ZSH_DAYS=13

ENABLE_CORRECTION="true"

plugins=(zsh-syntax-highlighting zsh-autosuggestions kubectl)

source $ZSH/oh-my-zsh.sh
source ~/Projects/dev-config/kube.zsh

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"


DEFAULT_USER=christophepouliot

# INIT
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval $(thefuck --alias fuck)

# ALIASES
alias swupy='cd ~/Projects/web-app'
alias swugo='cd ~/go/src/github.com/sendwithus'
alias dysgo='cd ~/go/src/github.com/techdroplabs/dyspatch'
alias herokuw='heroku accounts:set work'
alias herokup='heroku accounts:set personal'
alias ga='git add -A && git status'
alias gs='git status'
alias gc='git commit -m'
alias gca='git commit --amend --no-edit'
alias gp='git push'
alias gmm='git merge master'
alias gcm='git checkout master'
alias gcp='git checkout production'
alias grep="ggrep"
alias pyclean="find . -name '*.py[co]' -delete"
alias gitclean='git branch | egrep -v "(master|\*)" | xargs git branch -D'
alias ytmusicdl="youtube-dl --extract-audio --audio-format mp3"
alias k="kubectl"

# KUBECTRL
export KUBECONFIG=~/.kube/config:~/.kube/production.kubeconfig:~/.kube/staging.kubeconfig

# GOLANG
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin:/usr/local/go/bin"


# VSCode. Path to "code ." wasn't working so just using this function. Eh whatever
code () {
if [[ $# = 0 ]]
then
    open -a "Visual Studio Code"
else
    [[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
    open -a "Visual Studio Code" --args "$F"
fi
}


### FOR SSH AGENT ###

SSH_ENV=$HOME/.ssh/environment

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
    echo succeeded
    chmod 600 ${SSH_ENV}
    . ${SSH_ENV} > /dev/null
    /usr/bin/ssh-add
}

if [ -f "${SSH_ENV}" ]; then
     . ${SSH_ENV} > /dev/null
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

### SSH AGENT END ###


### NVM ###

export NVM_DIR="/Users/christophepouliot/.nvm"

# Node version auto load per dir
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

### NVM END ###

