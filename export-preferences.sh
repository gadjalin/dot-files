#!/bin/bash

# Spoiler, I don't have much experience with bash scripting

function get_greet_time()
{
   local hour=$(date "+%H")
   
   if [[ hour -ge 19 ]] || [[ hour -lt 5 ]]; then
      local greet_time="evening"
   elif [[ hour -ge 5 ]] && [[ hour -lt 12 ]]; then
      local greet_time="morning"
   else
      local greet_time="afternoon"
   fi

   echo $greet_time
}

# It is important to greet people before working with them...
function greet_me()
{
   echo "Good $(get_greet_time) $USER, we will proceed to the exportation of your preferences in the current environment."
}

function goodbye_me()
{
   echo "All seem to have completed successfully. Have a nice day."
}

# Start by checking proper installation of ZSH
# and definition of the $SHELL variable
function check_zsh()
{
   # TODO Find a way to automate zsh installation
   echo -n "Checking zsh... "

   if ! type zsh &> /dev/null; then
      echo "Zsh seems to be missing and should first be installed."
      exit 1
   else
      echo "Zsh is installed !"
   fi
}

function check_shell()
{
   echo -n "Checking shell... "

   if [[ $SHELL != $(which zsh) ]]; then
      echo '$SHELL is not set to zsh !'
      chsh -s $(which zsh)
   else
      echo "Shell is set !"
   fi
}

function check_omzsh()
{
   echo -n "Checking Oh My Zsh... "

   if [[ ! -d ~/.oh-my-zsh ]]; then
      echo "Oh My Zsh is not installed ! Installing now..."
      local omzsh_installer="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
      sh -c $(curl fsSL $omzsh_installer)
   else
      echo "Oh My Zsh is installed !"
   fi
}

function check_zsh_plugins()
{
   local zsh_plugins_path=~/.oh-my-zsh/custom/plugins
   echo "Checking zsh plugins..."

   if [[ ! -d ${zsh_plugins_path}/zsh-autosuggestions ]]; then
      echo "zsh-autosuggestions is missing. Installing now..."
      git clone https://github.com/zsh-users/zsh-autosuggestions $zsh_plugins_path/zsh-autosuggestions
   fi

   if [[ ! -d ${zsh_plugins_path}/zsh-syntax-highlighting ]]; then
      echo "zsh-syntax-highlighting is missing. Installing now..."
      git clone https://github.com/zsh-users/zsh-syntax-highlighting $zsh_plugins_path/zsh-syntax-highlighting
   fi

   echo "You might need to install GNU's source-highlight manually !"
   echo "All plugins installed !"
}

function check_font()
{
   # TODO Find a way to automate font installation
   echo "Remember to install recommended font at https://github.com/romkatv/powerlevel10k-media/"
}

function check_p10k()
{
   echo -n "Checking powerlevel10k... "

   if [[ ! -d ~/powerlevel10k ]]; then
      echo "Powerlevel10k is not installed. Installing now..."
      git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
   fi
}

function check_vim()
{
   # TODO figure out what to check
}

function check_vim_plugins()
{
   # TODO also
}

function export_dot_files()
{
   echo "Exporting dot-files to home directory..."

   cp {./Preferences,~}/.zshrc
   cp {./Preferences,~}/.vimrc
   cp {./Preferences,~}/.p10k.zsh
}

greet_me

check_zsh
check_shell
check_omzsh
check_zsh_plugins
check_font
check_p10k
check_vim
check_vim_plugins
export_dot_files

goodbye_me

