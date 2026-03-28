" Vim config

" look and feel
set background=dark
set wildmenu " graphical menu for file tab completion
set ttyfast
set lazyredraw

" fix vim cursor problem
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" spell check for docs
au BufRead,BufNewFile *.md setlocal spell
au BufRead,BufNewFile *.txt setlocal spell
set spellfile=$HOME/vim/spell/en.utf-8.add
set spelloptions+=camel  " spell check understands CamelCase words (Vim 8.2+)

" vim-markdown settings
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_fenced_languages = ['typescript=typescript', 'ts=typescript', 'javascript=javascript', 'js=javascript', 'json=json', 'swift=swift', 'bash=sh', 'shell=sh', 'python=python', 'ruby=ruby', 'yaml=yaml', 'tsx=typescriptreact', 'jsx=javascriptreact', 'dot=dot']
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_no_extensions_in_markdown = 1

" enable mouse mode in all modes
set mouse=a

" Delete characters outside of insert area
set backspace=indent,eol,start

" syntax
syntax enable
filetype plugin indent on

" numbers
set number
set numberwidth=4
set ruler

" vsplit on right
set splitright

" paste mode
nnoremap <F5> :set invpaste paste?<CR>
set pastetoggle=<F5>
set showmode

" treat long lines as break lines
map j gj
map k gk

" indentation
set autoindent
set smartindent

" folding
set foldmethod=syntax
set foldlevel=99

" disable all bells and whistles
set noerrorbells visualbell t_vb=

" Tab Options
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

" Delete trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" encoding
set encoding=utf-8
set termencoding=utf-8

" Disable backups and swap files
set nobackup
set nowritebackup
set noswapfile

set hidden
set wrap
set linebreak
set wildignore+=**/node_modules/**

" searching
set ignorecase
set smartcase
set nohlsearch
set incsearch

" don't drag comments in new lines
set formatoptions-=cro

set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" coc config START

command! -nargs=0 Tsc :call CocAction('runCommand', 'tsserver.watchBuild')

" Tab completion
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show documentation
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Code actions
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
nmap <leader>as  <Plug>(coc-codeaction-source)
nmap <leader>qf  <Plug>(coc-fix-current)

" Refactor
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

nmap <leader>cl  <Plug>(coc-codelens-action)

" Text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Scroll float windows
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" CoCList
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" coc config ENDS

" MAPPINGS

cnoremap sudow w !sudo tee % >/dev/null

" fzf and rg
nnoremap <C-p> :GFiles<Cr>
nnoremap <C-g> :Rg <Cr>
nnoremap <leader> :Rg <CR>

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-m> :NERDTreeFind<CR>

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
let test#strategy = "vimterminal"
let test#vim#term_position = "vsplit"

" move between paragraphs
map <C-J> }
map <C-K> {

" yank file name and line
:nmap cr :let @* = expand("%")<cr>
:nmap cf :let @* = expand("%:p")<cr>
:nmap cn :let @* = expand("%:t")<cr>

" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Disable arrow movement, resize splits instead.
let g:elite_mode=1
if get(g:, 'elite_mode')
    nnoremap <Up>    :resize +2<CR>
    nnoremap <Down>  :resize -2<CR>
    nnoremap <Left>  :vertical resize -2<CR>
    nnoremap <Right> :vertical resize +2<CR>
  endif

inoremap {<cr> {<cr>}<c-o>O<tab>
inoremap [<cr> [<cr>]<c-o>O<tab>
inoremap (<cr> (<cr>)<c-o>O<tab>

" PLUGIN CONFIG

let g:fzf_buffers_jump = 1

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-buffer-line)

" Coc.nvim extensions
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-css', 'coc-tsserver', 'coc-eslint', 'coc-html', 'coc-yank', 'coc-pyright', 'coc-svg', 'coc-prettier', '@yaegassy/coc-tailwindcss3']

" Plugs

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" text manipulation
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'wellle/targets.vim'

" file system
Plug 'preservim/nerdtree'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Syntax
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jparise/vim-graphql'
Plug 'prisma/vim-prisma'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" status line
Plug 'vim-airline/vim-airline'

" quickfix
Plug 'yssl/QFEnter'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" CSV
Plug 'chrisbra/csv.vim'

Plug 'tpope/vim-dispatch'
Plug 'vim-test/vim-test'
Plug 'psliwka/vim-smoothie'
Plug 'tpope/vim-abolish'
Plug 'evanleck/vim-svelte'

" Colorscheme
Plug 'lifepillar/vim-solarized8'

call plug#end()

" --- True color + undercurl support (iTerm2 3.5+) ---
set termguicolors
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"

" --- Colorscheme ---
silent! colorscheme solarized8

" --- Spell highlights (survive colorscheme changes) ---
augroup SpellHighlight
  autocmd!
  autocmd ColorScheme * highlight SpellBad   cterm=undercurl ctermul=167 ctermbg=NONE guisp=#dc322f gui=undercurl guibg=NONE
  autocmd ColorScheme * highlight SpellCap   cterm=undercurl ctermul=110 ctermbg=NONE guisp=#268bd2 gui=undercurl guibg=NONE
  autocmd ColorScheme * highlight SpellRare  cterm=undercurl ctermul=108 ctermbg=NONE guisp=#2aa198 gui=undercurl guibg=NONE
  autocmd ColorScheme * highlight SpellLocal cterm=undercurl ctermul=176 ctermbg=NONE guisp=#d33682 gui=undercurl guibg=NONE
augroup END
doautocmd ColorScheme

" show diff between file in edit and its saved version
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
