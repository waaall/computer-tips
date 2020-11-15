"set lines=32 columns=120

set nocompatible    " Use Vim defaults instead of vi compatibility
set backspace=2

syntax on

"set clipboard=unnamed
"nnoremap <C-c> "+y # ctrl+c为vim内复制

set autoindent
set showcmd
set nu

set t_Co=256 " required

"set bg=dark
"colorscheme jellybeans
"colorscheme busybee
"colorscheme Tomorrow-Night

set laststatus=1

"set encoding=utf-8
set fileencodings=utf-8,utf-16,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set enc=utf8

set mouse=a
set tabstop=4       
set shiftwidth=4   
set expandtab
set smarttab

set ruler
set showmatch
set autoread
set cindent

set noswapfile
"set directory   =$HOME/.vim/files/swap/
"set updatecount =100

" 撤销文件
"set undofile
"set undodir     =$HOME/.vim/files/undo/

" 指定屏幕上可以进行分割布局的区域
set splitbelow               " 允许在下部分割布局
set splitright               " 允许在右侧分隔布局

" 组合快捷键：
nnoremap <C-J> <C-W><C-J>    " 组合快捷键：- Ctrl-j 切换到下方的分割窗口
nnoremap <C-K> <C-W><C-K>    " 组合快捷键：- Ctrl-k 切换到上方的分割窗口
nnoremap <C-L> <C-W><C-L>    " 组合快捷键：- Ctrl-l 切换到右侧的分割窗口
nnoremap <C-H> <C-W><C-H>    " 组合快捷键：- Ctrl-h 切换到左侧的分割窗口

"一键运行代码
map <C-b> :call CompileRunGcc()<CR>
    func! CompileRunGcc()
        exec "w"
if &filetype == 'c'
            exec "!g++ % -o %<"
            exec "!time ./%<"
elseif &filetype == 'cpp'
            exec "!g++ % -o %<"
            exec "!time ./%<"
elseif &filetype == 'java'
            exec "!javac %"
            exec "!time java %<"
elseif &filetype == 'sh'
            :!time bash %
elseif &filetype == 'python'
            exec "!time python3 %"
elseif &filetype == 'html'
            exec "!firefox % &"
elseif &filetype == 'go'
    "        exec "!go build %<"
            exec "!time go run %"
elseif &filetype == 'mkd'
            exec "!~/.vim/markdown.pl % > %.html &"
            exec "!firefox %.html &"
endif
    endfunc

filetype on                "required
filetype plugin indent on  "required
"
"
"设置 vim-plug!!!

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'

call plug#end()


"
"
" 配置 Vim-airline!!!

" 支持 powerline 字体
"let g:airline_powerline_fonts = 1 

"set airline主题!
"let g:airline_theme='angr'
let g:airline_theme='deus'

"显示窗口tab和buffer 
let g:airline#extensions#tabline#enabled = 1 
