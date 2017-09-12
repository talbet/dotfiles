# name: iggy
#
# iggy is a super happy awesome Powerline-style, Git-aware prezto theme.
#
# You will probably need a Powerline-patched font for this to work:
#
#     https://powerline.readthedocs.org/en/latest/fontpatching.html
#
# I recommend picking one of these:
#
#     https://gist.github.com/qrush/1595572
#     https://github.com/Lokaltog/powerline-fonts
#
# You can set options in your .zshrc:
#
#   Default User: If default_user is set AND the current user differs
#   from the default_user, a user@host segment ist displayed locally:
#     default_user=some_user


# Checks a boolean variable for "true".
# Case insensitive: "1", "y", "yes", "t", "true", "o", and "on".
function is-true {
  [[ -n "$1" && "$1" == (1|[Yy]([Ee][Ss]|)|[Tt]([Rr][Uu][Ee]|)|[Oo]([Nn]|)) ]]
}

# Prints the first non-empty string in the arguments array.
function coalesce {
  for arg in $argv; do
    print "$arg"
    return 0
  done
  return 1
}


# Colors
__prompt_iggy_date_fg=238 # 444444
__prompt_iggy_med_red=160 # d70000
__prompt_iggy_slate_blue=24 # 005f87

__prompt_iggy_superuser_fg=28 # 008700
__prompt_iggy_nonzero_exit_fg=$__prompt_iggy_med_red
__prompt_iggy_bg_job_fg=$__prompt_iggy_slate_blue

__prompt_iggy_user_fg=166 # d75f00
__prompt_iggy_bg_user_user_fg=33 # 0087ff
__prompt_iggy_bg_user_at_fg=124 # af0000
__prompt_iggy_bg_user_hostname_fg=166 # d75f00
__prompt_iggy_user_bg=16 # 000000

__prompt_iggy_status_fg=16 # 000000
__prompt_iggy_status_bg=235 # 767676

__prompt_iggy_git_ok_bg=40 # 00d700
__prompt_iggy_git_ok_fg=16 # 000000

__prompt_iggy_cwd_not_writable_fg=174 # d78787
__prompt_iggy_cwd_not_writable_bg=$__prompt_iggy_med_red

__prompt_iggy_git_dirty_bg=red # 870000
__prompt_iggy_git_dirty_fg=white # d0d0d0

__prompt_iggy_git_stashed_fg=16 # 000000
__prompt_iggy_git_stashed_bg=178 # d7af00

__prompt_iggy_git_project_pwd_fg=241 # 626262
__prompt_iggy_git_project_pwd_bg=235 # 262626

__prompt_iggy_path_segment_writable_bg=32 # 0087d7
__prompt_iggy_path_segment_writable_fg=233 # 121212
__prompt_iggy_path_segment_writable_fgh=16 # 000000

__prompt_iggy_path_segment_not_writable_bg=52 # 5f0000
__prompt_iggy_path_segment_not_writable_fg=217 # ffafaf
__prompt_iggy_path_segment_not_writable_fgh=231 # ffffff

__prompt_iggy_prompt_sym_ok_fg=208 # ff8700
__prompt_iggy_prompt_sym_nonzero_fg=$__prompt_iggy_nonzero_exit_fg
__prompt_iggy_prompt_sym_superuser_fg=$__prompt_iggy_superuser_fg


# Glyphs
__prompt_iggy_branch_glyph="\u2B60" # ⭠
__prompt_iggy_ln_glyph="\u2B61" # ⭡
__prompt_iggy_padlock_glyph="\u2B62" # ⭢
__prompt_iggy_right_black_arrow_glyph="\u2B80" # ⮀
__prompt_iggy_right_arrow_glyph="\u2B81" # ⮁
__prompt_iggy_left_black_arrow_glyph="\u2B82" # ⮂
__prompt_iggy_left_arrow_glyph="\u2B83" # ⮃
__prompt_iggy_detached_glyph="\u27A6" # ➦
__prompt_iggy_nonzero_exit_glyph="\u2718" # ✘
__prompt_iggy_superuser_glyph="\u26A1" # ⚡
__prompt_iggy_bg_job_glyph="\ufe6a" # ﹪
__prompt_iggy_prompt_sym_glyph="\u276F" # ❯
__prompt_iggy_prompt_sym_glyph_alt="\u276E" # ❮


__prompt_iggy_segment_separator=$__prompt_iggy_right_black_arrow_glyph
__prompt_iggy_segment_separator_same_bg=$__prompt_iggy_right_arrow_glyph


start_time=$SECONDS
prompt_iggy_preexec() {
  start_time=$SECONDS
}

calc_elapsed_time() {
  if [[ $timer_result -ge 3600 ]]; then
    let "timer_hours = $timer_result / 3600"
    let "remainder = $timer_result % 3600"
    let "timer_minutes = $remainder / 60"
    let "timer_seconds = $remainder % 60"
    print -P "%B%F{red}> elapsed time ${timer_hours}h${timer_minutes}m${timer_seconds}s%b"
  elif [[ $timer_result -ge 60 ]]; then
    let "timer_minutes = $timer_result / 60"
    let "timer_seconds = $timer_result % 60"
    print -P "%B%F{yellow}> elapsed time ${timer_minutes}m${timer_seconds}s%b"
  elif [[ $timer_result -gt 10 ]]; then
    print -P "%B%F{green}> elapsed time ${timer_result}s%b"
  fi
}

prompt_iggy_precmd() {
  exit_status=$?
  setopt LOCAL_OPTIONS
  unsetopt XTRACE KSH_ARRAYS

  # Get Git repository information.
  __prompt_iggy_git_info

  timer_result=$(($SECONDS-$start_time))
  if [[ $timer_result -gt 10 ]]; then
    calc_elapsed_time
  fi
  start_time=$SECONDS
}

prompt_iggy_setup() {
  setopt LOCAL_OPTIONS
  unsetopt XTRACE KSH_ARRAYS
  prompt_opts=(cr percent subst)

  # Load required functions.
  autoload -Uz add-zsh-hook

  # Add hook for calling git-info before each command.
  add-zsh-hook preexec prompt_iggy_preexec
  add-zsh-hook precmd prompt_iggy_precmd

  # Set editor-info parameters.
  zstyle ':prezto:module:editor:info:completing' format '%B%F{red}...%f%b'
  zstyle ':prezto:module:editor:info:keymap:primary' format "%B $__prompt_iggy_prompt_sym_glyph%b"
  zstyle ':prezto:module:editor:info:keymap:primary:insert' format "%BI$__prompt_iggy_prompt_sym_glyph%b"
  zstyle ':prezto:module:editor:info:keymap:primary:overwrite' format 'O$__prompt_iggy_prompt_sym_glyph'
  zstyle ':prezto:module:editor:info:keymap:alternate' format "%B $__prompt_iggy_prompt_sym_glyph_alt%b"

  # Set git-info parameters.
  zstyle ':prezto:module:git:info' verbose 'yes'
  zstyle ':prezto:module:git:info:action' format '! %s'
  zstyle ':prezto:module:git:info:added' format ' ✚'
  zstyle ':prezto:module:git:info:ahead' format ' ⬆ %A'
  zstyle ':prezto:module:git:info:behind' format ' ⬇ %B'
  zstyle ':prezto:module:git:info:branch' format '⭠ %b'
  zstyle ':prezto:module:git:info:commit' format '➦ %.7c'
  zstyle ':prezto:module:git:info:deleted' format ' ✖%X' # This gets a special format. Search this file for "X:"
  zstyle ':prezto:module:git:info:modified' format ' ✱%Z' # This gets a special format. Search this file for "Z:"
  zstyle ':prezto:module:git:info:position' format '%p'
  zstyle ':prezto:module:git:info:renamed' format ' ➙'
  zstyle ':prezto:module:git:info:stashed' format ' s%S'
  zstyle ':prezto:module:git:info:unmerged' format ' ═'
  zstyle ':prezto:module:git:info:untracked' format ' ?%u'
  zstyle ':prezto:module:git:info:keys' format \
    'prompt' '$(coalesce "%b" "%p" "%c")%s' \
    'status' ' %A%B%S%a%d%m%r%U%u'

  _newline=$'\n'
  _cursorUp=$'\e[1A'
  _cursorDown=$'\e[1B'
  _cursorForward=$'\e[1C'
  _cursorBack=$'\e[1D'

  # Define prompts.
  RPROMPT='%{${_cursorUp}%}$(_clr $__prompt_iggy_date_fg)[$(date)]$(_clr reset)%{${_cursorDown}%}%{%f%b%k%}'
  PROMPT='%{%f%b%k%}
$(segments)
$(prompt_iggy_prompt_sym) %{%f%b%k%}'
  SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
}

prompt_iggy_prompt_sym() {
  if [ $exit_status -ne 0 ]; then
    _clr $__prompt_iggy_prompt_sym_nonzero_fg --bold
  elif ( prompt_iggy_superuser ); then
    _clr $__prompt_iggy_prompt_sym_superuser_fg --bold
  else
    _clr $__prompt_iggy_prompt_sym_ok_fg --bold
  fi

  echo -n ${editor_info[keymap]}

  _clr reset
}

segments() {
  prompt_iggy_segment_status
  prompt_iggy_segment_user
  prompt_iggy_segment_git
  prompt_iggy_segment_pwd
  prompt_iggy_finish_segments
}



# ==============================
# Helper functions
# ==============================

prompt_iggy_abbreviate_path() {
  echo -n $1 | sed -e 's|/private||' -e "s|^$HOME|~|" -e 's-/\(\.\{0,1\}[^/]\)\([^/]*\)-/\1-g' -e 's|/$||'
}

prompt_iggy_superuser() {
  [ $(id -u $USER) -eq 0 ]
}

# ==============================
# Helper functions for git
# ==============================

# Check whether pwd is inside a git repo
prompt_iggy_cwd_in_git_working_tree() {
  if [[ -n $git_info[status] ]]; then
    return 0
  else
    return 1
  fi
}

# Print the current git project base directory
prompt_iggy_git_project_path() {
  git rev-parse --show-toplevel 2>/dev/null
}

# Print the working directory relative to project root
prompt_iggy_git_project_pwd() {
  local base_dir=`prompt_iggy_git_project_path`
  echo "$PWD" | sed -e "s*$base_dir**g" -e 's*^/**'
}


# ==============================
# Segment helper functions
# ==============================

prompt_iggy_start_segment() {
# args: $1 background color of new segment
#       $2 foreground color of new segment
  # If there's no background, just start one segment
  local bgc=$1
  local fgc=$2
  if ( ! bg_color_set ); then
    _clr -bg $bgc $fgc
    echo -n " "
  # If there's already a background...
  # and it's the same color, draw a separator
  elif [[ "$bgc" == "$__bgc" ]]; then
    echo -n " "
    echo -n "$__prompt_iggy_segment_separator_same_bg "
  # otherwise, draw the end of the previous segment and the start of the next
  else
    echo -n " "
    _clr -bg $bgc $__bgc
    echo -n "$__prompt_iggy_segment_separator"
    _clr -bg $bgc $fgc
    echo -n " "
  fi
}

prompt_iggy_finish_segments() {
  echo -n " "
  _clr -bg black $__bgc
  echo -n "$__prompt_iggy_segment_separator"
  _clr reset
}

# ==============================
# Segments
# ==============================

# Display symbols for a non zero exit status, root and background jobs
prompt_iggy_segment_status() {
  local nonzero=''
  local superuser=''
  local bg_jobs=''

  if [ $exit_status -ne 0 ]; then
    nonzero=$__prompt_iggy_nonzero_exit_glyph
  fi
  if ( prompt_iggy_superuser ); then
    superuser=$__prompt_iggy_superuser_glyph
  fi
  if [ $(jobs -l | wc -l) -gt 0 ]; then
    bg_jobs=$__prompt_iggy_bg_job_glyph
  fi

  if [ -n "$nonzero$superuser$bg_jobs" ]; then
    prompt_iggy_start_segment $__prompt_iggy_status_bg $__prompt_iggy_status_fg

    _clr $__prompt_iggy_nonzero_exit_fg --bold
    echo -n $nonzero

    [[ -n "$nonzero" ]] && [[ -n "$superuser" ]] && echo -n ' '

    _clr $__prompt_iggy_superuser_fg --bold
    echo -n $superuser

    [[ -n "$superuser" ]] && [[ -n "$bg_jobs" ]] && echo -n ' '

    _clr $__prompt_iggy_bg_job_fg --bold
    echo -n $bg_jobs

    _clr $__prompt_iggy_status_fg --no-bold
  fi
}

# Display actual user if different from $default_user
prompt_iggy_segment_user() {
  if ( [ -n "$default_user" ] && [ "$default_user" != "$USER" ] ) || [ -n "$SSH_CLIENT" ]; then
    prompt_iggy_start_segment $__prompt_iggy_user_bg $__prompt_iggy_user_fg
    _clr $__prompt_iggy_bg_user_user_fg
    echo -n $(whoami)
    _clr $__prompt_iggy_bg_user_at_fg
    echo -n "@"
    _clr $__prompt_iggy_bg_user_hostname_fg
    echo -n $(hostname | cut -d . -f 1)
  fi
}

prompt_iggy_segment_pwd() {
  local fgc
  local bgc
  local fghc

  if ( prompt_iggy_cwd_in_git_working_tree ); then
    __prompt_iggy_current_path=$(prompt_iggy_git_project_path)
  else
    __prompt_iggy_current_path=$PWD
  fi

  if [ -w $PWD ]; then
    fgc=$__prompt_iggy_path_segment_writable_fg
    fghc=$__prompt_iggy_path_segment_writable_fgh
    bgc=$__prompt_iggy_path_segment_writable_bg
  else
    fgc=$__prompt_iggy_path_segment_not_writable_fg
    fghc=$__prompt_iggy_path_segment_not_writable_fgh
    bgc=$__prompt_iggy_path_segment_not_writable_bg
  fi
  prompt_iggy_start_segment $bgc $fgc

  __prompt_iggy_dir=$(dirname $__prompt_iggy_current_path)
  __prompt_iggy_base=$(basename $__prompt_iggy_current_path)

  if [[ "$PWD" == "$HOME" ]]; then
    _clr --bold $fghc
    echo -n $(prompt_iggy_abbreviate_path $PWD)
  elif [[ "$PWD" == "/" ]]; then
    _clr --bold $fghc
    echo -n $PWD
  else
    echo -n $(prompt_iggy_abbreviate_path $__prompt_iggy_dir)
    echo -n "/"
    _clr --bold $fghc
    echo -n $__prompt_iggy_base
  fi
  _clr reset
  _clr -bg $bgc $fgc
}

prompt_iggy_segment_git() {
  # Only print if inside a git repository
  if ( prompt_iggy_cwd_in_git_working_tree ); then
    prompt_iggy_segment_git_status
    prompt_iggy_segment_git_project_path
  fi
}

prompt_iggy_segment_git_status() {
  local fgc
  local bgc

  # stashed
  git rev-parse --verify refs/stash > /dev/null 2>&1
  local stashed=$?
  echo ${git_info[status]} | grep -E '(✚|✖|✱|➙|═|\?)' > /dev/null 2>&1
  local modified=$?
  local num_changes="`echo ${git_info[status]} | wc -w`"
  if [[ ("$stashed" -eq "0") && ("$modified" -ne "0") ]]; then
    fgc=$__prompt_iggy_git_stashed_fg
    fghc=$__prompt_iggy_git_stashed_fg
    bgc=$__prompt_iggy_git_stashed_bg
  # dirty
  elif [[ ( "$num_changes" -gt "0" ) ]]; then
    fgc=$__prompt_iggy_git_dirty_fg
    fghc=$__prompt_iggy_git_dirty_fg
    bgc=$__prompt_iggy_git_dirty_bg
  # clean
  else
    fgc=$__prompt_iggy_git_ok_fg
    fghc=$__prompt_iggy_git_ok_fg
    bgc=$__prompt_iggy_git_ok_bg
  fi
  prompt_iggy_start_segment $bgc $fgc

  _clr --bold $fghc
  echo -n ${(e)git_info[prompt]}
  _clr --no-bold
  echo -n ${git_info[status]}
}

prompt_iggy_segment_git_project_path() {
  __prompt_iggy_project_pwd=$(prompt_iggy_git_project_pwd)
  if [[ -n "$__prompt_iggy_project_pwd" ]]; then
    prompt_iggy_start_segment $__prompt_iggy_git_project_pwd_bg $__prompt_iggy_git_project_pwd_fg
    _clr --no-bold
    echo -n $__prompt_iggy_project_pwd
  fi
}


# ==============================
# Color functions
# ==============================

__fgc='' # foreground color
__bgc='' # background color

fg_color_set() {
  [[ -n $__fgc ]]
}

bg_color_set() {
  [[ -n $__bgc ]]
}

_clr() {
  typeset -Ag colors
  local mode
  local reset

  colors=( black "0" red "1" green "2" yellow "3" blue "4" magenta "5" cyan "6" white "7" )

  while [ $1 ]; do
      case "$1" in
        '-B'|'--bold') mode="%B";;
        '-b'|'--no-bold') mode="%b";;
        '-bg'|'--bg') __bgc=$2;;
        'reset') reset=true;;
        *) __fgc=$1;;
      esac
      shift
  done

  if [[ "$reset" == true ]]; then
    __fgc=''
    __bgc=''
    echo -ne '%{%f%b%k%}'
  else
    echo -ne "$mode"
    echo -n "%{%K{$__bgc}%}%{%F{$__fgc}%}"
  fi
}


# Prezto's git-dir function
function __prompt_iggy_git_dir() {
  local git_dir="${$(git rev-parse --git-dir):A}"

  if [[ -n "$git_dir" ]]; then
    print "$git_dir"
    return 0
  else
    print "$0: not a repository: $PWD" >&2
    return 1
  fi
}


# Prezto's _git-action function
# Gets the Git special action (am, bisect, cherry, merge, rebase).
# Borrowed from vcs_info and edited.
function __prompt_iggy_git_action() {
  local action_dir
  local git_dir="$(__prompt_iggy_git_dir)"
  local apply_formatted
  local bisect_formatted
  local cherry_pick_formatted
  local cherry_pick_sequence_formatted
  local merge_formatted
  local rebase_formatted
  local rebase_interactive_formatted
  local rebase_merge_formatted

  for action_dir in \
    "${git_dir}/rebase-apply" \
    "${git_dir}/rebase" \
    "${git_dir}/../.dotest"
  do
    if [[ -d "$action_dir" ]] ; then
      zstyle -s ':prezto:module:git:info:action:apply' format 'apply_formatted' || apply_formatted='apply'
      zstyle -s ':prezto:module:git:info:action:rebase' format 'rebase_formatted' || rebase_formatted='rebase'

      if [[ -f "${action_dir}/rebasing" ]] ; then
        print "$rebase_formatted"
      elif [[ -f "${action_dir}/applying" ]] ; then
        print "$apply_formatted"
      else
        print "${rebase_formatted}/${apply_formatted}"
      fi

      return 0
    fi
  done

  for action_dir in \
    "${git_dir}/rebase-merge/interactive" \
    "${git_dir}/.dotest-merge/interactive"
  do
    if [[ -f "$action_dir" ]]; then
      zstyle -s ':prezto:module:git:info:action:rebase-interactive' format 'rebase_interactive_formatted' || rebase_interactive_formatted='rebase-interactive'
      print "$rebase_interactive_formatted"
      return 0
    fi
  done

  for action_dir in \
    "${git_dir}/rebase-merge" \
    "${git_dir}/.dotest-merge"
  do
    if [[ -d "$action_dir" ]]; then
      zstyle -s ':prezto:module:git:info:action:rebase-merge' format 'rebase_merge_formatted' || rebase_merge_formatted='rebase-merge'
      print "$rebase_merge_formatted"
      return 0
    fi
  done

  if [[ -f "${git_dir}/MERGE_HEAD" ]]; then
    zstyle -s ':prezto:module:git:info:action:merge' format 'merge_formatted' || merge_formatted='merge'
    print "$merge_formatted"
    return 0
  fi

  if [[ -f "${git_dir}/CHERRY_PICK_HEAD" ]]; then
    if [[ -d "${git_dir}/sequencer" ]] ; then
      zstyle -s ':prezto:module:git:info:action:cherry-pick-sequence' format 'cherry_pick_sequence_formatted' || cherry_pick_sequence_formatted='cherry-pick-sequence'
      print "$cherry_pick_sequence_formatted"
    else
      zstyle -s ':prezto:module:git:info:action:cherry-pick' format 'cherry_pick_formatted' || cherry_pick_formatted='cherry-pick'
      print "$cherry_pick_formatted"
    fi

    return 0
  fi

  if [[ -f "${git_dir}/BISECT_LOG" ]]; then
    zstyle -s ':prezto:module:git:info:action:bisect' format 'bisect_formatted' || bisect_formatted='bisect'
    print "$bisect_formatted"
    return 0
  fi

  return 1
}

# Prezto's git-info function with slight adjustments in the semantics of the
# deleted files counter.
# Gets the Git status information.
function __prompt_iggy_git_info {
  # Extended globbing is needed to parse repository status.
  setopt LOCAL_OPTIONS
  setopt EXTENDED_GLOB

  local action
  local action_format
  local action_formatted
  local added=0
  local added_format
  local added_formatted
  local ahead=0
  local ahead_and_behind
  local ahead_and_behind_cmd
  local ahead_format
  local ahead_formatted
  local ahead_or_behind
  local behind=0
  local behind_format
  local behind_formatted
  local branch
  local branch_format
  local branch_formatted
  local branch_info
  local clean
  local clean_formatted
  local commit
  local commit_format
  local commit_formatted
  local deleted=0
  local deleted_format
  local deleted_formatted
  local deleted_staged=0
  local deleted_unstaged=0
  local dirty=0
  local dirty_format
  local dirty_formatted
  local ignore_submodules
  local indexed=0
  local indexed_format
  local indexed_formatted
  local -A info_formats
  local info_format
  local modified=0
  local modified_format
  local modified_formatted
  local modified_staged=0
  local modified_unstaged=0
  local position
  local position_format
  local position_formatted
  local remote
  local remote_cmd
  local remote_format
  local remote_formatted
  local renamed=0
  local renamed_format
  local renamed_formatted
  local stashed=0
  local stashed_format
  local stashed_formatted
  local status_cmd
  local status_mode
  local unindexed=0
  local unindexed_format
  local unindexed_formatted
  local unmerged=0
  local unmerged_format
  local unmerged_formatted
  local untracked=0
  local untracked_format
  local untracked_formatted

  # Clean up previous $git_info.
  unset git_info
  typeset -gA git_info

  # Return if not inside a Git repository work tree.
  if ! is-true "$(git rev-parse --is-inside-work-tree 2> /dev/null)"; then
    return 1
  fi

  local git_dir="$(__prompt_iggy_git_dir)"

  if (( $# > 0 )); then
    if [[ "$1" == [Oo][Nn] ]]; then
      git config --bool prompt.showinfo true
    elif [[ "$1" == [Oo][Ff][Ff] ]]; then
      git config --bool prompt.showinfo false
    else
      print "usage: $0 [ on | off ]" >&2
    fi
    return 0
  fi

  # Return if git-info is disabled.
  if ! is-true "${$(git config --bool prompt.showinfo):-true}"; then
    return 1
  fi

  # Ignore submodule status.
  zstyle -s ':prezto:module:git:status:ignore' submodules 'ignore_submodules'

  # Format commit.
  zstyle -s ':prezto:module:git:info:commit' format 'commit_format'
  if [[ -n "$commit_format" ]]; then
    commit="$(git rev-parse HEAD 2> /dev/null)"
    if [[ -n "$commit" ]]; then
      zformat -f commit_formatted "$commit_format" "c:$commit"
    fi
  fi

  # Format stashed.
  zstyle -s ':prezto:module:git:info:stashed' format 'stashed_format'
  if [[ -n "$stashed_format" && -f "${git_dir}/refs/stash" ]]; then
    stashed="$(git stash list 2> /dev/null | wc -l | awk '{print $1}')"
    if [[ -n "$stashed" ]]; then
      zformat -f stashed_formatted "$stashed_format" "S:$stashed"
    fi
  fi

  # Format action.
  zstyle -s ':prezto:module:git:info:action' format 'action_format'
  if [[ -n "$action_format" ]]; then
    action="$(__prompt_iggy_git_action)"
    if [[ -n "$action" ]]; then
      zformat -f action_formatted "$action_format" "s:$action"
    fi
  fi

  # Get the branch.
  branch="${$(git symbolic-ref HEAD 2> /dev/null)#refs/heads/}"

  # Format branch.
  zstyle -s ':prezto:module:git:info:branch' format 'branch_format'
  if [[ -n "$branch" && -n "$branch_format" ]]; then
    zformat -f branch_formatted "$branch_format" "b:$branch"
  fi

  # Format position.
  zstyle -s ':prezto:module:git:info:position' format 'position_format'
  if [[ -z "$branch" && -n "$position_format" ]]; then
    position="$(git describe --contains --all HEAD 2> /dev/null)"
    if [[ -n "$position" ]]; then
      zformat -f position_formatted "$position_format" "p:$position"
    fi
  fi

  # Format remote.
  zstyle -s ':prezto:module:git:info:remote' format 'remote_format'
  if [[ -n "$branch" && -n "$remote_format" ]]; then
    # Gets the remote name.
    remote_cmd='git rev-parse --symbolic-full-name --verify HEAD@{upstream}'
    remote="${$(${(z)remote_cmd} 2> /dev/null)##refs/remotes/}"
    if [[ -n "$remote" ]]; then
      zformat -f remote_formatted "$remote_format" "R:$remote"
    fi
  fi

  zstyle -s ':prezto:module:git:info:ahead' format 'ahead_format'
  zstyle -s ':prezto:module:git:info:behind' format 'behind_format'
  if [[ -n "$branch" && ( -n "$ahead_format" || -n "$behind_format" ) ]]; then
    # Gets the commit difference counts between local and remote.
    ahead_and_behind_cmd='git rev-list --count --left-right HEAD...@{upstream}'

    # Get ahead and behind counts.
    ahead_and_behind="$(${(z)ahead_and_behind_cmd} 2> /dev/null)"

    # Format ahead.
    if [[ -n "$ahead_format" ]]; then
      ahead="$ahead_and_behind[(w)1]"
      if (( ahead > 0 )); then
        zformat -f ahead_formatted "$ahead_format" "A:$ahead"
      fi
    fi

    # Format behind.
    if [[ -n "$behind_format" ]]; then
      behind="$ahead_and_behind[(w)2]"
      if (( behind > 0 )); then
        zformat -f behind_formatted "$behind_format" "B:$behind"
      fi
    fi
  fi

  # Get status type.
  if ! zstyle -t ':prezto:module:git:info' verbose; then
    # Format indexed.
    zstyle -s ':prezto:module:git:info:indexed' format 'indexed_format'
    if [[ -n "$indexed_format" ]]; then
      ((
        indexed+=$(
          git diff-index \
            --no-ext-diff \
            --name-only \
            --cached \
            --ignore-submodules=${ignore_submodules:-none} \
            HEAD \
            2> /dev/null \
          | wc -l
        )
      ))
      if (( indexed > 0 )); then
        zformat -f indexed_formatted "$indexed_format" "i:$indexed"
      fi
    fi

    # Format unindexed.
    zstyle -s ':prezto:module:git:info:unindexed' format 'unindexed_format'
    if [[ -n "$unindexed_format" ]]; then
      ((
        unindexed+=$(
          git diff-files \
            --no-ext-diff \
            --name-only \
            --ignore-submodules=${ignore_submodules:-none} \
            2> /dev/null \
          | wc -l
        )
      ))
      if (( unindexed > 0 )); then
        zformat -f unindexed_formatted "$unindexed_format" "I:$unindexed"
      fi
    fi

    # Format untracked.
    zstyle -s ':prezto:module:git:info:untracked' format 'untracked_format'
    if [[ -n "$untracked_format" ]]; then
      ((
        untracked+=$(
          git ls-files \
            --other \
            --exclude-standard \
            2> /dev/null \
          | wc -l
        )
      ))
      if (( untracked > 0 )); then
        zformat -f untracked_formatted "$untracked_format" "u:$untracked"
      fi
    fi

    (( dirty = indexed + unindexed + untracked ))
  else
    # Use porcelain status for easy parsing.
    status_cmd="git status --porcelain --ignore-submodules=${ignore_submodules:-none}"

    # Get current status.
    while IFS=$'\n' read line; do
      # Count added, deleted, modified, renamed, unmerged, untracked, dirty.
      [[ "$line" ==  ([CDMRTUXB\?\ ]A|A[CDMRTUXB\?\ ])\ * ]]  && (( added++ ))
      [[ "$line" == ([ACDMRTUXB\?\ ]D|D[ACDMRTUXB\?\ ])\ * ]] && (( deleted++ ))
      [[ "$line" ==                   (D[ACMRTUXB\?\ ])\ * ]] && (( deleted_staged++ ))
      [[ "$line" == ([ACMRTUXB\?\ ]D)\ * ]]                   && (( deleted_unstaged++ ))
      [[ "$line" == ([ACDMRTUXB\?\ ]M|M[ACDMRTUXB\?\ ])\ * ]] && (( modified++ ))
      [[ "$line" ==                  (M[ACDMRTUXB\?\ ])\ * ]] && (( modified_staged++ ))
      [[ "$line" == ([ACDMRTUXB\?\ ]M)\ * ]]                  && (( modified_unstaged++ ))
      [[ "$line" == ([ACDMRTUXB\?\ ]R|R[ACDMRTUXB\?\ ])\ * ]] && (( renamed++ ))
      [[ "$line" == (AA|DD|U\?|\?U)\ * ]] && (( unmerged++ ))
      [[ "$line" == \?\?\ * ]] && (( untracked++ ))
      (( dirty++ ))
    done < <(${(z)status_cmd} 2> /dev/null)

    # Format added.
    if (( added > 0 )); then
      zstyle -s ':prezto:module:git:info:added' format 'added_format'
      zformat -f added_formatted "$added_format" "a:$added"
    fi

    # Format deleted.
    if (( deleted > 0 )); then
      zstyle -s ':prezto:module:git:info:deleted' format 'deleted_format'
      local deleted_unstaged_format
      if (( deleted_unstaged > 0 )); then
        deleted_unstaged_format="$deleted_unstaged"
      else
        deleted_unstaged_format=""
      fi
      zformat -f deleted_formatted "$deleted_format" "d:$deleted" "x:$deleted_staged" "X:$deleted_unstaged_format"
    fi

    # Format modified.
    if (( modified > 0 )); then
      zstyle -s ':prezto:module:git:info:modified' format 'modified_format'
      local modified_unstaged_format
      if (( modified_unstaged > 0 )); then
        modified_unstaged_format="$modified_unstaged"
      else
        modified_unstaged_format=""
      fi
      zformat -f modified_formatted "$modified_format" "m:$modified" "z:$modified_staged" "Z:$modified_unstaged_format"
    fi

    # Format renamed.
    if (( renamed > 0 )); then
      zstyle -s ':prezto:module:git:info:renamed' format 'renamed_format'
      zformat -f renamed_formatted "$renamed_format" "r:$renamed"
    fi

    # Format unmerged.
    if (( unmerged > 0 )); then
      zstyle -s ':prezto:module:git:info:unmerged' format 'unmerged_format'
      zformat -f unmerged_formatted "$unmerged_format" "U:$unmerged"
    fi

    # Format untracked.
    if (( untracked > 0 )); then
      zstyle -s ':prezto:module:git:info:untracked' format 'untracked_format'
      zformat -f untracked_formatted "$untracked_format" "u:$untracked"
    fi
  fi

  # Format dirty and clean.
  if (( dirty > 0 )); then
    zstyle -s ':prezto:module:git:info:dirty' format 'dirty_format'
    zformat -f dirty_formatted "$dirty_format" "D:$dirty"
  else
    zstyle -s ':prezto:module:git:info:clean' format 'clean_formatted'
  fi

  # Format info.
  zstyle -a ':prezto:module:git:info:keys' format 'info_formats'
  for info_format in ${(k)info_formats}; do
    zformat -f REPLY "$info_formats[$info_format]" \
      "a:$added_formatted" \
      "A:$ahead_formatted" \
      "B:$behind_formatted" \
      "b:$branch_formatted" \
      "C:$clean_formatted" \
      "c:$commit_formatted" \
      "d:$deleted_formatted" \
      "D:$dirty_formatted" \
      "i:$indexed_formatted" \
      "I:$unindexed_formatted" \
      "m:$modified_formatted" \
      "p:$position_formatted" \
      "R:$remote_formatted" \
      "r:$renamed_formatted" \
      "s:$action_formatted" \
      "S:$stashed_formatted" \
      "U:$unmerged_formatted" \
      "u:$untracked_formatted"
    git_info[$info_format]="$REPLY"
  done

  unset REPLY

  return 0
}


prompt_iggy_setup "$@"