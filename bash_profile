if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
[[ -s /Users/jeff/.nvm/nvm.sh ]] && . /Users/jeff/.nvm/nvm.sh # This loads NVM

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
