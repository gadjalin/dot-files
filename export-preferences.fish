#!/usr/bin/env fish

# Spoiler, I don't have much experience with fish scripting either

# Isn't there an other word to say that I want to execute the program without it installing anything as it would otherwise do ?
set -g debug false

if [ "$argv[1]" = "debug" ]
    set -g debug true
end

function get_greet_time
    set -f hour $(date "+%H")

    if [ $hour -ge 19 ] || [ $hour -lt 5 ]
        set -f greet_time evening
    else if [ $hour -ge 5 ] && [ $hour -lt 12 ]
        set -f greet_time morning
    else
        set -f greet_time afternoon
    end

    echo $greet_time
end

# It is important to greet people before working with them...
function greet_me
    if [ $debug = true ]
        set -f formula "we will debug the program"
    else
        set -f formula "we will proceed to the exportation of your preferences in the current environment."
    end

    echo "Good $(get_greet_time) $USER, $formula"
end

# ...and saying goodbye as well
function goodbye_me
    echo "All seem to have completed successfully. Have a nice day."
end

# Real shit starts here
function check_font
    echo "Remember to install recommended font at https://github.com/romkatv/powerlevel10k-media/"
 
    if [ $debug = false ]
        echo "TODO Find a way to automate font installation"
    end
end

function check_fisher
    echo -n "Checking Fisher... "

    if ! type fisher &> /dev/null
        echo -n "Fisher seems to be missing. Installing now... "

        if [ $debug = false ]
            curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
        end
    end

    echo "Fisher is installed !"
end

function check_fish_plugins
    echo -n "Checking Tide and other plugins... "

    if [ ! (fisher list | grep ilancosman/tide) ]
        echo -n "Tide is not installed. Installing now... "

        if [ $debug = false ]
            fisher install IlanCosman/tide@v5
        end
    end

    if [ ! (fisher list | grep decors/fish-source-highlight) ]
        echo -n "fish-source-highlight is not installed. Installing now... "

        if [ $debug = false ]
            fisher install decors/fish-source-highlight
        end
    end

    echo "Everything is installed !"
end

function export_fishrc
    echo -n "Exporting shell dot-files... "

    if [ $debug = false ]
        cp {./dot-files,$HOME/.config/fish}/config.fish
    end

    echo "Exported."
end

# Did you mean: emacs
function check_vim
    echo -n "Checking VIM... "
 
    if ! type vim &> /dev/null
        echo "Vim is not installed."
  
        if [ $debug = false ]
           echo "TODO Automate installation"
        end
  
        exit 1
    end
 
    set -f vim_major $(vim --version | head -n1 | sed -e 's/^[^0-9]*//' -e 's/\..*//')
 
    if [ $vim_major -lt 9 ]
        echo "VIM is not up to date: must be >9.0 !"
        exit 1
    end
 
    echo "VIM is installed and up to date !"
end

function check_vim_features
    echo -n "Checking VIM features... "

    # For Yggdroot/indentLine
    if [ ! (vim --version | grep +conceal) ]
        echo "VIM is missing a feature: conceal"
        exit 1
    end

    # TODO Check other features

    echo "VIM has all required features !"
end

function check_vim_plugins
    echo -n "Checking VIM plugins... "

    if [ ! -d ~/.vim/bundle/Vundle.vim ]
        echo -n "Vundle was not detected. Installing now... "

        if [ $debug = false ]
            git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
        end
    end

    if [ ! -d ~/.vim/pack/plugins/start/vim-cpp-modern ]
        echo -n "vim-cpp-modern was not detected. Installing now... "

        if [ $debug = false ]
            mkdir -p $HOME/.vim/pack/plugins/start
            git clone --depth=1 https://github.com/bfrg/vim-cpp-modern.git $HOME/.vim/pack/plugins/start/vim-cpp-modern
        end
    end

    echo "VIM plugins are installed and ready to go !"
end

function export_vimrc
    echo -n "Exporting VIM dot-files... "

    if [ $debug = false ]
        cp {./dot-files,$HOME}/.vimrc
        mkdir -p $HOME/.vim/colors
        cp {./dot-files,$HOME/.vim}/init.vim
        cp {./dot-files,$HOME/.vim/colors}/cyberpunk-neon.vim
    end

    echo "Exported."
end

function configure_vim
    echo -n "Now configuring VIM... "

    if [ $debug = false ]
        vim -u $HOME/.vimrc +PluginInstall +qall
    end

    # TODO: build YCM
    echo "VIM configured"
    echo "/!\ Remember to build YCM with 'cd ~/.vim/bundle/YouCompleteMe && python3 install.py --all'"
end

greet_me

check_font
check_fisher
check_fish_plugins
export_fishrc

check_vim
check_vim_features
check_vim_plugins
export_vimrc
configure_vim

goodbye_me

