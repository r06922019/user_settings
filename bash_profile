parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="\[\e[94;1m\]\u\[\e[31;1m\]@\[\e[33;1m\]\h\[\e[36;1m\] \A \[\e[31m\]\$PWD \[\e[32m\]\$(parse_git_branch)\[\e[0m\]\n\$ "

alias ls="ls --color=auto"
alias grep="grep -n --color=auto" # n for line number
alias du_sh_hidden="du -sh .[^.]*" # calculates sum of hidden files, or du -hs $(ls -A)

export JAVA_HOME=/usr/local/opt/openjdk 
# after 
# brew tap homebrew/cask-versions && brew tap homebrew/cask && brew install java

# this depends on the encoding but 
# https://alvinalexander.com/blog/post/linux-unix/how-remove-non-printable-ascii-characters-file-unix/
alias trim-garbage="tr -cd '\11\12\15\40-\176'"

tmux_run_in_detached() {
  set -x
  case "$#" in
    "2" )
      tmux new-session -d -s "$1" "$2"
      ;;
    "1" )
      tmux new-session -d -s "test" "$1"
      ;;
    *)
      echo "QQ"
      ;;
  esac
  set +x
}
repo-sync() {
  set -x
  if [[ $(git status --porcelain=v1 2>/dev/null | wc -l) -eq 0 ]]; then
    case "$#" in
      "1" )
        repo sync || (git remote update && git fetch origin && git reset --hard origin/${1})
        ;;
      *)
        repo sync || (git remote update && git fetch origin && git reset --hard origin/main)
        ;;
    esac
  else
    echo "Unstaged changes"
  fi
  set +x
}
