aws_vault_prompt() {
    if [[ -n "$AWS_VAULT" ]]; then
        echo "($AWS_VAULT) "
    fi
}

PS1='\w $(aws_vault_prompt)^ '

title() {
  _title="$1"
  PROMPT_COMMAND='printf "\033]0;%s\007" "$_title"'
}

export PATH="$HOME/.local/share/${USER}/bin:$PATH"
export PATH="$HOME/.local/share/dotfiles/bin:$PATH"
export PATH=$PATH:/$HOME/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH="./node_modules/.bin:$PATH"

export EDITOR=nvim

export GONOPROXY=$CONF_GNOPROXY
export GONOSUMDB=$CONF_GONOSUMDB
export GOPRIVATE=$CONF_GOPRIVATE
export NVIM_GOPLS_LOCAL=$CONF_NVIM_GOPLS_LOCAL

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias g='git'
alias n='nerdctl'
alias d='docker'
alias k='kubectl'
alias tf='terraform'
alias gdalb='git branch | grep -v "master" | xargs git branch -D'
alias ports='sudo lsof -P -i TCP -s TCP:LISTEN'

# `source_env .env`
source_env() {
  # export $(echo $(cat $1 | sed 's/#.*//g'| xargs) | envsubst)
  export $(echo $(cat $1 | sed 's/#.*//g'| xargs) | envsubst)
  set -a # automatically export all variables
  source $1
  set +a
}

if [ -f ~/.bash_aws ]; then
  . ~/.bash_aws
fi

FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

if [ -f ~/.bash_aws ]; then
  . ~/.bash_aws
fi

if [ -f ~/.bash_k8s ]; then
  . ~/.bash_k8s
fi

if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi
