function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function prompt {
  local RED="\[\033[0;31m\]"
  local CHAR="♥"

  # bash profile:
  export PS1="┌─\[\e]2;\u@\h\a[\[\e[34;47m\]\t\[\e[0m\]]$RED\$(parse_git_branch) \[\e[01;32m\]\w\[\e[0m\]\n└─\[\e[0;31m\]$CHAR \[\e[0m\]"
  export PS2='> '
  export PS4='+ '
}

prompt

# Flatiron Halloween Bash:
# http://xta.github.io/HalloweenBash/

# Environment Variables
# NODE_PATH
export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"

# PYTHON_SHARE
export PYTHON_SHARE='/usr/local/share/python'

# Configurations

# GIT_MERGE_AUTO_EDIT
# configures git to not require a message when merging.
export GIT_MERGE_AUTOEDIT='no'

# Editors
export VISUAL="subl -w"
export SVN_EDITOR="subl -w"
export GIT_EDITOR="subl -w"
export EDITOR="subl -w"

# Paths
export USR_PATHS="/usr/local:/usr/local/bin:/usr/local/sbin:/usr/bin"
export PATH="$USR_PATHS:$PATH"
# Add bin from dot-files repository, assuming the repository is in ~/Development.
export PATH="${PATH}:${HOME}/Development/dot-files/bin"
# Helpful Functions

# USE: desktop
#      desktop subfolder
function desktop {
  cd /Users/$USER/Desktop/$@
}

# A function to easily grep for a matching process
# USE: psg postgres
function psg {
  FIRST=`echo $1 | sed -e 's/^\(.\).*/\1/'`
  REST=`echo $1 | sed -e 's/^.\(.*\)/\1/'`
  ps aux | grep "[$FIRST]$REST"
}

# A function to extract correctly any archive based on extension
# USE: extract imazip.zip
#      extract imatar.tar
function extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)  tar xjf $1      ;;
      *.tar.gz)   tar xzf $1      ;;
      *.bz2)      bunzip2 $1      ;;
      *.rar)      rar x $1        ;;
      *.gz)       gunzip $1       ;;
      *.tar)      tar xf $1       ;;
      *.tbz2)     tar xjf $1      ;;
      *.tgz)      tar xzf $1      ;;
      *.zip)      unzip $1        ;;
      *.Z)        uncompress $1   ;;
      *)          echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Aliases
# =====================
# LS
alias l='ls -lah'

# Git
alias gst="git status"
alias gd="git diff | mate"
alias gc="git commit -v"
alias gca="git commit -v -a"
alias gcam="git commit -a -m"
alias gb="git branch"
alias gba="git branch -a"
alias gpr="git pull --rebase"
alias gbr="git branch"
alias gco="git checkout"
alias gcm="git commit -m"

# Raspberry Pi
alias rasp="ssh -p 2022 amanda@home.hioreanu.net"

# kill zombie rails server
#alias killrails="kill -INT $(cat tmp/pids/server.pid)"

# Case Insensitive Tab Completion
bind "set completion-ignore-case on"

# A function to run a specific cucumber feature test
# USE: cuke path-to-feature:line
function cuke () {
  if [ -n "$1" ]; then
    cucumber --require features $1
  else
    echo 'USE: cuke path-to-feature:line'
  fi
}

# Configurations and Plugins

# Git Bash Completion
# Will activate bash git completion if installed
# via homebrew
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# RVM
# Mandatory loading of RVM into the shell
# This must be the last line of bash_profile always
[[ -s "/Users/$USER/.rvm/scripts/rvm" ]] && source "/Users/$USER/.rvm/scripts/rvm"  # This loads RVM into a shell session.

# Load any local (non-version-controlled) configuration.
[[ -f "${HOME}/.bash-local" ]] && source "${HOME}/.bash-local"
