#█▓▒░ aliases
alias cp='cp -iv'
alias mv='mv -iv'
alias rmdir='rmdir -v'
alias ln='ln -v'
alias ls="ls -hFG"
alias ll="ls -lahF"
alias "cd.."="cd ../"
alias up="cd ../"
alias tree='tree -CAFa -I "CVS|*.*.package|.svn|.git|.hg|node_modules|bower_components" --dirsfirst'
alias mkdir="mkdir -pv" # create nested directories and do it verbose

# Ruby
alias be="bundle exec"
alias rake='noglob rake' # auto escape square brackets

alias 'dus=du -sckx * | sort -nr' #directories sorted by size
alias 'wordy=wc -w * | sort | tail -n10' # sort files in current directory by the number of words they contain
alias 'filecount=find . -type f | wc -l' # number of files (not directories)

#█▓▒░ z style nav
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection

alias weather='noglob curl wttr.in/Melbourne?nFm' # show weather (https://wttr.in/:help)

#█▓▒░ disable autocorrect
alias yarn='nocorrect yarn'

if [[ $IS_MAC -eq 1 ]]; then
    alias ql='qlmanage -p 2>/dev/null' # OS X Quick Look
    alias oo='open .' # open current directory in OS X Finder
    alias 'today=calendar -A 0 -f /usr/share/calendar/calendar.mark | sort'
    alias 'mailsize=du -hs ~/Library/mail'
    alias 'smart=diskutil info disk0 | grep SMART' # display SMART status of hard drive
    # Hall of the Mountain King
    alias cello='say -v cellos "di di di di di di di di di di di di di di di di di di di di di di di di di di"'
    # alias to show all Mac App store apps
    alias apps='mdfind "kMDItemAppStoreHasReceipt=1"'
    # reset Address Book permissions in Mountain Lion (and later presumably)
    alias resetaddressbook='tccutil reset AddressBook'
    # refresh brew by upgrading all outdated casks
    alias refreshbrew='brew outdated | while read cask; do brew upgrade $cask; done'
    # rebuild Launch Services to remove duplicate entries on Open With menu
    alias rebuildopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.fram ework/Support/lsregister -kill -r -domain local -domain system -domain user'
    # flush DNS cache on macOS Mojave
    alias flushcache='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
fi

alias blankfirefox='firefox --new-instance --profile $(mktemp -d)'
alias blankchrome='chromium --user-data-dir $(mktemp -d)'


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

# cheatsheets from community driven man pages
function cheat() {
  curl cht.sh/$1
}

# burrow into current directory structure
function fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) && cd "$dir"
}

# colorized cat
function c() {
  for file in "$@"
  do
    pygmentize -O style=sourcerer -f console256 -g "$file"
  done
}

alias dd='echo "no dd command available"' # disable dd command

# open vs code in current dir
alias code='code .'
alias cide='code .'

# Comic-dl cli
alias comic_dl="docker run -it --rm -v $(pwd):/directory -w /directory comic-dl:py3.6.5-stretch comic_dl -dd /directory"