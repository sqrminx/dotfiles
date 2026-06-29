# dotfiles

Personal macOS dotfiles, managed with GNU Stow.

## Prerequisites

- GNU stow
- ghostty, tmux ≥ 3.2, Neovim ≥ 0.11
- A Nerd Font (configured for Lilex Nerd Font)
- `ripgrep` + `fzf` - Neovim's finder
- `tree-sitter-cli` - builds Neovim's treesitter parsers
- Language servers: `lua-language-server`, `clangd`

```sh
brew install stow tmux neovim ripgrep fzf lua-language-server tree-sitter-cli
```

## Install

```sh
git clone <repo-url> ~/dotfiles && cd ~/dotfiles
make install # stow every package into ~
```

Run `make` to see all targets (install / update / preview / uninstall).
