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
filetype plugin on

" 彩色的 status bar
Plug 'itchyny/lightline.vim'
"  有這個設定 lightline 在單個 vim 視窗中才會正常，沒錯！vim 也可以分割視窗，後天會講
set laststatus=2

" 在行號左側會顯示這行的 git 狀態，新增、刪除、修改，詳細請看 GitHub README
Plug 'airblade/vim-gitgutter'

" 按下 <F5> 可以開啟檔案樹，按 h 有說明，再一下關掉說明
Plug 'scrooloose/nerdtree'
nmap <F5> :NERDTreeToggle<CR>
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
			\ quit | endif

" 自動括號
Plug 'jiangmiao/auto-pairs'
" 這是自訂括號的寫法
au FileType ejs let b:AutoPairs = AutoPairsDefine({'<%': '%>', '<!--': '-->'})
au FileType html let b:AutoPairs = AutoPairsDefine({'<!--': '-->'})

" 之前講過了，這邊附上一些設定
Plug 'preservim/nerdcommenter'
filetype plugin on
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCustomDelimiters = { 'ejs': { 'left': '<!--','right': '-->' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" 按 <F6> 可以回朔到開啟檔案以來的任何歷史，還會標出修改的地方，很酷
Plug 'mbbill/undotree'
nnoremap <F6> :UndotreeToggle<CR>

" <F8> 看看你設定了哪些變數、函數，也可以快速跳轉
Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

" 用 <反斜線 f> 可以整理程式碼（要裝 python3 和 pynvim，詳細請看 GitHub ）
" $ python3 -m pip install pynvim
Plug 'Chiel92/vim-autoformat'
" 這裡指定成你的 python3 路徑
let g:python3_host_prog="/usr/bin/python3"
nmap <leader>f :Autoformat<CR>

" 在你開啟 markdown 文件時會開啟網頁預覽你的 markdown，有雙螢幕或是把畫面讓一半給瀏覽器比較好用（需要裝 nodejs）
" $ npm -g install instant-markdown-d
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

" 快速整理程式碼，這個外掛的功能超多，但是因為有 autoformat 所以我只用排 md 表格的功能，他可以幫你把垂直線對齊，舒舒服服，要深入使用請看 GitHub README
" 先用選取模式把表格選起來，按兩下反斜線就可以得到一個漂亮的表格
Plug 'junegunn/vim-easy-align'
" Align GitHub-flavored Markdown tables
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

" 快速建立 html tag，用法非常靈活，明天會專門講他的用法
Plug 'mattn/emmet-vim'

Plug 'Valloric/YouCompleteMe'

call plug#end()
