#!/usr/bin/bash
sudo apt-get update

sudo apt-get install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev  libsqlite3-dev  wget  curl fzf  llvm  libncurses5-dev  libncursesw5-dev  xz-utils  tk-dev  libffi-dev  liblzma-dev  python-openssl  git  python3-pip  python3-dev  python3-dev  neovim  yarn  neovim  python3-neovim  postgresql  postgresql-contrib  libpq-dev  mosh  redis-server  libc6  libglapi-mesa  libxdamage1  libxfixes3  libxcb-glx0  libxcb-dri2-0  libxcb-dri3-0  libxcb-present0  libxcb-sync1  libxshmfence1  libxxf86vm1  stow -y -qq --no-install-recommends

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

if [ -x "$(command -v fish)" ]; then
  sudo apt install -y fish
  sudo apt-add-repository ppa:fish-shell/release-3
  sudo apt update
  sudo apt install fish
fi


if [ ! -x "$(command -v fzf)" ]; then
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


if [ ! -d ~/dotfiles ]; then
  echo "==> Setting up dotfiles"
  # the reason we dont't copy the files individually is, to easily push changes
  # if needed
  cd "~"
  git clone --recursive https://github.com/ser-ge/dotfiles.git

  cd "~/dotfiles"

  git remote set-url origin git@github.com:serg-e/dotfiles.git

fi

if ! command -v rg &> /dev/null; then
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
    sudo dpkg -i ripgrep_11.0.2_amd64.deb
fi


#poetry
if [ ! -d "${HOME}/.poetry" ]; then
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3
fi

if ! grep -qF 'export PATH=$HOME/.poetry/bin:$PATH' ${HOME}/.zshrc; then
    echo 'export PATH=$HOME/.poetry/bin:$PATH' >> ~/.zshrc
fi


# pyenv
if [ ! -x "${command -v pyenv)" ]; then
    echo "==> Setting up pyenv"
    curl https://pyenv.run | bash
fi
