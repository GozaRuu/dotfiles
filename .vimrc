" Theme
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:netrw_banner = 0
let g:netrw_liststyle = 3
colorscheme solarized8_high


" Spell Check
set spelllang=en
set spellfile=$HOME/vim/spell/en.utf-8.add

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
set shiftwidth=2
set path=**
set softtabstop=2
set expandtab
set relativenumber
set noswapfile
set hidden
set wildignore+=**/node_modules/**
set previewheight=100
set autochdir
" searching
set hlsearch
set incsearch
set ignorecase
" don't drag comments in new lines
set formatoptions-=cro

" exprimental 
set mmp=5000


" autocmd FileType ruby let b:coc_suggest_disable = 1



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


" coc-yank
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Copy full file path to clipboard
"
:command! Cpb let @+ = expand('%:p')



" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" MAPPINGS
"
" sudo write
"
cnoremap sudow w !sudo tee % >/dev/null

" Edit existing file under cursor in vertically split window
nnoremap <C-W><C-F> <C-W>vgf

" Enable copying to clipboard using `CTRL + c`
map <C-c> y:e ~/clipsongzboard<CR>P:w !pbcopy<CR><CR>:bdelete!<CR>

" Add empty line in normal mode with Enter
" nmap <CR> o<Esc>

" Fzf and family
nnoremap <silent> <c-p> :FzfGFiles<CR>
nnoremap <silent> <leader>F :FzfFiles!<CR>
:command Rg :FzfRg

" move between paragraphs
map <C-J> }
map <C-K> {

" yank file name and line
function! CopyFileAndLine()
  let @+ = expand('%:p').':'.line('.')
endfunction
inoremap <silent> <F6> <Esc>:call CopyFileAndLine()<CR>
nnoremap <silent> <F6> :call CopyFileAndLine()<CR>

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

" Git Gutter Mappings

" nmap ]h <Plug>(GitGutterLineHighlightsToggle)

" PLUGIN CONFIG

" Fzf
let g:fzf_command_prefix = 'Fzf'

" Buffers: Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" File path completion in Insert mode using fzf
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-buffer-line)

" use preview when FzfFiles runs in fullscreen
command! -nargs=? -bang -complete=dir FzfFiles
  \ call fzf#vim#files(<q-args>, <bang>0 ? fzf#vim#with_preview('up:60%') : {}, <bang>0)
command FzfChanges call s:fzf_changes()

" Typescript-vim
let g:typescript_indent_disable = 1


" Coc.nvim extensions
" let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-css', 'coc-solargraph', 'coc-tsserver', 'coc-eslint', 'coc-eslint', 'coc-html', 'coc-python', 'coc-powershell', 'coc-prettier', 'coc-yank']
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-css', 'coc-solargraph', 'coc-tsserver', 'coc-eslint', 'coc-eslint', 'coc-html', 'coc-python', 'coc-prettier', 'coc-yank', 'coc-elixir']

" Plugs
call plug#begin('~/.vim/plugged')

Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'vim-scripts/utl.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-pathogen'
Plug 'itchyny/calendar.vim'
Plug 'vim-scripts/SyntaxRange'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

" Search Art
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'

" Powershell
Plug 'PProvost/vim-ps1'

" JS and TS
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'

" ReStructuredText
Plug 'rykka/riv.vim'

" Elixir
Plug 'elixir-editors/vim-elixir'

" Nim
Plug 'zah/nim.vim'

" CoffeeScript
Plug 'kchmck/vim-coffee-script'

" coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'

"tpope art
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Rails
Plug 'tpope/vim-rails'
Plug 'slim-template/vim-slim'

" Change inside
Plug 'wellle/targets.vim'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

" Screenplays
Plug 'kblin/vim-fountain'
call plug#end()


" NetRW
let g:NetrwIsOpen=0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction
map <C-n> :call ToggleNetrw()<cr>
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

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
