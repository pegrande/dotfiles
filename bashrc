PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export PATH=$HOME/.bin:/usr/local/bin:/usr/local/bin/psql:$PATH
export PATH=$PATH\:/usr/local/sbin
export PATH=$PATH\:~/SDKs/android-sdk-macosx/tools:~/SDKs/android-sdk-macosx/platform-tools
export ANDROID_HOME="/Users/jeff/SDKs/android-sdk-macosx"
export EDITOR="vim"

function current_git_branch {
  git branch | grep ^* | sed s/*\ //
}

function current {
  if [ $1 ] && [ -z $2 ]
  then
    export C_BRANCH=$1
    echo "Current Branch set to $C_BRANCH"
    return 0
  else
    echo "Current Branch set to $C_BRANCH"
    return 1
  fi
}

function coc {
  git checkout $C_BRANCH
}

alias psqlstart="sudo sysctl -w kern.sysv.shmall=65536;sudo sysctl -w kern.sysv.shmmax=61751296;pg_ctl -D /usr/local/var/postgres start"
alias mysqlstart="mysql.server start"
alias redisstart="redis-server /usr/local/etc/redis.conf"
alias ls="ls -G"

alias graph="git log --graph --decorate --all"
alias grox="git rebase origin/\`current_git_branch\`"
alias grh="git reset --hard"
alias uncommit="git reset --soft HEAD^"
alias update="git remote update --prune"
alias gs="git status"
alias gb="git branch"
alias gbr="git branch -r"
alias com="git checkout master"
alias push="git push origin head"


alias bi="bundle install"
alias bakedb="bundle exec rake db:migrate db:test:prepare"
alias be="bundle exec"
alias beg="bundle exec guard"
alias speck="bundle exec rake spec verbose=true guard:jasmine"
alias rspeck="bundle exec rspec --format documentation"

alias console="if [ -f script/console ] ; then script/console; else script/rails console ; fi"
alias server="if [ -f script/server ] ; then script/server; else script/rails server ; fi"
alias mongrel="if [ -f script/server ] ; then script/server mongrel; else script/rails server mongrel; fi"

alias load=". ~/.bash_profile"
alias vim="mvim -v"
alias vimcolors="perl ~/.vim/.vim-256color.pl"

alias tmuxg="tmux new-session -t 0"

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

source ~/.bash/colors

# git prompt goodnes
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=verbose
PS1="\n${COLOR_RED}[ ${COLOR_BLUE}\w${COLOR_YELLOW}\$(__git_ps1 ' (%s)')${COLOR_RED} ]${COLOR_BLUE} --> ${COLOR_NONE} "

function name_tab() {
  echo -ne "\033]0;$1\007"
}

#PS1="\n\[\e[30;1m\]\[\016\]l\[\017\](\[\e[34;1m\]\u@\h\[\e[30;1m\])-(\[\e[34;1m\]\j\[\e[30;1m\])-(\[\e[34;1m\]\@ \d\[\e[30;1m\])->\[\e[30;1m\]\n\[\016\]m\[\017\]-(\[\[\e[32;1m\]\w\[\e[30;1m\])-(\[\e[32;1m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\e[30;1m\])--> \[\e[0m\]"

### source ~/.bash/aliases

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

__git_complete qm _git_checkout
function qm() {
  rm .merging
  rm .merge
  git reset --hard
  git checkout "$1"
}
