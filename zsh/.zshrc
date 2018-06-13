ZSH=~/.zsh
zmodload zsh/zprof
skip_global_compinit=1
export ZPLUG_HOME="${HOME}/.zplug"

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
    source $ZPLUG_HOME/init.zsh && zplug update --self
fi

# Load zplug
source $HOME/.zplug/init.zsh
autoload -U compinit && compinit -u -C -d "$ZPLUG_HOME/zcompdump"

# Let zplug manage zplug
zplug "zplug/zplug"

zplug "zsh-users/zsh-completions", depth:1
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3 # Should be loaded last.
zplug "zsh-users/zsh-syntax-highlighting", defer:3 # Should be loaded 2nd last.

zplug "supercrabtree/k"
zplug "rupa/z", use:z.sh
zplug "lukechilds/zsh-nvm"
# zplug "plugins/yarn", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh

# zplug "mreinhardt/sfz-prompt", as:theme
# zplug 'dracula/zsh', as:theme

# Install plugins if there are plugins that have not been installed
zplug check || zplug install
# Then, source plugins and add commands to $PATH
zplug load

if zplug check "zsh-users/zsh-history-substring-search"; then
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi

# Load extra configs
for config (~/.zsh/*.zsh) source $config

# Load theme
ZSH_THEME=custom
source "${ZSH}/theme/${ZSH_THEME}.zsh"

# rbenv
eval "$(rbenv init -)"

# thefuck setup
eval $(thefuck --alias)

##
# Various
##
setopt auto_cd                  # if command is a path, cd into it
setopt auto_remove_slash        # self explicit
setopt chase_links              # resolve symlinks
setopt correct                  # try to correct spelling of commands
setopt extended_glob            # activate complex pattern globbing
setopt glob_dots                # include dotfiles in globbing
setopt print_exit_value         # print return value if non-zero
unsetopt beep                   # no bell on error
unsetopt bg_nice                # no lower prio for background jobs
unsetopt clobber                # must use >| to truncate existing files
unsetopt hist_beep              # no bell on error in history
unsetopt hup                    # no hup signal at shell exit
unsetopt ignore_eof             # do not exit on end-of-file
unsetopt list_beep              # no bell on ambiguous completion
unsetopt rm_star_silent         # ask for confirmation for `rm *' or `rm path/*'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
