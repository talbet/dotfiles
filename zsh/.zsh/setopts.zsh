# ===== Basics
setopt interactive_comments   # Allow comments even in interactive shells (especially for Muness)
setopt chase_links            # resolve symlinks
setopt auto_remove_slash      # self explicit
setopt print_exit_value       # print return value if non-zero
unsetopt bg_nice              # no lower prio for background jobs
unsetopt clobber              # must use >| to truncate existing files
unsetopt ignore_eof           # do not exit on end-of-file
unsetopt rm_star_silent       # ask for confirmation for `rm *' or `rm path/*'
unsetopt hup                  # no hangup signal at shell exit

# ===== Changing Directories
setopt auto_cd                # if command is a path, cd into it
setopt cdablevarS             # if argument to cd is the name of a parameter whose value is a valid directory, it will become the current directory

# ===== Expansion and Globbing
setopt extended_glob          # treat #, ~, and ^ as part of patterns for filename generation
setopt glob_dots              # include dotfiles in globbing
setopt CSH_NULL_GLOB

# ===== Completion
setopt always_to_end          # When completing from the middle of a word, move the cursor to the end of the word
setopt auto_menu              # show completion menu on successive tab press. needs unsetop menu_complete to work
setopt auto_name_dirs         # any parameter that is set to the absolute name of a directory immediately becomes a name for that directory
setopt complete_in_word       # Allow completion from within a word/phrase
unsetopt menu_complete        # do not autoselect the first completion entry

# ===== Correction
setopt correct                # spelling correction for commands
setopt correctall             # spelling correction for arguments

# ===== Prompt
setopt prompt_subst           # Enable parameter expansion, command substitution, and arithmetic expansion in the prompt
setopt transient_rprompt      # only show the rprompt on the current prompt

# ===== Scripts and Functions
setopt multios                # perform implicit tees or cats when multiple redirections are attempted# ===== Basics
setopt interactive_comments   # Allow comments even in interactive shells (especially for Muness)

# ===== Beeps
unsetopt beep                 # don't beep on error
unsetopt hist_beep            # no bell on error in history
unsetopt list_beep            # no bell on ambiguous completion
