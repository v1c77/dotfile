" ++++++++++++++++++++++++一个伟大的vim配置将从这里开始+++++++++++++++++++++++++++++
" 抄袭自："hit9/dotfiles" | LittleKey/k-vim
set nocompatible               " must on tap
filetype off                   " required!


" ==================== plugin ==========================
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
Plug 'dracula/vim'
Plug 'altercation/vim-colors-solarized'

" --------- View
" airline
" 状态栏增强展示
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" rainbow_parentheses
" 括号显示增强
Plug 'kien/rainbow_parentheses.vim'

" --------- Tools

Plug 'littlekey/validator.vim'  "验证
" 代码自动补全
" completor for vim8
Plug 'maralla/completor.vim', {'do': 'make js'}
Plug 'Raimondi/delimitMate'     " 自动补全单引号，双引号等
Plug 'scrooloose/nerdcommenter' " 快速注释
Plug 'bronson/vim-trailing-whitespace' " 快速去行尾空格 [, + <Space>]
Plug 'unblevable/quick-scope'   " 更高效的行内移动, f/F/t/T, 才触发
Plug 'scrooloose/nerdtree'      " 目录树


call plug#end()

" ==================== Foundation Config =======================

" 针对不同的文件类型加载对应的插件
filetype plugin indent on       " 针对不同的文件类型采用不同的缩进格式

let mapleader = ','
let g:mapleader = ','

set nobackup                    " 取消备份。 视情况自己改
set cursorcolumn                " 突出显示当前列
set cursorline                  " 突出显示当前行
set showcmd                     " 显示输入的命令
set showmode                    " 显示当前模式
set noeb                        " 关闭警报音
set autoread                    " 外部修改后自动更新
set shortmess=atI               " 关闭启动时提示
set autochdir                   " 自动切换当前目录为当前文件所在目录

" 设置 退出vim后，内容显示在终端屏幕, 可以用于查看和复制, 不需要可以去掉
" 好处：误删什么的，如果以前屏幕打开，可以找回 强迫症可以去掉
" set t_ti=t_te=
set noswapfile

syntax on                       " 设置高亮
set synmaxcol=200               " 200字符以上的行不高亮
set backspace=indent,eol,start  " 设置退格键的工作方式
set whichwrap=<,>,h,l           " 允许跨界的操作
set gdefault                    " 行内替换
set hlsearch                    " 高亮最近的匹配搜索
set incsearch                   " 实时检索
set ignorecase                  " 搜索时忽略大小写
set smartcase                   " 有一个或以上大写字母时仍大小写敏感
set laststatus=2                " 总是显示状态栏
set hidden                      " 有未保存内容时打开新文件，当前file隐藏而不是关闭
set ttyfast                     " 快速的终端链接


" ------------ Theme && color scheme config
set t_Co=256
let g:solarized_termcolors=256  " 主题配色
set background=dark             " dark & light 两色可选
colorscheme solarized
set title                       " vim可以设置终端标题

" ------------- 编码
set encoding=utf-8              " vim 内部编码
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbkgb2312,cp936  " 新建一个文件的默认编码
set termencoding=utf-8          " 输入到终端的编码
set fileencoding=utf-8          " vim 写入文件的时候采用的编码

" ------------ 缩进
set autoindent                  " 自动缩进
set cindent                     " ctype indent
set smartindent                 " 智能缩进： 每行与前一行有相同缩进
set pastetoggle=<F5>            " 插入模式中的文本粘贴模式
au InsertLeave * set nopaste    " disbale paste mode when leaving insert mode
function! XTermPasteBegin()     " iTerm 等终端插入模式下自动进入粘贴模式
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
set expandtab                   " 输入的tab自动转换为空格
set tabstop=4                   " 1tab=4space
set softtabstop=4               " 1 ture tab = 8space
set shiftwidth=4                " 每一层级间为一个tab
set list                        " 显示tab
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮ " 真实tab的填充字符
"根据文件类型设定缩进,覆盖掉默认的~,来自humiaozuzu
autocmd FileType text setlocal textwidth=79
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=79
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=79
autocmd FileType coffee,javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=79
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=79
autocmd FileType html,htmldjango,xhtml,haml setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
autocmd FileType sass,scss,css setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=79
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4 textwidth=79
"
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

" ------------ 鼠标
set mouse=a                     " 我无法离开触摸板
set selection=exclusive         " 鼠标可以改变光标位置
set selectmode=mouse,key        " 两种选择模式
set mousehide                   " 键盘输入则隐藏鼠标
set mousemodel=popup            " 右键单击会有快捷菜单

"------------- 折叠

set foldenable
set foldmethod=manual  "手动折叠
set foldlevel=3

" ------------ 匹配

set showmatch                   " 高亮显示匹配的括号
set matchtime=1                 " 匹配括号高亮的时间（单位是十分之一秒）

"------------- 补全

set completeopt=longest,menu
set cpt=.,w,b

" ------------ 行号
set ruler                       " 标尺
set number                      " 行号
set magic                       " 替换按行为单位。
set scrolloff=7                 " 光标上下最少保留7行
set nowrap                      " 取消换行
set relativenumber number       " 相对行号 nj,nk跳转
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

" ------------ 杂项
" vimrc文件修改之后自动加载, windows
autocmd! bufwritepost _vimrc source %
" vimrc文件修改之后自动加载, linux
autocmd! bufwritepost .vimrc source %
" 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" ================== 按键 ========================
" 关闭方向键, 强迫自己用 hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" 系统剪切板
map <C-c> "+y
" map <C-v> "+p mac 存在按键冲突。 放弃。


" normal 模式 0到行首， 9到行尾
noremap 0 ^


noremap 9 $

"Treat long lines as break lines (useful when moving around in them)
"se swap之后，同物理行上线直接跳
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj jk

" F6 语法开关，关闭语法可以加快大文件的展示
nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

" 分屏窗口移动, Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Keep search pattern at the center of the screen.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
" 去掉搜索高亮
noremap <silent><leader>/ :nohls<CR>:w

" switch # *
nnoremap # *
nnoremap * #:

" 新建tab  Ctrl+t
nnoremap <C-t>     :tabnew<CR>
inoremap <C-t>     <Esc>:tabnew<CR>

" 关闭buffer和window
nnoremap <Leader>bd :bd<CR>


" => 选中及操作改键

" 调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gr

" y$ -> Y Make Y behave like other capitals
map Y y$

" w!! to sudo & write a file
cmap w!! w !sudo tee >/dev/null %

" =====nerdtree 目录树设置=======
"vim启动的时候打开nerdtree
"autocmd vimenter * NERDTree
"打开一个未指明的文件时也打开nerdtree
"autocmd vimenter * if !argc() | NERDTree | endif
"最后只剩下nerdtree的时候关闭之
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"nerdtree 的宽度
let NERDTreeWinSize = 35
"显示行号
let NERDTreeShowLineNumbers=1
let NERDTreeIgnore=['\.pyc$', '\.o$', '\~$', '__pycache__']

" ============自定义命令==============
" 打开/关闭Nerdtree
:command NT :NERDTreeToggle
"清楚行尾空白
:command WS :%s/\s\+$//e

