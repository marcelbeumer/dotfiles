autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

setopt autocd extendedglob nomatch menucomplete globcomplete interactive_comments

ulimit -n 10240
bindkey -v
export KEYTIMEOUT=1

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
zstyle ':completion:*' menu select

PROMPT='%2~ %# '

export EDITOR="/usr/local/bin/nvim"
export PNPM_HOME="/Users/laby/Library/pnpm"
export FZF_DEFAULT_OPTS='
  --color bg+:#292e42,bg:#1a1b26,spinner:#bb9af7,hl:#565f89,fg:#c0caf5,header:#565f89,info:#7dcfff,pointer:#bb9af7,marker:#7dcfff,fg+:#c0caf5,preview-bg:#16161e,prompt:#bb9af7,hl+:#bb9af7
'

export PATH=$HOME/bin:$PATH
export PATH=$HOME/.fnm:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$HOME/.pyenv/shims:$PATH"
export PATH="$PNPM_HOME:$PATH"

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
alias vl='nvim +SessionLoad'
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
alias ChromeUnthrottled="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --disable-background-timer-throttling"
alias icat="kitty +kitten icat"

# `source_env .env`
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

k8s_kubectl_completion()
{
  source <(kubectl completion zsh)
  # complete -F __start_kubectl k
}

compdef k8s_kubectl_completion k
compdef k8s_kubectl_completion kubectl

complete -o nospace -C /opt/homebrew/bin/terraform terraform
eval "$(aws-vault --completion-script-zsh)"

eval "$(fnm env)"
export PATH="./node_modules/.bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source $HOME/.cargo/env
eval "$(pyenv init -)"

if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
