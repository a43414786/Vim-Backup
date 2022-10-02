set timeoutlen=1000 ttimeoutlen=0
call plug#begin('~/.vim/plugged')
Plug 'dense-analysis/ale'
let g:ale_echo_cursor = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
Plug 'maralla/completor.vim'
let g:completor_clang_binary = '/usr/bin/clang'
inoremap <expr> <TAB> pumvisible() ?"\<C-n>": "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ?"\<C-p>": "\<S-TAB>"
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'ouo'
call plug#end()
