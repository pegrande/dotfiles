if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export PATH=$HOME/.bin:/usr/local/bin:/usr/local/bin/psql:$PATH
export PATH=$PATH\:/usr/local/sbin
export ANDROID_HOME="/Users/jeff/SDKs/android-sdk-macosx"
export WORKON_HOME=$HOME/.virtualenvs
export PIP_DOWNLOAD_CACHE=$HOME/.pip_download_cache
# source $(brew --prefix)/bin/virtualenvwrapper.sh
export EDITOR="vim"
export PATH=$PATH\:/usr/local/sbin

export GOPATH=$HOME/Developer/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$GOPATH/src/github.com/rumblemonkey/tools/mac

# Add grpc_cli to path
export PATH=$PATH\:~/Developer/tools/grpc/bins/opt

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
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM
  . `brew --prefix`/etc/bash_completion
fi

source ~/.bash/colors
source ~/.bash/aliases
source ~/.bash/rumble_alias

# git prompt goodnes
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=verbose

function git_color_icon() {
  local git_status="$(git status 2> /dev/null)"

  if [[ $git_status =~ "Untracked files" ]]; then
    echo -e ${COLOR_RED}‼️
  elif [[ $git_status =~ "Changes not staged for commit" ]]; then
    echo -e ${COLOR_RED}❗
  elif [[ $git_status =~ "Changes to be committed" ]]; then
    echo -e ${COLOR_YELLOW}👨🏾‍🚀
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e ${COLOR_GREEN}🚀
  elif [[ $git_status =~ "Your branch is behind" ]]; then
    echo -e ${COLOR_GREEN}🌎
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e ${COLOR_SOLAR_BLUE}⭐
  else
    echo -e ${COLOR_SOLAR_BLUE}🌙
  fi
}

function virtual_env() {
  name="${VIRTUAL_ENV##*/}"
  if [ ! -z $VIRTUAL_ENV ]; then
    #path=echo "$VIRTUAL_ENV" | sed "s/.*\///" | sed "s/\..*//"
    echo "${COLOR_YELLOW}($name)${COLOR_GRAY}-"
  fi
}

# Old Prompt
#PS1="\n${COLOR_RED}[ ${COLOR_BLUE}\w${COLOR_YELLOW}\$(__git_ps1 ' (%s)')${COLOR_RED} ]${COLOR_BLUE} --> ${COLOR_NONE} "
# Modified example
set_bash_prompt() {
#  PS1="\n${COLOR_GRAY}\[\016\]l\[\017\]-(${COLOR_BLUE}\w${COLOR_GRAY})->\n\[\016\]m\[\017\]- $(git_color_icon) ${COLOR_LIGHT_GREEN}\$(__git_ps1 ' [ %s ]' )${COLOR_GRAY} --> ${COLOR_NONE}"

  PS1="\n$(virtual_env)${COLOR_GREEN}(\w) $(git_color_icon) ${COLOR_GREEN}\$(__git_ps1 ' [ %s ]' )${COLOR_GREEN}\n-> ${COLOR_NONE}"
}

# Example Prompt
#PS1="\n\[\e[30;1m\]\[\016\]l\[\017\](\[\e[34;1m\]\u@\h\[\e[30;1m\])-(\[\e[34;1m\]\j\[\e[30;1m\])-(\[\e[34;1m\]\@ \d\[\e[30;1m\])->\[\e[30;1m\]\n\[\016\]m\[\017\]-(\[\[\e[32;1m\]\w\[\e[30;1m\])-(\[\e[32;1m\]\$(/bin/ls -1 | /usr/bin/wc -l | /usr/bin/sed 's: ::g') files, \$(/bin/ls -lah | /usr/bin/grep -m 1 total | /usr/bin/sed 's/total //')b\[\e[30;1m\])--> \[\e[0m\]"

PROMPT_COMMAND=set_bash_prompt

function name_tab() {
  echo -ne "\033]0;$1\007"
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# [[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

__git_complete qm _git_checkout
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

