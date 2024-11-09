# dot-files

&nbsp;&nbsp; *"The path towards simplicity often demands that you struggle with making things complicated first."*

---

## How to Use

Simply clone this repository with `git clone https://github.com/AarnoldGad/dot-files.git`
and run `./install.sh` for a full setup.

Note: *Don't execute* `export-preferences.fish`, it will be called by `install.sh` anyway.

## The Story

It has been a long while since I have been thinking of synchronising my shell and vim preferences between my devices and environments.
I also wanted to understand better how bash scripts worked (Even though it is not really difficult and it is easy to find very clear documentation on this subject)
and get a little experience on making these scripts.
So I tried to make a simple installer that does almost everything with just one command, so I can easily install, update and keep track of my favorite configuration.

Note: This was originally made to configure [ZSH](https://www.zsh.org)+[OhMyZsh](https://github.com/ohmyzsh/ohmyzsh) when, while working on it,
I stumbled upon '[Fish](https://fishshell.com)', which I really liked and is much easier to configure rapidly. Hence the .archives folder.

## The Program

This is a simple bash script, followed by a fish script, that install and configure all the programs I use to customise my shell and my text editor (vim) automatically.
There is not *that* much programs and plugins but it is easier to keep track and scale it that way. Gives me peace of mind.

The following operations are performed:

- Install common dependencies for [Fish](https://fishshell.com), [vim](https://www.vim.org),
and [YouCompleteMe](https://github.com/ycm-core/YouCompleteMe), plus a couple extras, including:
  - CMake, GCC/LLVM/build-essential, Go, OpenJDK, autojump, exa, fortune, cowsay, curl, nodejs, python3, npm
- Install [Fish](https://fishshell.com) and [Fisher](https://github.com/jorgebucaran/fisher) (for plugins)
- Install [Tide](https://github.com/IlanCosman/tide) and other plugins:
  - [decors/fish-source-highlight](https://github.com/decors/fish-source-highlight)
- Export config.fish to ~/.config/fish/
- Check vim version and enabled features
- Install vim plugins
- Export .vimrc to home directory
- Additionally export tmux configuration (.tmux.conf) and alacritty
(alacritty.toml)

## TODO

- Automate installation of [custom font](https://github.com/romkatv/powerlevel10k-media) (Currently recommend MesloLGS NF)
- Also [source-highlight](https://www.gnu.org/software/src-highlite)
- Automate compilation of [YCM](https://github.com/ycm-core/YouCompleteMe)

