# dotfiles

My Neovim and tmux configuration, with a script that installs it on macOS or Linux.

## Credits

This is not my original work. Both configs come from
[craftzdog/dotfiles](https://github.com/craftzdog/dotfiles) by Takuya Matsuyama
([devaslife](https://www.devas.life/)), taken from his `feat/late-2026` branch
(Neovim 0.12 with the native `vim.pack` plugin manager). All credit for the
design goes to him.

What I changed on top of it:

- `config/nvim-craftzdog/lua/craftzdog/plugins/local.lua`: my additions
  (PHP/Symfony, Twig, Python, Jupyter notebooks, a file tree, surround)
- `config/tmux/tmux-private.conf`: my tmux key bindings
- Copilot removed

## Try it in Docker

To try the config without installing anything on your machine, build the Linux
sandbox (a couple of minutes the first time) and open a shell in it:

```bash
docker build -t dotfiles .
docker run -it --rm dotfiles
```

Inside the container, run `cvim .`. To try it on one of your own projects,
mount it:

```bash
docker run -it --rm -v "$PWD":/work -w /work dotfiles
```

Icons need a [Nerd Font](https://www.nerdfonts.com/) in your terminal. There is
no macOS container (Docker only runs Linux): on a Mac, install it directly, it
goes in its own folder and leaves your existing Neovim untouched.

## Requirements

`install.sh` never installs system packages. It lists what is missing and stops.

| Required                              | Optional                       |
| ------------------------------------- | ------------------------------ |
| Neovim 0.12+, tree-sitter CLI 0.26.1+ | PHP + Composer (PHP support)   |
| git, curl, tar, gzip, unzip           | Python 3 with venv (notebooks) |
| a C compiler, Node.js + npm           | ripgrep, fd, lazygit, tmux     |

macOS:

```bash
brew install neovim tree-sitter-cli node ripgrep fd lazygit tmux php composer
```

Debian / Ubuntu (their Neovim and tree-sitter packages are too old, so those two
go in `~/.local`, which must be in your `PATH`):

```bash
sudo apt install git curl tar gzip unzip build-essential nodejs npm \
  python3 python3-venv php-cli php-xml php-mbstring php-curl composer \
  ripgrep fd-find tmux

mkdir -p ~/.local/bin
curl -fsSL https://github.com/neovim/neovim/releases/download/v0.12.2/nvim-linux-x86_64.tar.gz | tar -xz -C ~/.local
ln -s ~/.local/nvim-linux-x86_64/bin/nvim ~/.local/bin/nvim
curl -fsSL https://github.com/tree-sitter/tree-sitter/releases/download/v0.27.1/tree-sitter-linux-x64.gz | gunzip > ~/.local/bin/tree-sitter
chmod +x ~/.local/bin/tree-sitter
```

## Install

```bash
git clone https://github.com/MaxencePeq/dotfiles.git
cd dotfiles
./install.sh --check   # only lists what is missing
./install.sh           # installs
```

The script copies the configs to `~/.config`, adds a `cvim` alias, then
downloads the plugins and language servers. An existing config is renamed
with a `.backup-<date>` suffix, never overwritten.

## Usage

```bash
cvim .
```

The config lives in `~/.config/nvim-craftzdog`, so it does not replace a
regular `~/.config/nvim`.
