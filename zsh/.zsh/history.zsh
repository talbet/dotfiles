# Share history between sessions
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
HISTORY_IGNORE="(bg|fg|cd*|rm*|clear|ls|pwd|history|exit|make*|* --help)"

setopt share_history
setopt inc_append_history
setopt hist_ignore_all_dups
setopt extended_history
setopt hist_ignore_space