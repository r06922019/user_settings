parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="\[\e[94;1m\]\u\[\e[31;1m\]@\[\e[33;1m\]\h\[\e[36;1m\] \A \[\e[31m\]\$PWD \[\e[32m\]\$(parse_git_branch)\[\e[0m\]\n\$ "

alias ls="ls --color=auto"
alias grep="grep -n --color=auto" # n for line number

export JAVA_HOME=/usr/local/opt/openjdk 
# after 
# brew tap homebrew/cask-versions && brew tap homebrew/cask && brew install java
