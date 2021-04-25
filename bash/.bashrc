alias v=vim
alias g=git
alias l="ls -G"
alias ll="ls -laG"
alias d="docker"
alias tree="pwd;find . | sort | sed '1d;s/^\.//;s/\/\([^/]*\)$/|--\1/;s/\/[^/|]*/|  /g'"

#for mac 
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  source $(brew --prefix)/etc/bash_completion
fi

# use git-completion
source ~/.git-completion.bash