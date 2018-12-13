call plug#begin('~/.local/share/nvim/plugged')
" Autocompletion
Plug 'Valloric/YouCompleteMe'

" Syntax highlighting and lang specifics
Plug 'fatih/vim-go' " Syntax and go tool running
Plug 'pangloss/vim-javascript' " Syntax
Plug 'neomake/neomake' " All linting

Plug 'airblade/vim-gitgutter'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzy finder
Plug 'junegunn/fzf.vim' " fuzzy finder
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " file tree
Plug 'Xuyuanp/nerdtree-git-plugin' " Git in nerdtree file browser
Plug 'rking/ag.vim' " silver surfer search
Plug 'easymotion/vim-easymotion' " nice navigation
Plug '907th/vim-auto-save'
call plug#end()


" Misc quality of life improvements
set nocompatible            " Disable compatibility to old-time vi
set showmatch               " Show matching brackets.
set ignorecase              " Do case insensitive matching
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set tabstop=4               " number of columns occupied by a tab character
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set clipboard=unnamedplus   " use system clipboard
set scrolloff=999           " keep cursor centered will scrolling
autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" Go stuff
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_term_enabled = 1
let g:go_list_type = "quickfix"
let g:go_addtags_transform = "camelcase"
let g:go_auto_type_info = 1
let g:go_info_mode = 'gocode'
let g:go_auto_sameids = 1
" YouCompleteMe Autocompletion
let g:ycm_add_preview_to_completeopt = 0 " Turn off preview window
set completeopt-=preview " Just remove preview window completely

" Auto linting
call neomake#configure#automake('nrwi', 500)
let g:neomake_place_signs = 0
let g:neomake_go_enabled_makers = [ 'go', 'gometalinter' ]
let g:neomake_python_enabled_makers = [ 'python', 'flake8']
let g:neomake_python_flake8_maker = { 'args': ['--ignore=C0301,E501'] }

" Autosave
let g:auto_save = 1

" Swap ; and : for easier commands
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Pane movement
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" Resizing
nnoremap <M-h> :vertical resize -1<CR>
nnoremap ˙ :vertical resize -1<CR>
nnoremap <M-j> :resize -1<CR>
nnoremap ∆ :resize -1<CR>
nnoremap <M-k> :resize +1<CR>
nnoremap ˚ :resize +1<CR>
nnoremap <M-l> :vertical resize +1<CR>
nnoremap ¬ :vertical resize +1<CR>
nnoremap <S-h> :tabp<CR>
nnoremap <S-l> :tabn<CR>
nnoremap <S-k> :tabe<CR>
" Quick access
nnoremap <C-t> :terminal<CR>

" Searching
nnoremap <C-f> :FZF<CR>

" Bind space to the leader key
let mapleader = "\<Space>"

" NerdTree
nnoremap <Leader>f :NERDTreeToggle<Enter>
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Sset theme and make work in tmux
set background=dark " or light if you prefer the light version
let g:two_firewatch_italics=1
colo two-firewatch
set termguicolors

" More responsive
set lazyredraw
