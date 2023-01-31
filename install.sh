#!/usr/bin/env bash

# I have no idea if this work, but the idea should be here ¯\_(^^)_/¯

debug=false

if [[ $1 == 'debug' ]]; then
    debug=true
fi

function install_fish()
{
    # Try detect os and package manager to install fish
    if [[ $OSTYPE == "darwin"* ]]; then
        if type brew &> /dev/null; then
            echo -n "Homebrew detected... "

            if [[ $debug == false ]]; then
                brew install fish || { echo "Errors occured during installation. Aborting."; exit 1; }
                FISH_PATH=/opt/homebrew/bin/fish
            fi

            echo "Fish installed !"
        else
            echo "Homebrew is not even installed and idk about MacPorts. Aborting."
            exit 1
        fi
    elif [[ $OSTYPE == "linux-gnu" ]]; then
        if [[ -f /etc/lsb-release ]]; then
            local distrib=$(cat /etc/lsb-release | grep DISTRIB_ID | sed -e 's/^[^=]*//' -e 's/^.//' -e 's/"//g')

            if [[ $distrib == "Ubuntu" ]]; then
                echo -n "APT detected... "

                if [[ $debug == false ]]; then
                    sudo apt-add-repository ppa:fish-shell/release-3 && sudo apt update && sudo apt install fish || { echo "Errors occured during installation. Aborting."; exit 1; }
                    if [[ -f /usr/local/bin/fish ]]; then
                        FISH_PATH=/usr/local/bin/fish
                    else
                        FISH_PATH=/usr/bin/fish
                    fi
                fi

                echo "Fish installed !"
            elif [[ $distrib == "Arch" ]]; then
                echo -n "Pacman detected... "
                
                if [[ $debug == false ]]; then
                    sudo pacman -Sy fish || { echo "Errors occured during installation. Aborting."; exit 1; }
                    if [[ -f /usr/local/bin/fish ]]; then
                        FISH_PATH=/usr/local/bin/fish
                    else
                        FISH_PATH=/usr/bin/fish
                    fi
                fi

                echo "Fish installed !"
            else
                echo "Idk other distributions yet"
                exit 1
            fi
        else
            #TODO stuff with /etc/os-release or someth' ?
            echo "Oops, got stuff to do here !"
            exit 1
        fi
    else
        echo "Unrecognised OS."
        exit 1
    fi

    # Update default shell
    if [[ $debug == false ]]; then
        if [[ -f $FISH_PATH ]] && [[ -x $FISH_PATH ]]; then
            echo $FISH_PATH | sudo tee -a /etc/shells
            chsh -s $FISH_PATH
        else
            echo "Can't find fish executable at $FISH_PATH"
        fi
    fi
}

function check_prerequisites()
{
    # Might as well install everything
    # Kind of redundant with above code install_fish but heh

    # Try detect os and package manager to install fish
    if [[ $OSTYPE == "darwin"* ]]; then
        if type brew &> /dev/null; then
            echo -n "Homebrew detected... "

            if [[ $debug == false ]]; then
                brew install cmake autojump gcc exa fortune cowsay curl llvm node openjdk vim python || { echo "Errors occured during installation. Aborting."; exit 1; }
            fi

            echo "Dependencies installed !"
        else
            echo "Homebrew is not even installed and idk about MacPorts. Aborting."
            exit 1
        fi
    elif [[ $OSTYPE == "linux-gnu" ]]; then
        if [[ -f /etc/lsb-release ]]; then
            local distrib=$(cat /etc/lsb-release | grep DISTRIB_ID | sed -e 's/^[^=]*//' -e 's/^.//' -e 's/"//g')

            if [[ $distrib == "Ubuntu" ]]; then
                echo -n "APT detected... "

                if [[ $debug == false ]]; then
                    # TODO check autojump + vim >9.0 on ppa currently
                    sudo apt update && sudo apt install build-essential cmake golang-go openjdk-17-jre openjdk-17-jdk exa fortune cowsay nodejs npm python3 python3-dev || { echo "Errors occured during installation. Aborting"; exit 1; }
                fi

                echo "Dependencies installed !"
            elif [[ $distrib == "Arch" ]]; then
                echo -n "Pacman detected... "

                if [[ $debug == false ]]; then
                    # TODO check autojump from the AUR
                    sudo pacman -Sy base-devel cmake jre-openjdk jdk-openjdk go exa fortune-mod cowsay nodejs npm python || { echo "Errors occured during installation. Aborting"; exit 1; }
                fi

                echo "Dependencies installed !"
            else
                echo "Idk other distributions yet"
                exit 1
            fi
        else
            #TODO stuff with /etc/os-release or someth' ?
            echo "Oops, got stuff to do here !"
            exit 1
        fi
    else
        echo "Unrecognised OS."
        exit 1
    fi
}

function check_fish()
{
    if ! type fish &> /dev/null; then
        echo -n "Fish seems to be missing. Installing now... "

        install_fish
    else
        echo "Fish is already installed ! Proceeding with exportation..."
    fi

    if [[ $debug == false ]]; then
        ./export-preferences.fish
    fi
}

check_prerequisites
check_fish

