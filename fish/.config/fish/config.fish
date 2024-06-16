if status is-interactive
    # Commands to run in interactive sessions can go here

end

set -g fish_key_bindings fish_vi_key_bindings
set -g fish_cursor_insert "line"

bind yy fish_clipboard_copy
bind p fish_clipboard_paste

fish_add_path "$HOME/bin"
fish_add_path "/usr/local/bin"
fish_add_path "$HOME/.poetry/bin"
fish_add_path "$HOME/.local/scripts/"
fish_add_path "$HOME/.local/bin/"
fish_add_path "$HOME/.cargo/bin"

# python
fish_add_path $PYENV_ROOT/bin
set -Ux PYENV_ROOT $HOME/.pyenv
pyenv init - | source
export PYTHONBREAKPOINT='pudb.set_trace'
export POETRY_CONFIG_DIR='~/.config/pypoetry'

# node
set --universal nvm_default_version v22.2.0

export EDITOR="vi"

export TMS_CONFIG_FILE="$HOME/.config/tms/config.toml"

if test -f "$HOME/.config/fish/secrets.fish"
    source "$HOME/.config/fish/secrets.fish"
end

abbr --add new_notebook "python -m jupyter_ascending.scripts.make_pair --base"

abbr --add ss "source .venv/bin/activate.fish"

alias s="sgpt -s"
alias weather='curl wttr.in/london'

set fish_key_bindings fish_user_key_bindings
starship init fish | source
direnv hook fish | source
zoxide init fish | source
fzf --fish | source
