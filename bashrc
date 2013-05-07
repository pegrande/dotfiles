
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export PATH=/usr/local/bin:/usr/local/bin/psql:$PATH
export PATH=$PATH\:/usr/local/sbin
export PATH=$PATH\:~/SDKs/android-sdk-macosx/tools:~/SDKs/android-sdk-macosx/platform-tools
export ANDROID_HOME="/Users/jeff/SDKs/android-sdk-macosx"

function current_git_branch {
  git branch | grep ^* | sed s/*\ //
}


alias psqlstart="sudo sysctl -w kern.sysv.shmall=65536;sudo sysctl -w kern.sysv.shmmax=61751296;pg_ctl -D /usr/local/var/postgres start"

alias graph="git log --graph --decorate --all"
alias grox="git rebase origin/\`current_git_branch\`"
alias log="git log"
alias uncommit="git reset --soft HEAD^"
alias update="git remote update --prune"
alias status="git status"
alias branch="git branch"
alias remote="git branch -r"
alias master="git checkout master"

alias mi="script/mergeq integration"
alias mdev="script/mergeq develop"
alias mc="script/mergeq --continue"
alias pf="script/push"

alias bi="bundle install --standalone --binstubs bundle/bin"
alias bakedb="bundle exec rake db:migrate db:test:prepare"
alias be="bundle exec"
alias beg="bundle exec guard"
alias speck="bundle exec rake spec verbose=true guard:jasmine"
alias rspeck="bundle exec rspec --format documentation"

alias z='`[ -e .zeus.sock ] && echo zeus || echo SAD: Zeus is not running 1>&2`'
alias zr='`[ -e .zeus.sock ] && echo zeus || echo rails`'
alias zbe='`[ -e .zeus.sock ] && echo zeus || echo bundle exec`'
alias console="if [ -f script/console ] ; then script/console; else script/rails console ; fi"
alias server="if [ -f script/server ] ; then script/server; else script/rails server ; fi"
alias mongrel="if [ -f script/server ] ; then script/server mongrel; else script/rails server mongrel; fi"

alias zdb="zbe rake db:migrate db:test:prepare"
alias zake="zbe rake"

alias load=". ~/.bash_profile"
alias vim="mvim -v"
alias vimcolors="perl ~/.vim/.vim-256color.pl"

alias tmuxg="tmux new-session -t"

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

if [ -f `brew --prefix`/etc/autojump ]; then
  . `brew --prefix`/etc/autojump
fi

source ~/.bash/colors

# git prompt goodnes
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=verbose
PS1="\n${COLOR_SOLAR_RED}[ ${COLOR_SOLAR_BLUE}\w${COLOR_SOLAR_GREEN}\$(__git_ps1 ' (%s)')${COLOR_SOLAR_RED} ]${COLOR_LIGHT_BLUE} --> ${COLOR_NONE} "

function name_tab() {
  echo -ne "\033]0;$1\007"
}

#PS1="\n\[\e[30;1m\]\[\016\]l\[\017\](\[\e[34;1m\]\u@\h\[\e[30;1m\])-(\[\e[34;1m\]\j\[\e[30;1m\])-(\[\e[34;1m\]\@ \d\[\e[30;1m\])->\[\e[30;1m\]\n\[\016\]m\[\017\]-(\[\[\e[32;1m\]\w\[\e[30;1m\])-(\[\e[32;1m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\e[30;1m\])--> \[\e[0m\]"

### source ~/.bash/aliases
