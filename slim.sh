#!/usr/bin/bash



apt-get update

apt-get install -y --no-install-recommends \
  git \
  build-essential \
  wget \
  curl \
  neovim \
  stow \
  ssh \
  fish \
  ca-certificates \
  locales \
  sudo \
  gnupg \
  htop \
  screen \
  unzip \

# # Set locale and timezone if not already set
# : ${LANGUAGE:="en_US.UTF-8"}
# : ${LC_ALL:="en_US.UTF-8"}
# : ${LC_TYPE:="en_US.UTF-8"}
# : ${LANG:="en_US.UTF-8"}
# : ${TZ:="UTC"}

export LC_CTYPE=en_US.UTF-8

export LC_ALL=en_US.UTF-8

# ln -snf "/usr/share/zoneinfo/$TZ" /etc/localtime \
#   && echo "$TZ" > /etc/timezone \
#   && echo "$LANG.UTF-8 UTF-8" > /etc/locale.gen \
#   && locale-gen "$LANG.UTF-8" \
#   && update-locale "LANG=$LANG.UTF-8"

curl -fsSL https://starship.rs/install.sh | sh -s -- -y

# echo " ==> Installing fzf"

git clone https://github.com/junegunn/fzf "${HOME}/.fzf"

pushd "${HOME}/.fzf"

git remote set-url origin git@github.com:junegunn/fzf.git

${HOME}/.fzf/install --bin

popd

cd ~

git clone --recursive https://github.com/ser-ge/dotfiles.git  "${HOME}/dotfiles"


cd "${HOME}/dotfiles"

chmod +x install_dotfiles.sh

./install_dotfiles.sh

# curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
# dpkg -i ripgrep_11.0.2_amd64.deb
