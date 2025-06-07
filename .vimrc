" Basic settings
syntax enable
set number
set autoindent
set showmatch           " Show matching brackets/braces
set matchtime=1         " Speed up matching

" Indentation for Go
set expandtab
set tabstop=4
set shiftwidth=4

" Plugin manager (vim-plug)
call plug#begin('~/.vim/plugged')

" Essential plugins for Go development
Plug 'fatih/vim-go'            " Go development plugin
Plug 'AndrewRadev/splitjoin.vim'  " Switch between single/multi-line code
Plug 'jiangmiao/auto-pairs'    " Auto-close brackets/quotes
Plug 'preservim/nerdtree'      " File explorer
Plug 'dense-analysis/ale'      " Async linting

call plug#end()

" Go-specific settings
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Disable ALE's automatic checking
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0  " Even disable on save

" Add a key mapping to manually trigger lint
nmap <leader>l :ALELint<CR>

" Auto-formatting on save
" autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting_sync()

" Key mappings
map <C-n> :NERDTreeToggle<CR>
map <C-j> :cnext<CR>
map <C-k> :cprevious<CR>

" Colorscheme
set background=dark
