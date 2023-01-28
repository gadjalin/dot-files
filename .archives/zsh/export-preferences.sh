#!/bin/bash

# Spoiler, I don't have much experience with bash scripting

# Isn't there an other word to say that I want to execute the program without it installing anything as it would otherwise do ?
debug=false

if [[ $1 == 'debug' ]]; then
   debug=true
fi

function get_greet_time()
{
   local hour=$(date "+%H")
   
   if [[ $hour -ge 19 ]] || [[ $hour -lt 5 ]]; then
      local greet_time="evening"
   elif [[ $hour -ge 5 ]] && [[ $hour -lt 12 ]]; then
      local greet_time="morning"
   else
      local greet_time="afternoon"
   fi

   echo $greet_time
}

# It is important to greet people before working with them...
function greet_me()
{
   echo -n "Good $(get_greet_time) $USER, "

   if [[ $debug == true ]]; then
      echo "we will debug the program."
   else
      echo "we will proceed to the exportation of your preferences in the current environment."
   fi
}

# ...and saying goodbye
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
      echo -n "Zsh seems to be missing and should first be installed. "
      
      if [[ $debug == false ]]; then
         echo "TODO auto-install zsh"
      fi

      exit 1
   fi

   echo "Zsh is installed !"
}

function check_shell()
{
   echo -n "Checking shell... "

   if [[ $SHELL != $(which zsh) ]]; then
      echo -n '$SHELL is not set to zsh. Doing it now... '

      if [[ $debug == false ]]; then
         chsh -s $(which zsh)
      fi
   fi

   echo "Shell is set !"
}

function check_omzsh()
{
   echo -n "Checking Oh My Zsh... "

   if [[ ! -d ~/.oh-my-zsh ]]; then
      echo -n "Oh My Zsh was not detected. Installing now... "

      if [[ $debug == false ]]; then
         sh -c $(curl fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)
      fi
   fi

   echo "Oh My Zsh is installed !"
}

function check_zsh_plugins()
{
   local zsh_plugins_path=~/.oh-my-zsh/custom/plugins
   echo "Checking zsh plugins..."

   if [[ ! -d ${zsh_plugins_path}/zsh-autosuggestions ]]; then
      echo "zsh-autosuggestions is missing. Installing now..."

      if [[ $debug == false ]]; then
         git clone https://github.com/zsh-users/zsh-autosuggestions $zsh_plugins_path/zsh-autosuggestions
      fi
   fi

   if [[ ! -d ${zsh_plugins_path}/zsh-syntax-highlighting ]]; then
      echo "zsh-syntax-highlighting is missing. Installing now..."

      if [[ $debug == false ]]; then
         git clone https://github.com/zsh-users/zsh-syntax-highlighting $zsh_plugins_path/zsh-syntax-highlighting
      fi
   fi

   echo "(You might need to install GNU's source-highlight manually !)"
   echo "All plugins installed !"
}

function check_font()
{
   echo "Remember to install recommended font at https://github.com/romkatv/powerlevel10k-media/"

   if [[ $debug == false ]]; then
      echo "TODO Find a way to automate font installation"
   fi
}

function check_p10k()
{
   echo -n "Checking powerlevel10k... "

   if [[ ! -d ~/powerlevel10k ]]; then
      echo -n "Powerlevel10k was not detected. Installing now... "

      if [[ $debug == false ]]; then
         git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
      fi
   fi

   echo "Powerlevel10k is installed !"
}

function export_shell()
{
   echo "Exporting shell dot-files..."

   if [[ $debug == false ]]; then
      cp {./dot-files,~}/.zshrc
      cp {./dot-files,~}/.p10k.zsh
   fi
}

function check_vim()
{
   echo -n "Checking VIM... "

   if ! type vim &> /dev/null; then
      echo "Vim is not installed."

      if [[ $debug == false ]]; then
         echo "TODO Automate installation"
      fi

      exit 1
   fi

   local vim_major=$(vim --version | head -n1 | sed -e 's/^[^0-9]*//' -e 's/\..*//')

   if [[ $vim_major -lt 9 ]]; then
      echo "VIM is not up to date: must be >9.0 !"
      exit 1
   fi

   echo "Vim installed and up to date !"
}

function check_vim_features()
{
   echo -n "Checking vim features... "

   # For Yggdroot/indentLine
   local has_conceal=$(vim --version | grep "+conceal" | sed 's/ .*//')

   if [[ -z $has_conceal ]]; then
      echo "VIM is missing a feature: conceal"
      exit 1
   fi

   echo "VIM has all required features !"
}

function check_vim_plugins()
{
   echo -n "Checking vim plugins... "

   if [[ ! -d ~/.vim/bundle/Vundle.vim ]]; then
      echo -n "Vundle was not detected. Installing now... "

      if [[ $debug == false ]]; then
         git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
      fi
   fi

   echo "VIM plugins installed !"
}

function export_vim()
{
   echo "Exporting VIM dot-files..."

   if [[ $debug == false ]]; then
      cp {./dot-files,~}/.vimrc
   fi
}

function configure_vim()
{
   echo -n "Now configuring vim... "

   #vim +PluginInstall +qa
}

greet_me

check_zsh
check_shell
check_omzsh
check_zsh_plugins
check_font
check_p10k
export_shell

check_vim
check_vim_features
check_vim_plugins
export_vim
configure_vim

goodbye_me

