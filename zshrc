export ZSH="/Users/chrispouliot/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git pyenv python zsh-syntax-highlighting zsh-autosuggestions)

export PATH="/Users/chrispouliot/.pyenv/bin:$PATH"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval $(thefuck --alias fuck)

source $ZSH/oh-my-zsh.sh

alias ga='git add -A && git status'
alias gs='git status'
alias gc='git commit -m'
alias gca='git commit --amend --no-edit'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gmm='git merge master'
alias gcm='git checkout master'
alias gcp='git checkout production'
alias glog="git log --graph --decorate --abbrev-commit"
alias grep="ggrep"
alias pyclean="find . -name '*.py[co]' -delete"
alias gitclean='git branch | egrep -v "(master|\*)" | xargs git branch -D'
alias ytmusicdl="youtube-dl --extract-audio --audio-format mp3"
alias k="kubectl"
alias cat="bat"
alias tmp="tmux attach -t personal"
alias tmw="tmux attach -t work"
alias vim="nvim"

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
