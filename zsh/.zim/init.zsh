zimfw() { source /Users/talbet/dotfiles/zsh/.zim/zimfw.zsh "${@}" }
fpath=(/Users/talbet/dotfiles/zsh/.zim/modules/git/functions /Users/talbet/dotfiles/zsh/.zim/modules/utility/functions /Users/talbet/dotfiles/zsh/.zim/modules/fasd/functions /Users/talbet/dotfiles/zsh/.zim/modules/git-info/functions ${fpath})
autoload -Uz git-alias-lookup git-branch-current git-branch-delete-interactive git-dir git-ignore-add git-root git-stash-clear-interactive git-stash-recover git-submodule-move git-submodule-remove mkcd fasd coalesce git-action git-info
source /Users/talbet/dotfiles/zsh/.zim/modules/environment/init.zsh
source /Users/talbet/dotfiles/zsh/.zim/modules/git/init.zsh
source /Users/talbet/dotfiles/zsh/.zim/modules/input/init.zsh
source /Users/talbet/dotfiles/zsh/.zim/modules/termtitle/init.zsh
source /Users/talbet/dotfiles/zsh/.zim/modules/utility/init.zsh
source /Users/talbet/dotfiles/zsh/.zim/modules/fasd/init.zsh
source /Users/talbet/dotfiles/zsh/.zim/modules/powerlevel10k/powerlevel10k.zsh-theme
source /Users/talbet/dotfiles/zsh/.zim/modules/zsh-completions/zsh-completions.plugin.zsh
source /Users/talbet/dotfiles/zsh/.zim/modules/completion/init.zsh
source /Users/talbet/dotfiles/zsh/.zim/modules/zsh-autosuggestions/zsh-autosuggestions.zsh
source /Users/talbet/dotfiles/zsh/.zim/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /Users/talbet/dotfiles/zsh/.zim/modules/zsh-history-substring-search/zsh-history-substring-search.zsh