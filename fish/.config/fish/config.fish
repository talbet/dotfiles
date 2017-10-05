set -gx OS (uname)

# Terminal colors
set -gx TERM xterm-256color

# Set language environment
set -gx LANG en_AU.UTF-8
set -gx LANGUAGE en_AU.UTF-8
set -gx LC_ALL en_AU.UTF-8
set -gx LC_CTYPE en_AU.UTF-8

# Global paths
set -gx PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin $PATH
set -gx MANPATH /usr/share/man $MANPATH

# OS specific paths
switch $OS
	case Darwin
		# set -gx PATH $HOME/homebrew/bin $HOME/homebrew/sbin $PATH
		set -gx MANPATH $HOME/homebrew/share/man /usr/local/man /usr/share/man /usr/local/share/man $MANPATH
	case FreeBSD
		# null
	case '*'
		# null
end

# Set preferred editors and pagers
set -gx EDITOR code
set -gx VISUAL code
set -gx PAGER less
set -gx MANPAGER 'less -X'

# rvm
if test -d /usr/local/rvm/bin
	set -gx PATH $PATH /usr/local/rvm/bin
	rvm default
end

# rbenv
if test -d $HOME/.rbenv
	set -gx PATH $HOME/.rbenv/bin $HOME/.rbenv/shims $PATH
	source (rbenv init -|psub)
end

# yarn
if test -d $HOME/.yarn/bin
	set -gx PATH $PATH $HOME/.yarn/bin
end

# pyenv
if test -d $HOME/.pyenv
	set -gx PYENV_ROOT $HOME/.pyenv
	set -gx PATH $PYENV_ROOT/bin $PATH
	source (pyenv init -|psub)
end

# Go
if test -d $HOME/go
	set GOPATH $HOME/go
	set PATH $PATH $GOPATH/bin
end

# Rust
if test -d $HOME/.cargo
	source $HOME/.cargo/env
end

# Plugins

fundle plugin 'edc/bass'
fundle plugin 'decors/fish-colored-man'
fundle plugin 'fisherman/getopts'
fundle plugin 'fisherman/z'
fundle plugin 'oh-my-fish/plugin-grc'

fundle init

# Theme options
set -g theme_nerd_fonts yes
set -g theme_color_scheme user
set -g theme_display_ruby yes
#set -g theme_display_git no
#set -g theme_display_git_untracked no
#set -g theme_display_git_ahead_verbose yes
#set -g theme_git_worktree_support yes
#set -g theme_display_vagrant yes
#set -g theme_display_docker_machine no
#set -g theme_display_hg yes
#set -g theme_display_virtualenv no
#set -g theme_display_user yes
#set -g theme_display_vi no
#set -g theme_display_date no
#set -g theme_display_cmd_duration yes
#set -g theme_title_display_process yes
#set -g theme_title_display_path no
#set -g theme_title_display_user yes
#set -g theme_title_use_abbreviated_path no
#set -g theme_date_format "+%a %H:%M"
#set -g theme_avoid_ambiguous_glyphs yes
#set -g theme_powerline_fonts no
#set -g theme_show_exit_status yes
#set -g default_user your_normal_user
#set -g fish_prompt_pwd_dir_length 0
#set -g theme_project_dir_length 1
set -g theme_newline_cursor yes

set -l black  111111
set -l grey   333333
set -l red    CC9393
set -l green  7F9F7F
set -l yellow E3CEAB
set -l orange DFAF8F
set -l blue   8CD0D3
set -l white  DCDCCC

set __color_initial_segment_exit     $white $red --bold
set __color_initial_segment_su       $white $green --bold
set __color_initial_segment_jobs     $white $blue --bold

set __color_path                     $white $black
set __color_path_basename            $white $black --bold
set __color_path_nowrite             $white $red
set __color_path_nowrite_basename    $white $red --bold

set __color_repo                     $green $grey
set __color_repo_work_tree           $grey $grey --bold
set __color_repo_dirty               $red $grey
set __color_repo_staged              $yellow $grey

set __color_vi_mode_default          $grey $yellow --bold
set __color_vi_mode_insert           $green $white --bold
set __color_vi_mode_visual           $yellow $grey --bold

set __color_vagrant                  $blue $green --bold
set __color_username                 $grey $blue
set __color_rvm                      $red $grey --bold
set __color_virtualfish              $blue $grey --bold

# Source extra configs
for f in $HOME/.config/fish/extra/*.fish;
	source $f
end
