
# MacPorts Installer addition on 2011-09-30_at_23:03:32: adding an appropriate PATH variable for use with MacPorts.
export PATH=~/Development/bin:/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

export PATH=$PATH:/usr/local/mysql/bin

export CLICOLOR=true
export LSCOLORS=exfxcxdxbxegedabagacad
export GREP_OPTIONS='--color=auto'
export WORKON_HOME=~/Development/Envs
export REPOS=$HOME/Development/Clones
export DOMAIN="local.goeiejongens.nl"
export HTTPDCONF="/etc/apache2/httpd.conf"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

alias tree="find . -type d -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias vi="mvim -v"
alias vim="mvim"

alias hgbm="hg pull && hg merge  && hg ci -m 'Branch merge' && hg push"

alias vimdjango="cd \$VIRTUAL_ENV/lib/python2.6/site-packages/django; vim"
alias vimfein="cd \$VIRTUAL_ENV/lib/python2.6/site-packages/feincms; vim"
alias createdbloadcms="create_db.sh && load_cms.sh"

alias a2start="sudo apachectl start"
alias a2restart="sudo apachectl restart"
alias a2stop="sudo apachectl stop"
alias a2="a2restart"
alias vimhttpd="vim $HTTPDCONF"
alias mysql_config="mysql_config5"
alias mysqldump="mysqldump5"

# BuzzCapture
alias buzztunnel="cd ~/Documents/Projects/BuzzCapture/scripts;./tunnelVBuzz.sh"

mkdir -p $WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh

source $REPOS/gj-lib/bin/profile
unalias ls
unalias grep

export DJANGO_DATABASE_TYPE=sqlite
set -o vi

export NODE_PATH=/opt/local/lib:$NODE_PATH
export NODE_PATH=/opt/local/lib/node_modules:$NODE_PATH
export NODE_PATH=/usr/local/lib/jsctags/:$NODE_PATH

hgfind ()
{
    _verify_project_root || return 1;
    TODO="TO.{0,1}DO";
    XXX="XXX";
    FIXME="FIXME";
    pattern="$1";
    _IFS=$IFS;
    IFS="
";
    for file in `grep --extended-regexp $pattern --files-with-matches --recursive $PROJECT_ROOT/*`;
    do
        hg blame --user --file --changeset --line-number $file | sed 's/^ *//' | egrep $pattern;
    done;
    IFS=$_IFS
}

