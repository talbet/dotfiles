# You can override some default right prompt options in your config.fish:
#     set -g theme_date_format "+%a %H:%M"

[ $theme_color_scheme = 'terminal-dark-white' ]; and set colorfg white
set __color_initial_segment_exit     white red --bold
set __color_initial_segment_su       white green --bold
set __color_initial_segment_jobs     white blue --bold

set __color_path                     white black
set __color_path_basename            white black
set __color_path_nowrite             magenta $colorfg
set __color_path_nowrite_basename    magenta $colorfg --bold

set __color_repo                     green $colorfg
set __color_repo_work_tree           black $colorfg --bold
set __color_repo_dirty               brred $colorfg
set __color_repo_staged              yellow $colorfg

set __color_vi_mode_default          brblue $colorfg --bold
set __color_vi_mode_insert           brgreen $colorfg --bold
set __color_vi_mode_visual           bryellow $colorfg --bold

set __color_vagrant                  brcyan $colorfg
set __color_username                 white black
set __color_rvm                      brred $colorfg --bold
set __color_virtualfish              brblue $colorfg --bold


# ===========================
# Helper methods
# ===========================

function __bobthefish_cmd_duration -S -d 'Show command duration'
  [ "$theme_display_cmd_duration" = "no" ]; and return
  [ -z "$CMD_DURATION" -o "$CMD_DURATION" -lt 100 ]; and return

  if [ "$CMD_DURATION" -lt 5000 ]
    echo -ns $CMD_DURATION 'ms'
  else if [ "$CMD_DURATION" -lt 60000 ]
    __bobthefish_pretty_ms $CMD_DURATION s
  else if [ "$CMD_DURATION" -lt 3600000 ]
    set_color $fish_color_error
    __bobthefish_pretty_ms $CMD_DURATION m
  else
    set_color $fish_color_error
    __bobthefish_pretty_ms $CMD_DURATION h
  end

  set_color $fish_color_normal
  set_color $fish_color_autosuggestion

  [ "$theme_display_date" = "no" ]
    or echo -ns ' ' $__bobthefish_left_arrow_glyph
end

function __bobthefish_pretty_ms -S -a ms interval -d 'Millisecond formatting for humans'
  set -l interval_ms
  set -l scale 1

  switch $interval
    case s
      set interval_ms 1000
    case m
      set interval_ms 60000
    case h
      set interval_ms 3600000
      set scale 2
  end

  switch $FISH_VERSION
    case 2.\*
      math "scale=$scale;$ms/$interval_ms" | string replace -r '\\.?0*$' $interval
    case \*
      math -s$scale "$ms/$interval_ms" | string replace -r '\\.?0*$' $interval
  end
end

function __bobthefish_timestamp -S -d 'Show the current timestamp'
  [ "$theme_display_date" = "no" ]; and return
  set -q theme_date_format
    or set -l theme_date_format "+%c"

  echo -n ' '
  date $theme_date_format
end

function __bobthefish_git_branch -S -d 'Get the current git branch (or commitish)'
  set -l ref (command git symbolic-ref HEAD ^/dev/null)
    and string replace 'refs/heads/' "$__bobthefish_branch_glyph " $ref
    and return

  set -l tag (command git describe --tags --exact-match ^/dev/null)
    and echo "$__bobthefish_tag_glyph $tag"
    and return

  set -l branch (command git show-ref --head -s --abbrev | head -n1 ^/dev/null)
  echo "$__bobthefish_detached_glyph $branch"
end

function __bobthefish_git_project_dir -S -d 'Print the current git project base directory'
  [ "$theme_display_git" = 'no' ]; and return
  if [ "$theme_git_worktree_support" != 'yes' ]
    command git rev-parse --show-toplevel ^/dev/null
    return
  end

  set -l git_dir (command git rev-parse --git-dir ^/dev/null); or return

  pushd $git_dir
  set git_dir $PWD
  popd

  switch $PWD/
    case $git_dir/\*
      # Nothing works quite right if we're inside the git dir
      # TODO: fix the underlying issues then re-enable the stuff below

      # # if we're inside the git dir, sweet. just return that.
      # set -l toplevel (command git rev-parse --show-toplevel ^/dev/null)
      # if [ "$toplevel" ]
      #   switch $git_dir/
      #     case $toplevel/\*
      #       echo $git_dir
      #   end
      # end
      return
  end

  set -l project_dir (dirname $git_dir)

  switch $PWD/
    case $project_dir/\*
      echo $project_dir
      return
  end

  set project_dir (command git rev-parse --show-toplevel ^/dev/null)
  switch $PWD/
    case $project_dir/\*
      echo $project_dir
  end
end

function __bobthefish_git_ahead -S -d 'Print the ahead/behind state for the current branch'
  if [ "$theme_display_git_ahead_verbose" = 'yes' ]
    __bobthefish_git_ahead_verbose
    return
  end

  set -l ahead 0
  set -l behind 0
  for line in (command git rev-list --left-right '@{upstream}...HEAD' ^/dev/null)
    switch "$line"
      case '>*'
        if [ $behind -eq 1 ]
          echo '±'
          return
        end
        set ahead 1
      case '<*'
        if [ $ahead -eq 1 ]
          echo "$__bobthefish_git_plus_minus_glyph"
          return
        end
        set behind 1
    end
  end

  if [ $ahead -eq 1 ]
    echo "$__bobthefish_git_plus_glyph"
  else if [ $behind -eq 1 ]
    echo "$__bobthefish_git_minus_glyph"
  end
end

function __bobthefish_git_ahead_verbose -S -d 'Print a more verbose ahead/behind state for the current branch'
  set -l commits (command git rev-list --left-right '@{upstream}...HEAD' ^/dev/null)
  [ $status != 0 ]; and return

  set -l behind (count (for arg in $commits; echo $arg; end | command grep '^<'))
  set -l ahead (count (for arg in $commits; echo $arg; end | command grep -v '^<'))

  switch "$ahead $behind"
    case '' # no upstream
    case '0 0' # equal to upstream
      return
    case '* 0' # ahead of upstream
      echo "$__bobthefish_git_ahead_glyph$ahead"
    case '0 *' # behind upstream
      echo "$__bobthefish_git_behind_glyph$behind"
    case '*' # diverged from upstream
      echo "$__bobthefish_git_ahead_glyph$ahead$__bobthefish_git_behind_glyph$behind"
  end
end

# ===========================
# Segment functions
# ===========================

function __start_segment_right -S -d 'Start a prompt segment'
  set -l bg $argv[1]
  set -e argv[1]
  set -l fg $argv[1]
  set -e argv[1]

  set_color normal # clear out anything bold or underline...

  switch "$__bobthefish_current_bg"
    case ''
      # If there's no background, start with an arrow
      set_color $bg
      echo -ns ' ' $__bobthefish_left_black_arrow_glyph
    case "$bg"
      # If the background is already the same color, draw a separator
      echo -ns $__bobthefish_left_arrow_glyph ' '
    case '*'
      # otherwise, draw the end of the previous segment and the start of the next
      set_color $__bobthefish_current_bg
      echo -ns $__bobthefish_left_black_arrow_glyph ' '
      set_color $fg $argv
  end

  set_color -b $bg $fg $argv

  set __bobthefish_current_bg $bg
end

# ===========================
# Theme components
# ===========================

function __prompt_git_right -S -a current_dir -d 'Display the actual git state'
  set -l dirty   (command git diff --no-ext-diff --quiet --exit-code ^/dev/null; or echo -n "$__bobthefish_git_dirty_glyph")
  set -l staged  (command git diff --cached --no-ext-diff --quiet --exit-code ^/dev/null; or echo -n "$__bobthefish_git_staged_glyph")
  set -l stashed (command git rev-parse --verify --quiet refs/stash >/dev/null; and echo -n "$__bobthefish_git_stashed_glyph")
  set -l ahead   (__bobthefish_git_ahead)

  set -l new ''
  set -l show_untracked (command git config --bool bash.showUntrackedFiles ^/dev/null)
  if [ "$theme_display_git_untracked" != 'no' -a "$show_untracked" != 'false' ]
    set new (command git ls-files --other --exclude-standard --directory --no-empty-directory ^/dev/null)
    if [ "$new" ]
      set new "$__bobthefish_git_untracked_glyph"
    end
  end

  set -l flags "$dirty$staged$stashed$ahead$new"
  [ "$flags" ]
    and set flags " $flags"

  set -l flag_colors $__color_repo
  if [ "$dirty" ]
    set flag_colors $__color_repo_dirty
  else if [ "$staged" ]
    set flag_colors $__color_repo_staged
  end

  __start_segment_right $flag_colors
  echo -ns (__bobthefish_git_branch) $flags ' '
  set_color normal

  if [ "$theme_git_worktree_support" != 'yes' ]
    set -l project_pwd (__bobthefish_project_pwd $current_dir)
    if [ "$project_pwd" ]
      if [ -w "$PWD" ]
        __start_segment_right $__color_path
      else
        __start_segment_right $__color_path_nowrite
      end

      echo -ns $project_pwd ' '
    end
    return
  end

  set -l project_pwd (command git rev-parse --show-prefix ^/dev/null | string replace -r '/$' '')
  set -l work_dir (command git rev-parse --show-toplevel ^/dev/null)

  # only show work dir if it's a parent…
  if [ "$work_dir" ]
    switch $PWD/
      case $work_dir/\*
        string match "$current_dir*" $work_dir >/dev/null
          and set work_dir (string sub -s (math 1 + (string length $current_dir)) $work_dir)
      case \*
        set -e work_dir
    end
  end

  if [ "$project_pwd" -o "$work_dir" ]
    set -l colors $__color_path
    if not [ -w "$PWD" ]
      set colors $__color_path_nowrite
    end

    __start_segment_right $colors

    # handle work_dir != project dir
    if [ "$work_dir" ]
      set -l work_parent (dirname $work_dir | string replace -r '^/' '')
      if [ "$work_parent" ]
        echo -n "$work_parent/"
      end
      set_color normal
      set_color -b $__color_repo_work_tree
      echo -n (basename $work_dir)
      set_color normal
      set_color -b $colors
      [ "$project_pwd" ]
        and echo -n '/'
    end

    echo -ns $project_pwd ' '
  else
    set project_pwd $PWD
    string match "$current_dir*" $project_pwd >/dev/null
      and set project_pwd (string sub -s (math 1 + (string length $current_dir)) $project_pwd)
    set project_pwd (string replace -r '^/' '' $project_pwd)

    if [ "$project_pwd" ]
      set -l colors $__color_path
      if not [ -w "$PWD" ]
        set colors $__color_path_nowrite
      end

      __start_segment_right $colors

      echo -ns $project_pwd ' '
    end
  end
end

function fish_right_prompt -d 'bobthefish is all about the right prompt'
  set -l __bobthefish_left_black_arrow_glyph  \uE0B2
  set -l __bobthefish_left_arrow_glyph        \uE0B3
  set -l colorfg black

  set -l git_root (__bobthefish_git_project_dir)
  # Git glyphs
  set __bobthefish_git_dirty_glyph      \uF448 '' # nf-oct-pencil
  set __bobthefish_git_staged_glyph     \uF0C7 '' # nf-fa-save
  set __bobthefish_git_stashed_glyph    \uF0C6 '' # nf-fa-paperclip
  set __bobthefish_git_untracked_glyph  \uF128 '' # nf-fa-question
  set __bobthefish_git_untracked_glyph  \uF141 '' # nf-fa-ellipsis_h
  set __bobthefish_git_ahead_glyph      \uF47B # nf-oct-chevron_up
  set __bobthefish_git_behind_glyph     \uF47C # nf-oct-chevron_down
  set __bobthefish_git_plus_glyph       \uF0DE # fa-sort-asc
  set __bobthefish_git_minus_glyph      \uF0DD # fa-sort-desc
  set __bobthefish_git_plus_minus_glyph \uF0DC # fa-sort

  set_color $fish_color_autosuggestion

  __bobthefish_cmd_duration
  __bobthefish_timestamp

  if [ "$git_root" ]
    __prompt_git_right $git_root
  end

  set_color normal
end
