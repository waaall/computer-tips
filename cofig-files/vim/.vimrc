"===================================基础设置===================================
"set lines=32 columns=120   " 设置vim窗口大小
syntax on                   " 语法高亮
set autoindent              " 自动对齐
set showcmd                 " 显示输入的命令
set mouse=a                 " 鼠标可用
set clipboard=unnamed       " 共享系统剪贴板
set nu                      " 显示行号
"set cursorline             " 突出显示当前行
set laststatus=1            " 启动显示状态行
set ruler                   " 显示标尺，就是在右下角显示光标位置
set showmatch               " 显示匹配
set cindent                 " c文件自动缩进
"let mapleader="#"          " leader快捷键更换

"----------tab缩进----------"
set tabstop=4               " 一个tab是多少个空格，默认8
set shiftwidth=4            " 每一级缩进是多少个空格
set expandtab
set smarttab

"----------文件设置----------"
set encoding=utf-8          " 编码设置
set autoread                " 文件自动检测外部更改
set nocompatible            " Use Vim defaults instead of vi compatibility
filetype off                " required

set noswapfile              " 取消swapfile
"set directory=$HOME/.vim/files/swap/
"set updatecount =100

"set undofile               " 撤销文件
"set undodir=$HOME/.vim/files/undo/

"----------分割布局----------"
set splitbelow              " 允许在下部分割布局
set splitright              " 允许在右侧分隔布局
nnoremap <C-J> <C-W><C-J>   " 组合快捷键：- Ctrl-j 切换到下方的分割窗口
nnoremap <C-K> <C-W><C-K>   " 组合快捷键：- Ctrl-k 切换到上方的分割窗口
nnoremap <C-L> <C-W><C-L>   " 组合快捷键：- Ctrl-l 切换到右侧的分割窗口
nnoremap <C-H> <C-W><C-H>   " 组合快捷键：- Ctrl-h 切换到左侧的分割窗口

"===================================主题设置===================================
set t_Co=256                " 设置256位色彩，需terminal支持
"set bg=dark
"colorscheme Tomorrow-Night " 不设置默认跟随terminal

"=================================一键运行代码==================================
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

"===================================插件设置===================================
filetype plugin indent on   " required

"----------设置 vim-plug!!!----------"
call plug#begin('$HOME/.vim/plugged')

Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'ycm-core/YouCompleteMe'
"Plug 'skywind3000/asyncrun.vim'

call plug#end()

"----------airline主题----------"
"let g:airline_powerline_fonts = 1              " 支持 powerline 字体
"let g:airline_theme='angr'
let g:airline_theme='bubblegum'
"let g:airline#extensions#tabline#enabled = 1   "显示窗口tab和buffer

"----------YCM设置----------"
"let g:ycm_min_num_identifier_candidate_chars = 2

"let g:ycm_semantic_triggers =  {
"            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
"            \ 'cs,lua,javascript': ['re!\w{2}'],
"            \ }
"highlight PMenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
"highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black

"let g:ycm_filetype_whitelist = { 
"            \ "c":1,
"            \ "cpp":1, 
"            \ "objc":1,
"                                    \ "sh":1,
"                                    \ "zsh":1,
"                                    \ "zimbu":1,
"                                    \ }
"
"----------asyncrun设置----------"
"let g:asyncrun_open = 6
"nnoremap <silent> <F9> :AsyncRun clang++ -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
"nnoremap <F12> :call asyncrun#quickfix_toggle(6)<cr>