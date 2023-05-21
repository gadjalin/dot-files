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
set -g tide_right_prompt_items cmd_duration jobs time virtual_env

# Note: source-highlight is handled by decors/fish-source-highlight

# Activate autojump
[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

# Alias commands
alias ll='exa -lrF --header --icons'
alias la='exa -lrFa --header --icons'
alias myip='curl http://ipecho.net/plain; echo'

if status is-interactive
    # Commands to run in interactive sessions can go here

    # Startup command
    fortune | cowsay

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    if test -f /home/gad/anaconda3/bin/conda
        eval /home/gad/anaconda3/bin/conda "shell.fish" "hook" $argv | source
    end
    # <<< conda initialize <<<
end

