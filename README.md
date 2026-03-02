# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Fresh install

```sh
curl -fsSL https://raw.githubusercontent.com/serg-e/dotfiles/master/install.sh | bash
```

## Common commands

```sh
make bootstrap        # install tools + stow configs
make up               # stow all packages (symlink configs)
make down             # remove all symlinks
make refresh          # re-stow (after adding new files)
make packages         # re-sync tools on a running machine (no stow)
make packages-cleanup # uninstall brew packages no longer in Brewfile (macOS)
```

## Adding / removing packages

| What | Where |
|------|-------|
| macOS tool | `Brewfile` → `brew bundle` |
| Linux tool (apt/dnf) | `packages.linux` → re-run bootstrap |
| Linux tool (curl/cargo) | `extras.sh` |
| Config symlink | `packages.sh` |

### Linux curl / cargo installs

These aren't in `packages.linux` because distro packages lag too far behind.
To add/remove one, edit `extras.sh` — copy an existing block as a template.

| Tool | Method | Why not apt |
|------|--------|-------------|
| neovim | GitHub tarball | apt version too old |
| starship | curl installer | not in apt |
| zoxide | curl installer | not in apt |
| rustup | curl installer | canonical, no alternative |
| tms | `cargo install` | requires rust |

## Packages

Stow packages: `fish` `git` `nvim` `bash` `starship` `tmux` `tms` `tmate` `alacritty` `ptpython` `pudb` `pypoetry`

## Docker

```sh
make docker-build   # build dotfiles image
make docker-run     # interactive fish shell in the image
make docker-test    # smoke-test bootstrap.sh in a clean Debian container
make docker         # dev shell with repo mounted (iterate on bootstrap.sh)
```

To use in another image:

```dockerfile
FROM dotfiles          # build on top of the dotfiles image

# or curl install (no local image needed):
RUN curl -fsSL https://raw.githubusercontent.com/serg-e/dotfiles/master/install.sh | bash
```
