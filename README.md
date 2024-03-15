# build

```sh
apt update
apt install -y build-essential apt-utils ca-certificates libssl-dev unzip unrar \
        ninja-build gettext libtool-bin cmake g++ pkg-config curl wget git net-tools tree \
        python3-pip python3-venv xclip xsel xauth exuberant-ctags cscope python3-flake8 \
        ripgrep golang libclang-dev python3-opencv nodejs npm
apt build-dep -y neovim

pip3 install neovim
```

# install package

```
1. mod ~/.gitconfig --> comment off the insteadof
2. start nzl proxy
3. nvim
```

# issues

1.  has("python3") == 0

```
pip3 install neovim
```

sudo apt install sqlite3 fd-find
sudo apt install nodejs npm
sudo apt install python3-venv
