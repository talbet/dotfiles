# Automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# paths
path=(
  $home/bin
  /usr/local/bin
  /usr/local/opt/coreutils/libexec/gnubin
  /usr/local/opt/moreutils/libexec/gnubin
  /usr/local/opt/findutils/libexec/gnubin
  $HOME/.rbenv/bin
  $path
)

# preferred editor for local and remote sessions
export EDITOR=vim
export VISUAL=vim

# set language
export LANG=en_AU.UTF-8