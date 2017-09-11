#git values
ZSH_THEME_GIT_PROMPT_PREFIX="(\uf418 "
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[yellow]%}+"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg_bold[green]%} "

#theme values
CUSTOM_THEME_NVM_SYMBOL="%{$fg_bold[green]%}⬢"
CUSTOM_THEME_NVM_PREFIX="%{$fg_bold[green]%}(%{$reset_color%}"
CUSTOM_THEME_NVM_SUFFIX="%{$fg_bold[green]%})%{$reset_color%}"

#final prompt separator:
CUSTOM_THEME_PROMPT_FINAL="%{$FG[063]%}"'\uf0da'"%{$reset_color%}"

# CUSTOM_THEME_OK=$'🦉 '
# CUSTOM_THEME_CRASH='💥 '
CUSTOM_THEME_OK=$'>'
CUSTOM_THEME_CRASH='*'
CUSTOM_THEME_JS_ICON="%{$fg[yellow]%}"$'\ue74e'"%{$reset_color%}"

#ok or wrong command
local ret_status="%(?:%{$fg_bold[grey]%}$CUSTOM_THEME_OK:%{$fg_bold[red]%}$CUSTOM_THEME_CRASH)"

# Check if the current directory is in a Git repository.
# USAGE:
#   _is_git
_is_git() {
  command git rev-parse --is-inside-work-tree &>/dev/null
}

#show nvm current version only when is necessary
print_nvm_info() {
    if command git >/dev/null 2>/dev/null; then
        return
    fi
    local mainPathPackageJson=$(git rev-parse --show-toplevel 2>/dev/null)"/package.json"
    if [[ -f $mainPathPackageJson ]]; then
        local result=""
        result+=$CUSTOM_THEME_NVM_SYMBOL" "
        result+=$CUSTOM_THEME_NVM_PREFIX
        result+=%{$fg[yellow]%}$(nvm current)
        result+=$CUSTOM_THEME_NVM_SUFFIX
        echo "$result"
    fi
}

# Git: branch/detached head, dirty status
prompt_git_status() {
  _is_git || return

  local ref dirty mode repo_path

  repo_path=$(git rev-parse --git-dir 2>/dev/null)
  dirty=$(parse_git_dirty)
  ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
  if [[ -n $dirty ]]; then
    echo -n "%{$fg_bold[red]%}"
  else
    echo -n "%{$fg_bold[cyan]%}"
  fi

  if [[ -e "${repo_path}/BISECT_LOG" ]]; then
    mode=" <B>"
  elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
    mode=" >M<"
  elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
    mode=" >R>"
  fi

  setopt promptsubst
  autoload -Uz vcs_info

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' get-revision true
  zstyle ':vcs_info:*' check-for-changes true
  zstyle ':vcs_info:*' stagedstr "%{$FG[154]%}"'\uf103 '
  zstyle ':vcs_info:*' unstagedstr "%{$FG[197]%}"'\uf0c3 '
  zstyle ':vcs_info:*' formats ' %u%c'
  zstyle ':vcs_info:*' actionformats ' %u%c'
  vcs_info
  echo -n " ${vcs_info_msg_0_%%}${mode}"
  echo -n "%{$reset_color%}"
}

git_prompt_info() {
  _is_git || return
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# # Show all 256 colors with color number
# # Pass custom test, or defaults to Test
# spectrum_ls() {
#   txt="The quick brown fox jumps over the lazy dog"
#   if (( $# > 0)); then
#     txt=$1
#   fi
#   for code in {000..255}; do
#     print -P -- "$code: %F{$code}$txt%f"
#   done
# }
# spectrum_ls

#Final prompt concat
function precmd {
  PROMPT=""
  PROMPT+="${ret_status}"
  PROMPT+=" %{$fg[cyan]%}%c%{$reset_color%}"
  PROMPT+="$(print_nvm_info)"
  PROMPT+="$(prompt_git_status)"
  PROMPT+="$(echo -n $CUSTOM_THEME_PROMPT_FINAL)"

  RPROMPT=""
  RPROMPT+="$(git_prompt_info)"
}