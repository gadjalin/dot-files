#!/usr/bin/env bash
# It looks like a mess to me, but it seems to work ¯\_(^^)_/¯

DRYRUN=false
PACKMAN="unknown"

if [[ $1 == '--dryrun' ]]; then
    DRYRUN=true
fi

function detect_packman()
{
    # if macOS
    if [[ $OSTYPE == "darwin"* ]]; then
        # If homebrew is installed
        if type brew &> /dev/null; then
            echo -n "Homebrew detected... "
            PACKMAN="homebrew"
        else
            echo "Homebrew is not installed and idk about MacPorts! Aborting."
            exit 1
        fi
    # if linux
    elif [[ $OSTYPE == "linux-gnu" ]]; then
        if [[ -f /etc/lsb-release ]]; then
            local RELEASE_FILE=/etc/lsb-release
            local ID_KEY="DISTRIB_ID"
        elif [[ -f /etc/os-release ]]; then
            local RELEASE_FILE=/etc/os-release
            local ID_KEY="ID"
        else
            echo "Unable to determine linux distribution! Aborting."
            exit 1
        fi

        # The regex do like: DISTRIB_ID="Whatever" -> Whatever
        local distrib=$(cat $RELEASE_FILE | grep -E "^$ID_KEY" | sed -e 's/^[^=]*//; s/^.//; s/"//g')

        if [[ $distrib == "Ubuntu" ]]; then
            echo -n "APT detected... "
            PACKMAN="apt"
        elif [[ $distrib == "Arch" ]]; then
            echo -n "Pacman detected... "
            PACKMAN="pacman"
        elif [[ $distrib == "fedora" ]]; then
            echo -n "DNF detected... "
            PACKMAN="dnf"
        else
            echo "Unsupported linux distribution! Aborting."
            exit 1
        fi
    else
        echo "Unrecognised OS! Aborting."
        exit 1
    fi
}

function check_prerequisites()
{
    if [[ $PACKMAN == "homebrew" ]] && [[ $DRYRUN == false ]]; then
        brew install cmake autojump gcc exa fortune cowsay curl llvm node openjdk vim python || { echo "Errors occured during installation. Aborting."; exit 1; }
    elif [[ $PACKMAN == "apt" ]] && [[ $DRYRUN == false ]]; then
        # TODO: check autojump + vim >9.0 on ppa currently
        sudo apt update && sudo apt install build-essential cmake golang-go openjdk-17-jre openjdk-17-jdk exa fortune cowsay nodejs npm python3 python3-dev vim || { echo "Errors occured during installation. Aborting"; exit 1; }
    elif [[ $PACKMAN == "pacman" ]] && [[ $DRYRUN == false ]]; then
        # TODO check autojump from the AUR
        sudo pacman -Sy base-devel cmake jre-openjdk jdk-openjdk go exa fortune-mod cowsay nodejs npm python vim || { echo "Errors occured during installation. Aborting"; exit 1; }
    elif [[ $PACKMAN == "dnf" ]] && [[ $DRYRUN == false ]]; then
        sudo dnf install @development-tools @development-libs gcc g++ gfortran cmake java-latest-openjdk java-latest-openjdk-devel golang eza fortune-mod cowsay nodejs nodejs-npm python3 python3-devel vim || { echo "Errors occured during installation. Aborting"; exit 1; }
    fi

    echo "Dependencies installed !"
}

function install_fish()
{
    if [[ $PACKMAN == "homebrew" ]] && [[ $DRYRUN == false ]]; then
        brew install fish || { echo "Errors occured during installation. Aborting."; exit 1; }
    elif [[ $PACKMAN == "apt" ]] && [[ $DRYRUN == false ]]; then
        sudo apt-add-repository ppa:fish-shell/release-3 && sudo apt update && sudo apt install fish || { echo "Errors occured during installation. Aborting."; exit 1; }
    elif [[ $PACKMAN == "pacman" ]] && [[ $DRYRUN == false ]]; then
        sudo pacman -Sy fish || { echo "Errors occured during installation. Aborting."; exit 1; }
    elif [[ $PACKMAN == "dnf" ]] && [[ $DRYRUN == false ]]; then
        sudo dnf install fish || { echo "Errors occured during installation. Aborting."; exit 1; }
    else
        echo "Package manager missing! Aborting."
        exit 1
    fi

    if [[ $PACKMAN == "homebrew" ]]; then
        FISH_PATH=/opt/homebrew/bin/fish
    elif [[ $PACKMAN == "apt" ]] || [[ $PACKMAN == "pacman" ]] || [[ $PACKMAN == "dnf" ]]; then
        if [[ -f /usr/local/bin/fish ]]; then
            FISH_PATH=/usr/local/bin/fish
        else
            FISH_PATH=/usr/bin/fish
        fi
    fi

    echo "Fish installed !"

    # Update default shell
    if [[ $DRYRUN == false ]]; then
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

    if [[ $DRYRUN == false ]]; then
        ./export-preferences.fish
    else
        ./export-preferences.fish --dryrun
    fi

    echo "Installation script has ended."
}

detect_packman
check_prerequisites
check_fish

