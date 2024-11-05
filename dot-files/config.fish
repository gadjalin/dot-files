if status is-interactive
    # Commands to run in interactive sessions can go here

    # Startup command
    fortune | cowsay
end

# Suppress fish welcome message
set -U fish_greeting

# Configure tide prompt
set -g tide_context_always_display true
set -g tide_context_color_default brgreen

#set -g tide_character_color F800FF
set -g tide_character_color magenta
set -g tide_character_color_failure red
set -g tide_character_icon \$

set -g tide_git_color_branch brgreen
set -g tide_git_color_dirty cyan
set -g tide_git_color_staged cyan
set -g tide_git_color_operation cyan
#set -g tide_git_color_stash F800FF
#set -g tide_git_color_untracked F800FF
#set -g tide_git_color_upstream F800FF
#set -g tide_git_color_conflicted F800FF
set -g tide_git_color_stash blue
set -g tide_git_color_untracked blue
set -g tide_git_color_upstream blue
set -g tide_git_color_conflicted blue

set -g tide_pwd_color_anchors cyan
set -g tide_pwd_color_dirs blue
set -g tide_pwd_color_truncated_dirs cyan

#set -g tide_cmd_duration_color F800FF
set -g tide_cmd_duration_color yellow
set -g tide_time_color cyan
set -g tide_time_format %H:%M
#set -g tide_jobs_color F800FF
set -g tide_jobs_color green

set -g tide_virtual_env_color brgreen

set -g tide_left_prompt_items context pwd git character
set -g tide_right_prompt_items cmd_duration jobs virtual_env time

# Note: source-highlight is handled by decors/fish-source-highlight

# --- macOS ---
#set -gx PATH /opt/homebrew/opt/python/libexec/bin $PATH
#set -gx PATH /opt/homebrew/opt/llvm/bin $PATH
#
#source /opt/std-python/bin/activate.fish

# Activate autojump
#[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

# In case CMake requires more recent LLVM than Apple Clang
#set -gx CC /opt/homebrew/opt/llvm/bin/clang
#set -gx CXX /opt/homebrew/opt/llvm/bin/clang++
#set -gx LD /opt/homebrew/opt/lld/bin/ld.lld
#set -gx AR /opt/homebrew/opt/llvm/bin/llvm-ar
#set -gx RANLIB /opt/homebrew/opt/llvm/bin/llvm-ranlib
# -------------

# --- Linux ---
#set -gx PATH $HOME/.local/bin $PATH
#
#begin
#    set --local AUTOJUMP_PATH /usr/share/autojump/autojump.fish
#    if test -e $AUTOJUMP_PATH
#        source $AUTOJUMP_PATH
#    end
#end
# -------------

# Alias commands
alias ll='eza -lF -s type --icons'
alias la='eza -laF -s type --icons'
alias lt='eza -lTF -s type --icons'
alias myip='curl http://ipecho.net/plain; echo'

