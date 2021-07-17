autoload -Uz compinit
compinit

export PATH=$HOME/bin:$PATH
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$PATH:/Users/robotx/Library/Python/3.9/bin"
export PATH="$PATH:/Applications/MacVim.app/Contents/bin"
export PATH="$PATH:node_modules/.bin"
export PATH=$HOME/.fnm:$PATH

export GIT_EDITOR=vim
PROMPT='%2~ %# '

# autoload -Uz compinit && compinit
eval "$(fnm env)"

bindkey -v

source_if_exists () {
  [[ -f "$1" ]] && source "$1"
}

source_if_exists ~/.other

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
alias c='bin/cli'
alias g='git'
alias nr='npm run'
alias gdalb='git branch | grep -v "master" | xargs git branch -D'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /usr/local/opt/asdf/asdf.sh

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
