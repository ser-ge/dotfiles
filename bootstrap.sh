#!/usr/bin/bash
sudo apt-get update

sudo
apt-get
install
sudo apt-get install make -y -qq --no-install-recommends
sudo apt-get install build-essential -y -qq --no-install-recommends
sudo apt-get install libssl-dev -y -qq --no-install-recommends
sudo apt-get install zlib1g-dev -y -qq --no-install-recommends
sudo apt-get install libbz2-dev -y -qq --no-install-recommends
sudo apt-get install libreadline-dev -y -qq --no-install-recommends
sudo apt-get install libsqlite3-dev -y -qq --no-install-recommends
sudo apt-get install wget -y -qq --no-install-recommends
sudo apt-get install curl -y -qq --no-install-recommends
sudo apt-get install fzf -y -qq --no-install-recommends
sudo apt-get install llvm -y -qq --no-install-recommends
sudo apt-get install libncurses5-dev -y -qq --no-install-recommends
sudo apt-get install libncursesw5-dev -y -qq --no-install-recommends
sudo apt-get install xz-utils -y -qq --no-install-recommends
sudo apt-get install tk-dev -y -qq --no-install-recommends
sudo apt-get install libffi-dev -y -qq --no-install-recommends
sudo apt-get install liblzma-dev -y -qq --no-install-recommends
sudo apt-get install python3-openssl -y -qq --no-install-recommends
sudo apt-get install git -y -qq --no-install-recommends
sudo apt-get install python3-pip -y -qq --no-install-recommends
sudo apt-get install python3-dev -y -qq --no-install-recommends
sudo apt-get install python3-dev -y -qq --no-install-recommends
sudo apt-get install neovim -y -qq --no-install-recommends
sudo apt-get install yarn -y -qq --no-install-recommends
sudo apt-get install neovim -y -qq --no-install-recommends
sudo apt-get install python3-neovim -y -qq --no-install-recommends
sudo apt-get install postgresql -y -qq --no-install-recommends
sudo apt-get install postgresql-contrib -y -qq --no-install-recommends
sudo apt-get install libpq-dev -y -qq --no-install-recommends
sudo apt-get install mosh -y -qq --no-install-recommends
sudo apt-get install redis-server -y -qq --no-install-recommends
sudo apt-get install libc6 -y -qq --no-install-recommends
sudo apt-get install libglapi-mesa -y -qq --no-install-recommends
sudo apt-get install libxdamage1 -y -qq --no-install-recommends
sudo apt-get install libxfixes3 -y -qq --no-install-recommends
sudo apt-get install libxcb-glx0 -y -qq --no-install-recommends
sudo apt-get install libxcb-dri2-0 -y -qq --no-install-recommends
sudo apt-get install libxcb-dri3-0 -y -qq --no-install-recommends
sudo apt-get install libxcb-present0 -y -qq --no-install-recommends
sudo apt-get install libxcb-sync1 -y -qq --no-install-recommends
sudo apt-get install libxshmfence1 -y -qq --no-install-recommends
sudo apt-get install libxxf86vm1 -y -qq --no-install-recommends

if [ ! -d "${HOME}/.zsh" ]; then
  sudo apt install -y zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  echo " ==> Installing zsh plugins"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

if [ ! -d "${HOME}/Dropbox" ]; then
    pushd "${HOME}" && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
    popd
fi

if [ ! -d "${HOME}/.fzf" ]; then
  echo " ==> Installing fzf"
  git clone https://github.com/junegunn/fzf "${HOME}/.fzf"
  pushd "${HOME}/.fzf"
  git remote set-url origin git@github.com:junegunn/fzf.git
  ${HOME}/.fzf/install --bin --64 --no-bash --no-zsh --no-fish
  popd
fi

echo "==> Setting shell to zsh..."
chsh -s /usr/bin/zsh

echo "==> Creating dev directories"
mkdir -p /root/code

if [ ! -d /root/code/dotfiles ]; then
  echo "==> Setting up dotfiles"
  # the reason we dont't copy the files individually is, to easily push changes
  # if needed
  cd "/root/code"
  git clone --recursive https://github.com/serg-e/dotfiles.git

  cd "/root/code/dotfiles"
  git remote set-url origin git@github.com:serg-e/dotfiles.git

  ln -sfn $(HOME)/dotfiles/.config "${HOME}/.config"
  ln -sfn $(HOME)/dotfiles/.zshrc  "${HOME}/.zshrc"
  ln -sfn $(HOME)/dotfiles/.gitconfig  "${HOME}/.gitconfig"
  ln -sfn $(HOME)/dotfiles/.p10k.zsh "${HOME}/.p10k.zsh"
  ln -sfn $(HOME)/dotfiles/.tmux.conf "${HOME}/.tmux.conf"

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
