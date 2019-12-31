" Theme

set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:netrw_banner = 0
let g:netrw_liststyle = 3
colorscheme solarized8_high

" Use iTerm background

if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" Config

syntax enable
filetype plugin indent on
set nu
set wrap
set linebreak
set shiftwidth=8
set path=**
set softtabstop=2
set expandtab
set relativenumber
set noswapfile
set hidden
set hlsearch
set wildignore+=**/node_modules/**
set incsearch

" Mappings
"
" Edit existing file under cursor in vertically split window
nnoremap <C-W><C-F> <C-W>vgf

" Enable copying to clipboard using `CTRL + c`
map <C-c> y:e ~/clipsongzboard<CR>P:w !pbcopy<CR><CR>:bdelete!<CR>

" Add empty line in normal mode with Enter
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Add empty line in normal mode with Enter
nmap <C-J> }
nmap <C-K> {

" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" CtrlP

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_open_new_file = 'v'
let g:ctrlp_show_hidden = 1
let g:ctrlp_abbrev = {
  \ 'gmode': 'i',
  \ 'abbrevs': [
    \ {
      \ 'pattern': ' ',
      \ 'expanded': '',
      \ 'mode': 'pfrz',
    \ },
    \ ]
  \ }

" Gutentags

let g:gutentags_define_advanced_commands = 1
let g:gutentags_file_list_command = 'git ls-files'

" Plugs

call plug#begin('~/.vim/plugged')

Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'vim-scripts/utl.vim'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/taglist.vim'
Plug 'majutsushi/tagbar'
Plug 'chrisbra/NrrwRgn'
Plug 'tpope/vim-pathogen'
Plug 'itchyny/calendar.vim'
Plug 'vim-scripts/SyntaxRange'
Plug 'kien/ctrlp.vim'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'

"tpope art
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rails'

" Change inside
Plug 'wellle/targets.vim'

" IDE magic, autocompletion, linting, language server
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --all' }
Plug 'ludovicchabant/vim-gutentags'
call plug#end()

" Food for thought

" Use OSC52 to put things into the system clipboard, works over SSH.
" function! Osc52Yank()
"   let buffer=system('base64 -w0', @0) 
"   let buffer='\ePtmux;\e\e]52;c;.buffer.'\x07\e\\'
"   silent exe "!echo -ne ".shellescape(buffer)." > ".shellescape(g:tty)
" endfunction
" 
" nnoremap <leader>y :call Osc52Yank()<CR>
"
" Change cursor shape between insert and normal mode in iTerm2.app

" making Go To File work in Javascript
set includeexpr=substitute(v:fname,'zipper-desktop\\(.*\\)','./src\\1.js','')
