if status is-interactive
    # Commands to run in interactive sessions can go here

    # Startup command
    fortune | cowsay
end

# Suppress fish welcome message
set -U fish_greeting

# Configure tide prompt
set -g tide_context_always_display true
set -g tide_character_icon \$
set -g tide_time_format %H:%M

# Tide colors
set -g prompt_theme vaporwave87
source $__fish_config_dir/tide_themes/$prompt_theme.fish

set -g tide_left_prompt_items context pwd git character
set -g tide_right_prompt_items cmd_duration jobs python time

# Note: source-highlight is handled by decors/fish-source-highlight

# --- macOS ---
if test (uname) = Darwin
    # Path variables
    eval "$(/opt/homebrew/bin/brew shellenv)"

    set -gx PATH $HOMEBREW_PREFIX/opt/python@3.14/libexec/bin $PATH
    set -gx PATH $HOMEBREW_PREFIX/opt/llvm/bin $PATH

    # Activate autojump
    [ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

    #set -gx LDFLAGS "-L/opt/homebrew/opt/llvm/lib"
    #set -gx CPPFLAGS "-I/opt/homebrew/opt/llvm/include"

    # In case CMake requires more recent LLVM than Apple Clang
    #set -gx CC /opt/homebrew/opt/llvm/bin/clang
    #set -gx CXX /opt/homebrew/opt/llvm/bin/clang++
    #set -gx LD /opt/homebrew/opt/lld/bin/ld.lld
    #set -gx AR /opt/homebrew/opt/llvm/bin/llvm-ar
    #set -gx RANLIB /opt/homebrew/opt/llvm/bin/llvm-ranlib
end
# -------------

# --- Linux ---
if test (uname) = Linux
    # Activate autojump
    [ -f /usr/share/autojump/autojump.fish ]; and source /usr/share/autojump/autojump.fish
end
# -------------

set -gx PATH $HOME/.local/bin $PATH

#set -gx PATH $HOME/.cargo/bin $PATH
#set -gx PATH /opt/homebrew/opt/ruby/bin $PATH
#set -gx PATH (gem environment gemdir) $PATH

# Research path variables
set -gx LIT_CACHE_DIR $HOME/.local/share/literature
#set -gx MCP_ADS_ARXIV_DIR /opt/homebrew/

# Secrets (API tokens...) live outside the dot-files repo
source $__fish_config_dir/secrets.fish

source $HOME/opt/std-python/bin/activate.fish

# Alias commands
alias ll='eza -lF -s type --icons always'
alias la='eza -laF -s type --icons always'
alias lt='eza -lTF -s type --icons always'
alias myip='curl http://ipecho.net/plain; echo'
alias pssh='ps -ef | grep ssh'

