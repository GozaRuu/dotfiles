# kais' setup

my terminal lives here. if this repo dies, i'm configuring vim from scratch again and nobody wants that.

## what's in the box

```
.vimrc                    vim — coc.nvim, fzf, solarized8, the old faithful
.config/nvim/init.lua     neovim — lazy.nvim, native LSP, treesitter, the new hotness
.zshrc                    oh-my-zsh + p10k, nvm, bun, aliases i can't live without
.gitconfig                delta pager because default diff is pain
.vim/coc-settings.json    typescript/react coc config (vim only)
vim/spell/en.utf-8.add    so vim stops yelling at "Podspec" and "TypeScript"
```

## new machine speedrun

```bash
git clone git@github.com:GozaRuu/dotfiles.git ~/projects/dotfiles

ln -sf ~/projects/dotfiles/.vimrc ~/.vimrc
ln -sf ~/projects/dotfiles/.zshrc ~/.zshrc
ln -sf ~/projects/dotfiles/.gitconfig ~/.gitconfig
mkdir -p ~/.vim
ln -sf ~/projects/dotfiles/.vim/coc-settings.json ~/.vim/coc-settings.json
ln -sf ~/projects/dotfiles/vim ~/vim

# vim — old faithful
vim +PlugInstall +qa

# neovim — the new hotness
mkdir -p ~/.config/nvim
ln -sf ~/projects/dotfiles/.config/nvim/init.lua ~/.config/nvim/init.lua
nvim +qa  # lazy.nvim auto-installs everything on first launch
```

## prerequisites (brew)

```bash
brew install macvim neovim fzf fd bat ripgrep delta nvm
```

## vim vibes

solarized8 dark + undercurl spell check + vim-markdown with fenced syntax highlighting. arrow keys resize splits because we're not animals.

## zsh vibes

p10k prompt, fzf everywhere, bat for previews, aliases for the lazy:

- `cc` claude code (bypass permissions)
- `ccw` claude code (bypass + worktree)
- `vv` edit vimrc
- `zz` edit zshrc
- `gs` git status
- `gl` git log --oneline
- `grb` recent branches
- `main` checkout main + pull
- `kill_port 3000` when something won't die
