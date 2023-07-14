#!/usr/bin/env bash
# It looks like a mess to me, but it seems to work ¯\_(^^)_/¯

dryrun=false
packman="unknown"

if [[ $1 == 'dryrun' ]]; then
    dryrun=true
fi

function detect_packman()
{
    # if macOS
    if [[ $OSTYPE == "darwin"* ]]; then
        # If homebrew is installed
        if type brew &> /dev/null; then
            echo -n "Homebrew detected... "
            packman="homebrew"
        else
            echo "Homebrew is not installed and idk about MacPorts! Aborting."
            exit 1
        fi
    # if linux
    elif [[ $OSTYPE == "linux-gnu" ]]; then
        if [[ -f /etc/lsb-release ]]; then
            # The regex do like: DISTRIB_ID="Whatever" -> Whatever
            local distrib=$(cat /etc/lsb-release | grep DISTRIB_ID | sed -e 's/^[^=]*//' -e 's/^.//' -e 's/"//g')

            if [[ $distrib == "Ubuntu" ]]; then
                echo -n "APT detected... "
                packman="apt"
            elif [[ $distrib == "Arch" ]]; then
                echo -n "Pacman detected... "
                packman="pacman"
            else
                echo "Unsupported linux distribution! Aborting."
                exit 1
            fi
        else
            #TODO if /etc/lsb-release does not exist, do stuff with /etc/os-release or someth' ?
            echo "Unable to determine linux distribution! Aborting."
            exit 1
        fi
    else
        echo "Unrecognised OS! Aborting."
        exit 1
    fi
}

function check_prerequisites()
{
    if [[ $packman == "homebrew" ]] && [[ $dryrun == false ]]; then
        brew install cmake autojump gcc exa fortune cowsay curl llvm node openjdk vim python || { echo "Errors occured during installation. Aborting."; exit 1; }
    elif [[ $packman == "apt" ]] && [[ $dryrun == false ]]; then
        # TODO: check autojump + vim >9.0 on ppa currently
        sudo apt update && sudo apt install build-essential cmake golang-go openjdk-17-jre openjdk-17-jdk exa fortune cowsay nodejs npm python3 python3-dev vim || { echo "Errors occured during installation. Aborting"; exit 1; }
    elif [[ $packman == "pacman" ]] && [[ $dryrun == false ]]; then
        # TODO check autojump from the AUR
        sudo pacman -Sy base-devel cmake jre-openjdk jdk-openjdk go exa fortune-mod cowsay nodejs npm python vim || { echo "Errors occured during installation. Aborting"; exit 1; }
    fi

    echo "Dependencies installed !"
}

function install_fish()
{
    if [[ $packman == "homebrew" ]] && [[ $dryrun == false ]]; then
        brew install fish || { echo "Errors occured during installation. Aborting."; exit 1; }
        FISH_PATH=/opt/homebrew/bin/fish
    elif [[ $packman == "apt" ]] && [[ $dryrun == false ]]; then
        sudo apt-add-repository ppa:fish-shell/release-3 && sudo apt update && sudo apt install fish || { echo "Errors occured during installation. Aborting."; exit 1; }

        if [[ -f /usr/local/bin/fish ]]; then
            FISH_PATH=/usr/local/bin/fish
        else
            FISH_PATH=/usr/bin/fish
        fi
    elif [[ $packman == "pacman" ]] && [[ $dryrun == false ]]; then
        sudo pacman -Sy fish || { echo "Errors occured during installation. Aborting."; exit 1; }

        if [[ -f /usr/local/bin/fish ]]; then
            FISH_PATH=/usr/local/bin/fish
        else
            FISH_PATH=/usr/bin/fish
        fi
    else
        echo "Package manager missing! Aborting."
        exit 1
    fi

    echo "Fish installed !"

    # Update default shell
    if [[ $dryrun == false ]]; then
        if [[ -f $FISH_PATH ]] && [[ -x $FISH_PATH ]]; then
            echo $FISH_PATH | sudo tee -a /etc/shells
            chsh -s $FISH_PATH
        else
            echo "Unable to find fish executable at $FISH_PATH ."
        fi
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

    if [[ $dryrun == false ]]; then
        ./export-preferences.fish
    fi
}

detect_packman
check_prerequisites
check_fish

