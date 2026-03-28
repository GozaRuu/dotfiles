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

### 1. brew

```bash
brew install macvim neovim fzf fd bat ripgrep delta nvm
brew install --cask font-hack-nerd-font
```

### 2. iterm2

- **Font**: Settings > Profiles > Text > Font > `Hack Nerd Font Mono`
  (needed for icons in neovim markdown rendering, nvim-tree, lualine, etc.)

### 3. clone + symlink

```bash
git clone git@github.com:GozaRuu/dotfiles.git ~/projects/dotfiles

# shell
ln -sf ~/projects/dotfiles/.zshrc ~/.zshrc
ln -sf ~/projects/dotfiles/.gitconfig ~/.gitconfig

# vim
ln -sf ~/projects/dotfiles/.vimrc ~/.vimrc
mkdir -p ~/.vim
ln -sf ~/projects/dotfiles/.vim/coc-settings.json ~/.vim/coc-settings.json
ln -sf ~/projects/dotfiles/vim ~/vim
vim +PlugInstall +qa

# neovim
mkdir -p ~/.config/nvim
ln -sf ~/projects/dotfiles/.config/nvim/init.lua ~/.config/nvim/init.lua
nvim +qa  # lazy.nvim auto-installs everything on first launch
```

### 4. oh-my-zsh + p10k

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
p10k configure
```

### 5. node

```bash
nvm install --lts
npm install -g typescript
```

### 6. bun

```bash
curl -fsSL https://bun.sh/install | bash
```

## vim (old faithful)

solarized8 dark + coc.nvim LSP + undercurl spell check + vim-markdown with fenced syntax highlighting. arrow keys resize splits because we're not animals.

keybindings: `<C-p>` fzf files, `<C-g>` ripgrep, `<C-n>` NERDTree, `gd` go to definition, `K` hover docs, `<leader>rn` rename

## neovim (the new hotness)

solarized dark + native LSP via mason + treesitter for syntax + lazy.nvim plugin manager. same keybindings as vim — muscle memory carries over.

what's different from vim:
- treesitter replaces all syntax plugins (one plugin, all languages)
- native LSP replaces coc.nvim (no node.js middleman)
- nvim-cmp replaces coc completion
- gitsigns.nvim replaces gitgutter
- lualine replaces airline
- nvim-tree replaces NERDTree
- render-markdown.nvim gives pretty markdown with heading icons
- Comment.nvim replaces vim-commentary
- nvim-surround replaces vim-surround

keybindings: identical to vim. `<C-p>`, `<C-g>`, `<C-n>`, `gd`, `K`, `<leader>rn` — all the same.

## zsh aliases

- `cc` claude code (bypass permissions)
- `ccw` claude code (bypass + worktree)
- `vv` edit vimrc
- `zz` edit zshrc
- `gs` git status
- `gl` git log --oneline
- `grb` recent branches
- `main` checkout main + pull
- `kill_port 3000` when something won't die
- `oports` show listening ports
