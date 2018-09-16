ZSH=~/.zsh

# zmodload zsh/zprof # uncomment for profiling
skip_global_compinit=1

# export ZPLUG_HOME="${HOME}/.zplug"

# # Check if zplug is installed
# if [[ ! -d ~/.zplug ]]; then
#     git clone https://github.com/zplug/zplug $ZPLUG_HOME
#     source $ZPLUG_HOME/init.zsh && zplug update --self
# fi

# # Load zplug
# source $HOME/.zplug/init.zsh
# autoload -U compinit && compinit -u -C -d "$ZPLUG_HOME/zcompdump"

# # Let zplug manage zplug
# zplug "zplug/zplug"

# zplug "zsh-users/zsh-completions", depth:1
# zplug "zsh-users/zsh-autosuggestions", defer:2
# zplug "zsh-users/zsh-history-substring-search", defer:3 # Should be loaded last.
# zplug "zsh-users/zsh-syntax-highlighting", defer:3 # Should be loaded 2nd last.

# zplug "supercrabtree/k"
# zplug "rupa/z", use:z.sh
# zplug "lukechilds/zsh-nvm"
# # zplug "plugins/yarn", from:oh-my-zsh
# zplug "lib/completion", from:oh-my-zsh

# # zplug "mreinhardt/sfz-prompt", as:theme
# # zplug 'dracula/zsh', as:theme

# # Install plugins if there are plugins that have not been installed
# zplug check || zplug install
# # Then, source plugins and add commands to $PATH
# zplug load

# if zplug check "zsh-users/zsh-history-substring-search"; then
# fi


# checks (stolen from zshuery)
if [[ $(uname) = 'Linux' ]]; then
    IS_LINUX=1
fi

if [[ $(uname) = 'Darwin' ]]; then
    IS_MAC=1
fi

if [[ -x `which brew` ]]; then
    HAS_BREW=1
fi

if [[ -x `which apt-get` ]]; then
    HAS_APT=1
fi

if [[ -x `which yum` ]]; then
    HAS_YUM=1
fi

# Load Antibody plugins
source "${ZSH}/plugins/plugins_init.zsh"

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# fix: (eval):setopt:3: no such option: NO_warnnestedvar
_comp_options="${_comp_options/NO_warnnestedvar/}"

# Load extra configs
for config (~/.zsh/*.zsh) source $config

# Load theme
ZSH_THEME=custom
source "${ZSH}/theme/${ZSH_THEME}.zsh"

# rbenv
eval "$(rbenv init -)"

# thefuck setup
# eval $(thefuck --alias)

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
