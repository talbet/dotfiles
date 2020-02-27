# Automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# paths
path=(
  $home/bin
  $home/.local/bin
  /usr/local/bin
  /usr/local/opt/coreutils/libexec/gnubin
  /usr/local/opt/moreutils/libexec/gnubin
  /usr/local/opt/findutils/libexec/gnubin
  $HOME/dotfiles/scripts
  $HOME/.rbenv/bin
  $HOME/.rbenv/shims
  $path
)

# preferred editor for local and remote sessions
export EDITOR=vim
export VISUAL=vim

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
# bindkey -v

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# set language
export LANG=en_AU.UTF-8