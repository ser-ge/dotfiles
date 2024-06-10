#!/usr/bin/bash
apt-get update
apt-get install -y --no-install-recommends \
  make \
  build-essential \
  wget \
  curl \
  fzf \
  git \
  neovim \
  stow \
  curl \
  ssh \
  fish \ &&
  apt-get clean

curl -sS https://starship.rs/install.sh | sh -s -- --yes

echo " ==> Installing fzf"

git clone https://github.com/junegunn/fzf "${HOME}/.fzf"

pushd "${HOME}/.fzf"

git remote set-url origin git@github.com:junegunn/fzf.git

${HOME}/.fzf/install --bin

popd

cd ~

git clone --recursive https://github.com/ser-ge/dotfiles.git  "${HOME}/dotfiles"

git remote set-url origin git@github.com:serg-e/dotfiles.git

cd "~/dotfiles"
chmod +x install_dotfiles.sh
./install_dotfiles.sh

# curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
# dpkg -i ripgrep_11.0.2_amd64.deb
