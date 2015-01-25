"gvim setting
"colorscheme desert
"set guifont=mingliu:h12

"security
set nomodeline


" 游標移動後, 一樣可以用 backspace, del 等刪除動作
set bs=2

" 過長不要斷行
set nowrap

" 搜尋到的字加 hilight
set hlsearch
set incsearch

" 忽略大小寫, 都可以搜尋到
"set ignorecase

" terminal title 會設為 filename
set title

set runtimepath=~/.vim,$VIMRUNTIME
set history=50

filetype on
"set path+=/home/y/share/pear
"set path+=/var/phplib
set number
set cindent
"set autoindent
"set smartindent

" \t 會以 4個空格代替
set expandtab
set shiftwidth=4

set softtabstop=4
set tabstop=4

" :sp 開檔時, 上面會列出所有檔案
set wildmenu

" 可以用 {{{ }}} 縮排 Folded
set foldmarker={{{,}}}
set foldmethod=marker

" Remove trailing whitespaces
" map \ :%s/[     ]*$//g
map \ :%s/\s*$//g

" {{{ syntax highlight
syntax on
":highlight 可以看到所有的顏色
" 顏色 Templates
"colorscheme default
"colorscheme desert
"hi Comment ctermbg=black ctermfg=darkcyan
"hi Comment ctermbg=7 ctermfg=0 term=reverse cterm=reverse
"hi Comment ctermfg=darkcyan
hi Comment term=standout cterm=bold ctermfg=0
" /usr/share/vim/vim70/colors/desert.vim
highlight Search term=reverse ctermbg=3 ctermfg=0
highlight Normal ctermbg=black ctermfg=white
"highlight Folded term=bold ctermbg=2 ctermfg=7
highlight Folded ctermbg=black ctermfg=darkcyan

hi Cursor ctermbg=Gray ctermfg=Blue
"hi Visual ctermbg=yellow ctermfg=blue
"hi Visual cterm=bold ctermbg=darkcyan ctermfg=yellow
highlight clear SpellBad
highlight SpellBad term=underline cterm=underline ctermfg=red
"set background=light
"colorscheme desert
" }}}

" {{{ 下面出現一列 bar.
set ls=2
set statusline=%<%f\ %m%=\ %h%r\ %-19([%p%%]\ %3l,%02c%03V%)%y
"highlight StatusLine ctermfg=2 ctermbg=0
"highlight StatusLine ctermfg=blue ctermbg=white
highlight StatusLine term=bold,reverse cterm=bold,reverse
" }}}
" {{{ 像 ultraedit 一樣有一列的顏色
" Line highlight
set cursorline
" Column highlight
" set cursorcolumn
"highlight CursorLine cterm=none ctermbg=blue
"highlight CursorLine cterm=none ctermbg=7 ctermfg=0
"highlight CursorLine cterm=none ctermbg=4 ctermfg=7
highlight CursorLine cterm=none ctermbg=4
" }}}
" {{{ UTF-8 Big5 Setting
" 檔案存檔會存成utf-8編碼
" "set fileencoding=utf-8
" "
" " 以下四個設下去. vim 編出來都是 utf-8 編碼的.
"set fileencoding=utf-8
"set fileencodings=big5,utf-8
"set termencoding=utf-8
"設定自動轉換為 UTF-8 編碼
" vim 新開的檔案預設是 utf-8 編碼(寫檔)
set fileencoding=utf-8
" vim 新開的檔案預設是 utf-8 編碼(讀檔)
set fileencodings=utf-8,big5,euc-jp,gbk,euc-kr,utf-bom,iso8859-1
" 內部在用的encode(vim 內部在用的 encode)
set encoding=utf8
set tenc=utf8
" 使用 <F12> 來將文字編碼轉換成 Big5
map <F12> :set tenc=big5<cr>

" vim 啟動後，是使用 utf-8 編碼
" 所有可能的編碼

" set termencoding=big5
" 當 Terminal.app 的 Display > encoding 是設成 Big5-hkscs，也就是說 terminal
" 會把鍵盤的輸入以 big5 編碼方式送到 vim 時，vim 需要有這個設定，才會將 big5 的輸入
" 轉成上面設定的 utf-8 編碼。如果你的 Terminal.app 是用 utf-8
" 編碼，則可忽略此項。
" }}}
" {{{ For PHP Hot Key
" Map ; to run PHP parser check
"noremap ; :!php -l %<CR>
" Map <CTRL>-P to run actual file with PHP CLI
"noremap <C-P> :w!<CR>:!php %<CR>
" Map <CTRL>-M to search phpm for the function name currently under the cursor (insert mode only)
"inoremap <C-H> <ESC>:!phpm <C-R>=expand("<cword>")<CR><CR>
" Automatic close char mapping
"inoremap  { {<CR>}<C-O>O
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>
" }}}
" {{{ 直接按 F8 (Tlist, function list)
"source $HOME/.vim/phpdoc.vim
"ctags apt-get install exuberant-ctags
" }}}
" {{{ ctrl + n, ctrl + p(會自動把function列出)
set dictionary-=~/.vim/funclist.txt
set complete-=k complete+=k
" }}}
" {{{ 會自動到最後離開的位置
if has("autocmd")
    autocmd BufRead *.txt set tw=78
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal g'\"" |
    \ endif
endif
" }}}
" {{{ save .vimrc, auto exec, .vimrc 如果存檔, 就會立刻實現

autocmd! bufwritepost .vimrc source %
" }}}
" {{{ mail 的話自動開啟 spell 功能
"autocmd FileType mail setlocal spell
" }}}
highlight TabLine ctermbg=blue
highlight TabLineFill ctermbg=green
highlight TabLineSel ctermbg=red

autocmd BufWritePre * :%s/\s\+$//e
