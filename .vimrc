" 打開語法突顯
syntax on

" load plguin
" install vim-plug:
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
" 這個是明天的東西，先註解掉，才不會出錯
" so ~/.config/nvim/plugin.vim

" 256 色
set t_Co=256
" 解決和 tmux 衝突，https://vi.stackexchange.com/questions/238/tmux-is-changing-part-of-the-background-in-vim
set t_ut=
" 選一個你喜歡的 colorschema
" available color schema
" blue darkblue default delek desert elflord evening industry koehler
" morning  murphy pablo peachpuff ron shine slate torte zellner
colorscheme koehler

" 雜項設定，詳細解說請用 `:help <opeion>`，例如 `:help showcmd`
set showcmd
set nu
set tabstop=4
set shiftwidth=4
set autoindent
set nowrap
set incsearch
set autoindent
set cindent
set smartindent
set cursorline
" make lightline work in single screen
" https://github.com/itchyny/lightline.vim/issues/71#issuecomment-47859569
set laststatus=2
" 開啟滑鼠功能，對初學者來說非常好用
set mouse=a

" markdown
" 如果是檔案類型是 markdown 或 text，打開文字折疊（超出螢幕寬度會折到下一行）
" au 的語法等等會講
au FileType markdown set wrap
au FileType text set wrap

" ejs
" 不加這個的話 ejs 的語法突顯會很奇怪，順便附帶一個 ft, filetype 的坑
" https://vi.stackexchange.com/questions/16341/what-is-the-difference-between-set-ft-and-setfiletype
au BufNew,BufNewFile,BufRead *.ejs :set filetype=ejs
au FileType ejs set syntax=html

" ts 
" 這只是因為我比較喜歡 vim 對 javascript 的配色，typesript 的我覺得很醜，所以強制 vim 用 javascript 的配色
" au 就是 autocmd 的縮寫啦！（vim 幾乎每個超過三個字的命令、選項都有縮寫，寫程式的人都很懶XD）
autocmd BufNewFile,BufRead *.ts set syntax=javascript

" yaml
" yaml 機車的空格限制，這樣在寫 yaml 檔時比較方便
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" hotkey
" 這邊是自訂快捷鍵，語法等等會講，這邊只說明用法
" 在命令模式按 <tab> 會把整行字向右移一個 tab。<S-tab> 會移回來
map <tab> :s/^/\t<CR>
map <S-tab> :s/^\t/<CR>
"  如果要從系統剪貼簿貼上多行程式碼，建議這樣用，才不會被 vim 的自動縮排雷到（你試試就知道是什麼問題，很討厭）
nmap <F3> :r! cat<CR>
" 切換行號，在複製到系統鍵貼簿時很好用，這樣就不會複製到行號
nmap <F7> :set invnumber<CR>
" 清除搜尋結果的語法突顯
nmap cs :noh<CR>

" alias
" 冒號命令的別名，語法等等會講
" 常用就知道為什麼要設這個（按冒號時要按 <shift>，然後下一個字就很常變大寫，簡稱手殘）
command W w
command Q q
command Wq wq
command WQ wq

" fix bg color error in Pmenu
" 這個只是顯示問題，有時候背景色和前景色一樣你就看不到字了，所以要自己把他換掉，語法等等會講
" https://vi.stackexchange.com/questions/23328/change-color-of-coc-suggestion-box
let g:airline_theme = 'ouo'
hi Pmenu ctermbg=black ctermfg=white
hi Ignore ctermbg=black ctermfg=lightblue

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
Plug 'preservim/nerdcommenter'

call plug#end()
