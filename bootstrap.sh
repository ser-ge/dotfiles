#!/usr/bin/bash
sudo apt-get update

sudo apt-get install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev  libsqlite3-dev  wget  curl fzf  llvm  libncurses5-dev  libncursesw5-dev  xz-utils  tk-dev  libffi-dev  liblzma-dev  python-openssl  git  python3-pip  python3-dev  python3-dev  neovim  yarn  neovim  python3-neovim  postgresql  postgresql-contrib  libpq-dev  mosh  redis-server  libc6  libglapi-mesa  libxdamage1  libxfixes3  libxcb-glx0  libxcb-dri2-0  libxcb-dri3-0  libxcb-present0  libxcb-sync1  libxshmfence1  libxxf86vm1  stow -y -qq --no-install-recommends

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

if [ ! -d "${HOME}/.config/fish" ]; then
  sudo apt install -y fish
  sudo apt-add-repository ppa:fish-shell/release-3
  sudo apt update
  sudo apt install fish
fi


if [ ! -d "${HOME}/.fzf" ]; then
  echo " ==> Installing fzf"
  git clone https://github.com/junegunn/fzf "${HOME}/.fzf"
  pushd "${HOME}/.fzf"
  git remote set-url origin git@github.com:junegunn/fzf.git
  ${HOME}/.fzf/install --bin --64
  popd
fi

echo "==> Setting shell to fish..."
echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)

echo "==> Creating dev directories"
mkdir -p ~/setup/

if [ ! -d ~/dotfiles ]; then
  echo "==> Setting up dotfiles"
  # the reason we dont't copy the files individually is, to easily push changes
  # if needed
  cd "~/setup"
  git clone --recursive https://github.com/ser-ge/dotfiles.git

  cd "~/setup/dotfiles"
  git remote set-url origin git@github.com:serg-e/dotfiles.git

  ln -sfn $(pwd)/.config "${HOME}/.config"
  ln -sfn $(pwd)/.zshrc  "${HOME}/.zshrc"
  ln -sfn $(pwd)/.gitconfig  "${HOME}/.gitconfig"
  ln -sfn $(pwd)/.p10k.zsh "${HOME}/.p10k.zsh"
  ln -sfn $(pwd)/.tmux.conf "${HOME}/.tmux.conf"

  #VimPlug
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

if ! command -v rg &> /dev/null; then
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
    sudo dpkg -i ripgrep_11.0.2_amd64.deb
fi

if ! command -v mosh &> /dev/null; then
    sudo apt install mosh -y
fi

#poetry
if [ ! -d "${HOME}/.poetry" ]; then
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3
fi

if ! grep -qF 'export PATH=$HOME/.poetry/bin:$PATH' ${HOME}/.zshrc; then
    echo 'export PATH=$HOME/.poetry/bin:$PATH' >> ~/.zshrc
fi



# pyenv


if [ ! -d "${HOME}/.pyenv" ]; then
    echo "==> Setting up pyenv"
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
    ~/.pyenv/bin/pyenv install 3.8.3
    ~/.pyenv/bin/pyenv virtualenv 3.8.3 system-py-3.8.3
    ~/.pyenv/bin/pyenv global system-py-3.8.3
    pip install --upgrade pip
    pip install neovim pynvim black
fi

if ! grep -qF 'PYENV_ROOT' ${HOME}/.zshrc; then
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
fi
