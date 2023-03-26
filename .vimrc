" Vim config

" look and feel
set background=dark
set wildmenu " when opening a file with e.g. :e ~/.vim<TAB> there is a graphical menu of all the matches
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

" enable mouse mode in all modes
set mouse=a

" Delete characters outside of insert area
set backspace=indent,eol,start

" syntax hilighting
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
set cindent
set smartindent

" folding
set foldmethod=syntax
set foldlevel=99

" Enable folding with the z key
nmap z za

" disable all bells and whistles
set noerrorbells visualbell t_vb=

" Tab Options
set shiftwidth=2
set tabstop=2
set softtabstop=2 " Number of spaces a tab counts when editing
set expandtab

" Delete empty space from the end of lines on every save
autocmd BufWritePre * :%s/\s\+$//e

" Set default encoding to utf-8
set encoding=utf-8
set termencoding=utf-8

" Disable backups and swap files
set nobackup
set nowritebackup
set noswapfile

" hides buffers instead of closing them
set hidden

" wrap
set wrap
set linebreak
set path=**

" igone
set wildignore+=**/node_modules/**

" preview
set previewheight=100

" searching
set ignorecase " ignore case when searching
set smartcase  " when searching try to be smart about cases
set nohlsearch " don't highlight search term
set incsearch  " jumping search

" don't drag comments in new lines
set formatoptions-=cro

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" coc config START
"
" my addition for getting tsc errors with coc Diagnostic
"
command! -nargs=0 Tsc :call CocAction('runCommand', 'tsserver.watchBuild')

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" coc config ENDS

" MAPPINGS
"
" sudo write
"
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
let test#strategy = "vimterminal" " defines how the test is run -> currently uses vim-dispatch
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

" Git Gutter Mappings

" nmap ]h <Plug>(GitGutterLineHighlightsToggle)

" Buffers: Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" File path completion in Insert mode using fzf
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-buffer-line)

" Coc.nvim extensions
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-css', 'coc-tsserver', 'coc-eslint', 'coc-html', 'coc-yank']

" Plugs

call plug#begin('~/.vim/plugged')

" coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'} "LSP integration

" text manipulation
Plug 'tpope/vim-pathogen'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'wellle/targets.vim' " Adds i and a blocks

" file system
Plug 'preservim/nerdtree'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Syntax Hilighting
Plug 'pangloss/vim-javascript' " JavaScript support
Plug 'HerringtonDarkholme/yats.vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " js and jsx syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax
Plug 'prisma/vim-prisma'        " GraphQL syntax

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' " Github :GBrowse

" status line
Plug 'vim-airline/vim-airline'

" quickfix
Plug 'yssl/QFEnter'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

" CSV
Plug 'chrisbra/csv.vim'

" Async commands
Plug 'tpope/vim-dispatch'

" Testing
Plug 'vim-test/vim-test'

" scrolling
Plug 'psliwka/vim-smoothie'

" Screenplays
" Plug 'kblin/vim-fountain'

call plug#end()

" Fix syntax highlight for Coc plugin floating errors
" hi CocErrorFloat guifg=Magenta guibg=Magenta


" Black Magic

" Use OSC52 to put things into the system clipboard, works over SSH.
function! Osc52Yank()
  let buffer=system('base64 -w0', @0)
  let buffer='\ePtmux;\e\e]52;c;.buffer.'\x07\e\\'
  silent exe "!echo -ne ".shellescape(buffer)." > ".shellescape(g:tty)
endfunction
nnoremap <leader>y :call Osc52Yank()<CR>

" show diff between file in edit and its saved version
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
