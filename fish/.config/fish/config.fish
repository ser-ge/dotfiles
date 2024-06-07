if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path "$HOME/bin"
fish_add_path "/usr/local/bin"
fish_add_path "$HOME/.poetry/bin"
fish_add_path "$HOME/.local/scripts/"
fish_add_path "$HOME/.local/bin/"

export PYTHONBREAKPOINT='pudb.set_trace'
export EDITOR="vi"

if test -f "$HOME/.config/fish/secrets.fish"
    source "$HOME/.config/fish/secrets.fish"
end

set fish_key_bindings fish_user_key_bindings
alias s="sgpt -s"

starship init fish | source
direnv hook fish | source
zoxide init fish | source
fzf --fish | source

