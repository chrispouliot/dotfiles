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

" plugins start ----------

call plug#begin('~/.local/share/nvim/plugged')

" Base for all completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Use deoplete.
let g:deoplete#enable_at_startup = 1

Plug 'zchee/deoplete-jedi'
let g:python_host_prog = '/Users/christophepouliot/.pyenv/versions/2.7.8/envs/neovim2/bin/python'
let g:python3_host_prog = '/Users/christophepouliot/.pyenv/versions/3.6.2/envs/neovim3/bin/python'

Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'fatih/vim-go'
Plug 'neomake/neomake'

" Git
Plug 'airblade/vim-gitgutter'

" Themes
Plug 'rafi/awesome-vim-colorschemes'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'rking/ag.vim'

Plug 'easymotion/vim-easymotion'

Plug '907th/vim-auto-save'

call plug#end()

" plugins end ---------


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
"let g:go_updatetime = 5000
let g:go_info_mode = 'gocode'
let g:go_auto_sameids = 1

call neomake#configure#automake('nrwi', 500)

" Autosave
let g:auto_save = 1

" Swap ; and : for easier commands
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Searching
nnoremap <C-f> :FZF<CR>

" Bind space to the leader key
let mapleader = "\<Space>"

" NerdTree
nnoremap <Leader>f :NERDTreeToggle<Enter>
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

set background=dark " or light if you prefer the light version
let g:two_firewatch_italics=1
colo two-firewatch
set termguicolors

