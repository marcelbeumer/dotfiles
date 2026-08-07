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
export PATH="$HOME/.local/share/rx/bin:$PATH"
export PATH=$PATH:/$HOME/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
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

# open like macOS
open() { setsid xdg-open "$@" & }

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

# --- zmx-last: toggle to previous session (tmux prefix-l style, global MRU) ---
# State: ${XDG_STATE_HOME:-~/.local/state}/zmx/{last,current}

zmx() {
  set +u
  local state_dir old_current target
  state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/zmx"

  if [[ ( "$1" == "attach" || "$1" == "a" ) && $# -ge 2 ]]; then
    target="$2"
    old_current=""
    [[ -f "$state_dir/current" ]] && old_current=$(<"$state_dir/current")

    # Update the pair only for a real switch:
    #   - not attaching to the session we're already in (ZMX_SESSION set & == target)
    #   - not attaching to what's already the global most-recent (target == old_current)
    if { [[ -z "$ZMX_SESSION" ]] || [[ "$target" != "$ZMX_SESSION" ]]; } && [[ "$target" != "$old_current" ]]; then
      mkdir -p "$state_dir"
      printf '%s\n' "$old_current" > "$state_dir/last"
      printf '%s\n' "$target"    > "$state_dir/current"
    fi
  fi

  command zmx "$@"
}

zmx-last() {
  local state_dir last
  state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/zmx"

  [[ -f "$state_dir/last" ]] || { echo "zmx-last: no previous session" >&2; return 1; }
  last=$(<"$state_dir/last")
  [[ -n "$last" ]] || { echo "zmx-last: no previous session" >&2; return 1; }

  if ! zmx list 2>/dev/null | awk -F'\t' '{sub(/.*name=/,"",$1)} $1==c{f=1} END{exit !f}' c="$last"; then
    echo "zmx-last: previous session '$last' no longer exists" >&2
    : > "$state_dir/last"   # clear last, keep current so MRU survives
    return 1
  fi

  zmx a "$last"   # flows through zmx() → flips the pair → toggle
}

export -f zmx
export -f zmx-last

alias z=zmx
alias zl=zmx-last
alias z=zmx

if [[ -n $ZMX_SESSION ]]; then
  export PS1="[$ZMX_SESSION] ${PS1}"
fi

