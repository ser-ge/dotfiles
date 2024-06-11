dirs:=$(shell fd -td -d1 .)

docker:
	docker run -it --rm -v "$(pwd)":/scratch debian:latest bash
up:
	stow --stow ${dirs}

down:
	stow --delete ${dirs}

refresh:
	stow --restow ${dirs}

bootstrap: gh-cli ht-rust
	mkdir -p ~/projects &&                         \
	mkdir -p ~/bin &&                              \
	sudo apt-get -y install                        \
	curl 											\
	wget 											\
	bat                                            \
	direnv                                         \
	entr                                           \
	eza                                            \
	fish                                           \
	fzf                                            \
	gcc-c++                                        \
	git                                            \
	gh                                             \
	libyaml-devel                                  \
	make                                           \
	neovim                                         \
	openssl-devel                                  \
	openssl                                        \
	stow                                           \
	tmux                                           \


