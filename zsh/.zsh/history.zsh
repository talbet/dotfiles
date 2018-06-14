# Share history between sessions
HISTFILE=~/.zhistory            # where to store zsh config
HISTSIZE=10000                  # big history
SAVEHIST=10000                  # big history
HISTORY_IGNORE="(bg|fg|cd*|rm*|clear|ls|pwd|history|exit|make*|* --help)"
setopt append_history           # append
setopt hist_ignore_all_dups     # no duplicate
unsetopt hist_ignore_space      # ignore space prefixed commands
setopt hist_reduce_blanks       # trim blanks
setopt hist_verify              # show before executing history commands
setopt share_history            # share hist between sessions
setopt bang_hist                # !keyword
setopt hist_ignore_dups         # don't write duplicates to history
setopt extended_history