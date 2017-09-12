#█▓▒░ aliases
alias xyzzy="echo nothing happens"
alias ls="ls -hFG"
alias ll="ls -lahF"
alias "cd.."="cd ../"
alias up="cd ../"
alias k="k -h"
alias be="bundle exec"
alias rake='noglob rake' # auto escape square brackets
alias tree='tree -CAFa -I "CVS|*.*.package|.svn|.git|.hg|node_modules|bower_components" --dirsfirst'

# alias rmrf="rm -rf"
# alias psef="ps -ef"
# alias mkdir="mkdir -p"
# alias cp="cp -r"
# alias scp="scp -r"
# alias xsel="xsel -b"
# alias v="vim"
# alias vi="vim"
# alias emacs="vim"
# alias git="hub"
# alias g="hub"
# alias ga="git add"
# alias gc="git commit -m"
# alias gs="git status"
# alias gd="git diff"
# alias gf="git fetch"
# alias gm="git merge"
# alias gr="git rebase"
# alias gp="git push"
# alias gu="git unstage"
# alias gg="git graph"
# alias gco="git checkout"
# alias gcs="git commit -S -m"
# alias gpr="hub pull-request"
# alias ag="ag --color --color-line-number '0;35' --color-match '46;30' --color-path '4;36'"
# alias rock="ncmpcpp"

# colorized cat
function c() {
  for file in "$@"
  do
    pygmentize -O style=sourcerer -f console256 -g "$file"
  done
}

