" ++++++++++++++++++++++++一个伟大的vim配置将从这里开始+++++++++++++++++++++++++++++
" 抄袭自："hit9/dotfiles" | LittleKey/k-vim

let mapleader = ','
let g:mapleader = ','

" 取消备份。 视情况自己改
set nobackup
" 关闭交换文件
" 突出显示当前列
set cursorcolumn
" 突出显示当前行
set cursorline

" 设置 退出vim后，内容显示在终端屏幕, 可以用于查看和复制, 不需要可以去掉
" 好处：误删什么的，如果以前屏幕打开，可以找回
set t_ti= t_te=
set noswapfile
" ==================== plugin ==========================
set nocompatible               " be iMproved
filetype off                   " required!
call plug#begin('~/.vim/bundle')

"--------- Colorscheme
Plug 'tomasr/molokai'
Plug 'cocopon/iceberg.vim'
Plug 'w0ng/vim-hybrid'
Plug 'zeis/vim-kolor'
Plug 'NLKNguyen/papercolor-theme'
Plug 'junegunn/seoul256.vim'
Plug 'jacoborus/tender.vim'
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'

" --------- View
" airline
" 状态栏增强展示
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" rainbow_parentheses
" 括号显示增强
Plug 'kien/rainbow_parentheses.vim'

" --------- Tools

"验证
Plug 'littlekey/validator.vim' 

" auto complete
" 代码自动补全
" completor for vim8
Plug 'maralla/completor.vim', {'do': 'make js'}
" 自动补全单引号，双引号等
Plug 'Raimondi/delimitMate'
" quick edit
" 快速注释
Plug 'scrooloose/nerdcommenter'
" 快速去行尾空格 [, + <Space>]
Plug 'bronson/vim-trailing-whitespace'
" 更高效的行内移动, f/F/t/T, 才触发
" quickscope
Plug 'unblevable/quick-scope'




call plug#end()


" Theme config
" Color config
set background=dark
set t_Co=256
" colorscheme base16-tomorrow
colorscheme molokai

set pastetoggle=<F5>            "    when in insert mode, press <F5> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented

" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste
" rainbow_parentheses {{{
    " 不加入这行, 防止黑色与深蓝括号出现, 很难识别
    " \ ['black',       'SeaGreen3'],
    " \ ['Darkblue',    'SeaGreen3'],
    let g:rbpt_colorpairs = [
        \ ['brown',       'RoyalBlue3'],
        \ ['darkgreen',   'firebrick3'],
        \ ['darkcyan',    'RoyalBlue3'],
        \ ['darkred',     'SeaGreen3'],
        \ ['lightyellow', 'SeaGreen3'],
        \ ['lightred',    'RoyalBlue3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['red',         'firebrick3'],
        \ ]

    let g:rbpt_max = 16
    let g:rbpt_loadcmd_toggle = 0
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces
" }}}



" Arrline config
" validator.vim {{{
    " checker
    " let g:validator_error_symbol = '>>'
    " let g:validator_warning_symbol = '>'
    " let g:validator_style_error_symbol = '>>'
    " let g:validator_style_warning_symbol = '>'
    " let g:validator_auto_open_quickfix = 1
    function! AirlineInit()
      let g:validator_error_msg_format = "[● %d/%d errors]"
      let g:validator_warning_msg_format = "[● %d/%d warnings]"
      call airline#parts#define_function('validator', 'validator#get_status_string')
      let g:airline_section_error = airline#section#create(['validator']) "disable syntastic
    endfunction
    autocmd User AirlineAfterInit call AirlineInit()

    let g:validator_python_checkers = ['flake8']
    " ################### 基础 ######################

    " falke8 ignore args
    let flake8_ignore_args = '--ignore=E225,W503,H405,H306,H301,H201,H404,F812 --max-line-length=79'
    let g:validator_python_flake8_args = flake8_ignore_args

    let g:validator_javascript_checkers = ['eslint']

    let g:validator_sh_checkers = ['shellcheck']

    " let g:validator_c_checker = ['clang-tidy']

    " let g:validator_filetype_map = {"py.j2": "python"}
    " 使用littlekey修改版validator.vim
    " g:validator_ignore 会检查文件类型与文件是否包含关键字
    let g:validator_ignore = ['java', 'ControlP']

    let g:validator_permament_sign = 1
" }}}


" F5 set paste问题已解决, 粘贴代码前不需要按F5了
" F5 粘贴模式paste_mode开关,用于有格式的代码粘贴
" Automatically set paste mode in Vim when pasting in insert mode
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" quick edit

" ################### 快速编码 ###################

" nerdcommenter {{{
    let g:NERDSpaceDelims=1
    let g:NERDAltDelims_python = 1
" }}}


" trailingwhitespace {{{
    map <leader><space> :FixWhitespace<cr>
" }}}
"
" ################### 显示增强 ###################

" airline {{{
    " need install powerline font for terminal
    " https://github.com/littlekey/fonts
    " recommend font: Source Code Pro
    " (https://github.com/littlekey/fonts/tree/master/SourceCodePro)
    let g:airline_theme = 'molokai'
    let g:airline_powerline_fonts = 1
    " 是否打开tabline
    let g:airline#extensions#tabline#enabled = 1
" }}}
"
"
" quickscope {{{
    let g:qs_highlight_on_keys = ['f', 'F']
    " macvim/gvim会有问题, 暂时注解
    " let g:qs_first_occurrence_highlight_color = '#afff5f' " gui vim
    let g:qs_first_occurrence_highlight_color = 155       " terminal vim
    " let g:qs_second_occurrence_highlight_color = '#5fffff'  " gui vim
    let g:qs_second_occurrence_highlight_color = 81         " terminal vim
" }}}

" 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


"Treat long lines as break lines (useful when moving around in them)
""se swap之后，同物理行上线直接跳
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
"==========================================
" Display Settings 展示/排版等界面格式设置
"==========================================

" 显示当前的行号列号
set ruler
" 在状态栏显示正在输入的命令
set showcmd
" 左下角显示当前vim模式
set showmode

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=7

" set winwidth=79

" 命令行（在状态行下）的高度，默认为1，这里是2
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
" Always show the status line - use 2 lines for the status bar
set laststatus=2

" 显示行号
set number
" 取消换行
set nowrap

" 括号配对情况, 跳转并高亮一下匹配的括号
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2

" 设置文内智能搜索提示
" 高亮search命中的文本
set hlsearch
" 打开增量搜索模式,随着键入即时搜索
set incsearch
" 搜索时忽略大小写
set ignorecase
" 有一个或以上大写字母时仍大小写敏感
set smartcase

" 缩进配置
" Smart indent
"set smartindent   " Smart indent
"set autoindent    " 打开自动缩进
set cindent
" never add copyindent, case error   " copy the previous indentation on autoindenting
set autoindent

" tab相关变更
" 设置Tab键的宽度        [等同的空格个数]
set tabstop=4
" 每一次缩进对应的空格数
set shiftwidth=4
" 按退格键时可以一次删掉 4 个空格
set softtabstop=4
" insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set smarttab
" 将Tab自动转化成空格[需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set expandtab
" 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'
set shiftround

function! TAB(size)
  " 设置Tab键的宽度        [等同的空格个数]
  execute "set tabstop=".a:size
  " 每一次缩进size个空格数
  execute "set shiftwidth=".a:size
  " 按退格键时可以一次删掉 size 个空格
  execute "set softtabstop=".a:size
endfunc

autocmd FileType * :call TAB(2)                        " default Tabsize
autocmd FileType py,python :call TAB(4)                " python Tabsize
autocmd FileType ruby :call TAB(2)                     " ruby Tabsize
autocmd FileType vim :call TAB(2)                      " vimrc Tabsize
autocmd FileType html :call TAB(2)                     " html Tabsize
autocmd FileType javascript,typescript :call TAB(2)    " typescript javascript Tabsize
autocmd FileType js,ts,cs,coffee,jsx :call TAB(2)      " typescript javascript coffeescript Tabsize
autocmd FileType c,h :call TAB(2)                      " c Tabsize
autocmd FileType cpp,hpp,cc,cxx :call TAB(2)           " cpp Tabsize
autocmd FileType java :call TAB(2)                     " java Tabsize

" 使用F7切换是否使用空格代替tab(或tab代替空格)
function! TabToggle()
  if(&expandtab == 1)
    set noexpandtab
    retab!
  else
    set expandtab
    retab
  endif
endfunc
nnoremap <F7> :call TabToggle()<CR>

" A buffer becomes hidden when it is abandoned
set hidden
set wildmode=list:longest
set ttyfast

" 00x增减数字时使用十进制
set nrformats=

" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  else
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

"==========================================
" HotKey Settings  自定义快捷键设置
"==========================================

" 主要按键重定义

" 关闭方向键, 强迫自己用 hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

"Treat long lines as break lines (useful when moving around in them)
"se swap之后，同物理行上线直接跳
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" F1 - F6 设置

" F1 废弃这个键,防止调出系统帮助
" I can type :help on my own, thanks.  Protect your fat fingers from the evils of <F1>
noremap <F1> <Esc>"

" F2 行号开关，用于鼠标复制代码用
" 为方便复制，用<F2>开启/关闭行号显示:
function! HideNumber()
  if(&relativenumber == &number)
    set relativenumber! number!
  elseif(&number)
    set number!
  else
    set relativenumber!
  endif
  set number?
endfunc
nnoremap <F2> :call HideNumber()<CR>
" F3 显示可打印字符开关
nnoremap <F3> :set list! list?<CR>
" F4 换行开关
nnoremap <F4> :set wrap! wrap?<CR>

" F6 语法开关，关闭语法可以加快大文件的展示
nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

set pastetoggle=<F5>            "    when in insert mode, press <F5> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented

" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste

" F5 set paste问题已解决, 粘贴代码前不需要按F5了
" F5 粘贴模式paste_mode开关,用于有格式的代码粘贴
" Automatically set paste mode in Vim when pasting in insert mode
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()



" 分屏窗口移动, Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" http://stackoverflow.com/questions/13194428/is-better-way-to-zoom-windows-in-vim-than-zoomwin
" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>z :ZoomToggle<CR>


" Go to home and end using capitalized directions
noremap H ^
noremap L $


" Map ; to : and save a million keystrokes 用于快速进入命令行
nnoremap ; :


" 命令行模式增强，ctrl - a到行首， -e 到行尾
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>


" 搜索相关
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
" 进入搜索Use sane regexes"
nnoremap / /\v
vnoremap / /\v

" Keep search pattern at the center of the screen.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" 去掉搜索高亮
noremap <silent><leader>/ :nohls<CR>

" switch # *
nnoremap # *
nnoremap * #

" for # indent, python文件中输入新行时#号注释不切回行首
autocmd BufNewFile,BufRead *.py inoremap # X<c-h>#

" tab/buffer相关

" 切换前后buffer
nnoremap [b :bprevious<cr>
nnoremap ]b :bnext<cr>
" 使用方向键切换buffer
noremap <left> :bp<CR>
noremap <right> :bn<CR>


" tab 操作
" http://vim.wikia.com/wiki/Alternative_tab_navigation
" http://stackoverflow.com/questions/2005214/switching-to-a-particular-tab-in-vim

" tab切换
map <leader>th :tabfirst<cr>
map <leader>tl :tablast<cr>

map <leader>tj :tabnext<cr>
map <leader>tk :tabprev<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprev<cr>

map <leader>te :tabedit<cr>
map <leader>td :tabclose<cr>
map <leader>tm :tabm<cr>

" normal模式下切换到确切的tab
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Toggles between the active and last active tab "
" The first tab is always 1 "
let g:last_active_tab = 1
" nnoremap <leader>gt :execute 'tabnext ' . g:last_active_tab<cr>
" nnoremap <silent> <c-o> :execute 'tabnext ' . g:last_active_tab<cr>
" vnoremap <silent> <c-o> :execute 'tabnext ' . g:last_active_tab<cr>
nnoremap <silent> <leader>tt :execute 'tabnext ' . g:last_active_tab<cr>
autocmd TabLeave * let g:last_active_tab = tabpagenr()

" 新建tab  Ctrl+t
nnoremap <C-t>     :tabnew<CR>
inoremap <C-t>     <Esc>:tabnew<CR>


" => 选中及操作改键

" 调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv

" y$ -> Y Make Y behave like other capitals
map Y y$

" 复制选中区到系统剪切板中
vnoremap <leader>y "+y

" auto jump to end of select
" vnoremap <silent> y y`]
" vnoremap <silent> p p`]
" nnoremap <silent> p p`]

" w!! to sudo & write a file
cmap w!! w !sudo tee >/dev/null %

" kj 替换 Esc
inoremap kj <Esc>

" 滚动Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>


" Jump to start and end of line using the home row keys
" 增强tab操作, 导致这个会有问题, 考虑换键
" nmap t o<ESC>k
" nmap T O<ESC>j

" Quickly close the all window
nnoremap <leader>q :qa<CR>

" Quickly save the current file
nnoremap <leader>w :wa<CR>

" 交换 ' `, 使得可以快速使用'跳到marked位置
nnoremap ' `
nnoremap ` '

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" close buffer
nmap <Leader>bd :bd<CR>

"==========================================
" FileType Settings  文件类型设置
"==========================================

" 具体编辑文件类型的一般设置，比如不要 tab 等
autocmd FileType python :call TAB(4)
autocmd FileType ruby,javascript,html,css,xml,go :call TAB(2)
autocmd FileType python,ruby,javascript,html,css,xml,go set expandtab ai
autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown set filetype=markdown.mkd
autocmd BufRead,BufNewFile *.part set filetype=html
" disable showmatch when use > in php
au BufWinEnter *.php set mps-=<:>



" 保存python文件时删除多余空格
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()


" 定义函数AutoSetFileHead，自动插入文件头
autocmd BufNewFile *.sh,*.py,*.rb,*.qml exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    " 如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    " 如果文件类型为python
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(1, "\# encoding: utf-8")
    endif

    " 如果文件类型为ruby
    if &filetype == 'ruby'
      call setline(1, "\#!/usr/bin/env ruby")
      call append(1, "\#encoding: utf-8")
    endif

    " 如果文件类新为qml
    if &filetype ==  'qml'
      call setline(1, "import QtQuick 1.0")
    endif

    normal G
    normal o
    normal o
endfunc


" 设置可以高亮的关键字
if has("autocmd")
  " Highlight TODO, FIXME, NOTE, etc.
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
  endif
endif
" 设置标记一列的背景颜色和数字一行颜色一致
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" for error highlight，防止错误整行标红导致看不清
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline
