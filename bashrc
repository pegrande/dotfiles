PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

#export CC=/usr/local/bin/gcc-4.9
#export CPP=/usr/local/bin/cpp-4.9
#export CXX=/usr/local/bin/g++-4.9

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

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

source ~/.bash/colors
source ~/.bash/aliases

# git prompt goodnes
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=verbose

# Old Prompt
#PS1="\n${COLOR_RED}[ ${COLOR_BLUE}\w${COLOR_YELLOW}\$(__git_ps1 ' (%s)')${COLOR_RED} ]${COLOR_BLUE} --> ${COLOR_NONE} "

# Modified example
PS1="\n${COLOR_GRAY}\[\016\]l\[\017\]-(${COLOR_BLUE}\w${COLOR_GRAY})->\n\[\016\]m\[\017\]-(\[\e[32;1m\]\$(/bin/ls -1 | /usr/bin/wc -l | /usr/bin/sed 's: ::g') files, \$(/bin/ls -lah | /usr/bin/grep -m 1 total | /usr/bin/sed 's/total //')b${COLOR_GRAY})${COLOR_LIGHT_GREEN}\$(__git_ps1 ' [ %s ]' )${COLOR_GRAY} --> \[\e[0m\]"

# Example Prompt
#PS1="\n\[\e[30;1m\]\[\016\]l\[\017\](\[\e[34;1m\]\u@\h\[\e[30;1m\])-(\[\e[34;1m\]\j\[\e[30;1m\])-(\[\e[34;1m\]\@ \d\[\e[30;1m\])->\[\e[30;1m\]\n\[\016\]m\[\017\]-(\[\[\e[32;1m\]\w\[\e[30;1m\])-(\[\e[32;1m\]\$(/bin/ls -1 | /usr/bin/wc -l | /usr/bin/sed 's: ::g') files, \$(/bin/ls -lah | /usr/bin/grep -m 1 total | /usr/bin/sed 's/total //')b\[\e[30;1m\])--> \[\e[0m\]"

function name_tab() {
  echo -ne "\033]0;$1\007"
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

__git_complete qm _git_checkout
