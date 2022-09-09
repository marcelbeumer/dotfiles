autoload -Uz compinit
compinit

# autoload -Uz compinit && compinit
eval "$(fnm env)"

export PATH="node_modules/.bin:$PATH"
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.fnm:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$PATH:/Users/robotx/Library/Python/3.9/bin"
export PATH="$PATH:/Applications/MacVim.app/Contents/bin"
export PATH="$HOME/.pyenv/shims:$PATH"
# Created by `pipx` on 2022-02-01 12:39:42
export PATH="$PATH:/Users/robotx/.local/bin"

export EDITOR="/usr/local/bin/nvim"
export GIT_EDITOR=vim

PROMPT='%2~ %# '

bindkey -v

source_if_exists () {
  [[ -f "$1" ]] && source "$1"
}

source_if_exists ~/.other

alias ChromeUnthrottled="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --disable-background-timer-throttling"

# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/common-aliases/common-aliases.plugin.zsh
# ls, the common ones I use a lot shortened for rapid fire usage
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'

# my aliases
alias v='nvim'
alias d='docker'
alias g='git'
alias gg='lazygit'
alias ctx='kubectx'
alias ns='kubens'
alias nr='npm run'
alias gdalb='git branch | grep -v "master" | xargs git branch -D'
alias ports='sudo lsof -P -i TCP -s TCP:LISTEN'
alias psauxkill="awk '{print \$2}' | xargs -I {} kill -9 {}"
alias serve="python -m http.server"
alias title="kitty @ set-tab-title"

source_env() {
  set -a
  source $1
  set +a
}

# function so I can use it in sleepwatch
k() { kubectl "${@}" }

# `rr k get po -A`
rr() {
  while true; do clear; "${@}"; sleep 2; done
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# source /usr/local/opt/asdf/asdf.sh

source $HOME/.cargo/env

###-begin-cli-completions-###
#
# yargs command completion script
#
# Installation: bin/cli completion >> ~/.zshrc
#    or bin/cli completion >> ~/.zsh_profile on OSX.
#
_cli_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" bin/cli --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _cli_yargs_completions cli
compdef _cli_yargs_completions c
###-end-cli-completions-###

k8s_kubectl_completion()
{
  source <(kubectl completion zsh)
  # complete -F __start_kubectl k
}

compdef k8s_kubectl_completion k
compdef k8s_kubectl_completion kubectl

k8s_minikube_docker()
{
  eval $(minikube -p minikube docker-env)
}


eval "$(pyenv init -)"

ulimit -n 10240

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# pnpm
export PNPM_HOME="/Users/laby/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
