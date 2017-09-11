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

# zplug 'denysdovhan/spaceship-zsh-theme', as:theme
# zplug 'sfabrizio/ozono-zsh-theme', as:theme
# zplug 'dracula/zsh', as:theme
# zplug "eendroroy/alien"

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