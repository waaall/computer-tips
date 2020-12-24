"===================================基础设置===================================
"set backspace=2
"nnoremap <C-c>             " +y # ctrl+c为vim内复制
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
set enc=utf-8              " 编码设置
set fileencodings=utf-8,utf-16,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
"set fencs=utf8,gbk,gb2312,gb18030

set autoread                " 文件自动检测外部更改
set nocompatible            " Use Vim defaults instead of vi compatibility

set noswapfile              " 取消swapfile
"set directory=$HOME/.vim/files/swap/
"set updatecount =100

"set undofile               " 撤销文件
"set undodir=$HOME/.vim/files/undo/

set backup                  " 备份文件
set backupext  =.vimbackup
set backupdir =~/.vim/files/backup

" viminfo 文件
set viminfo='100,n$HOME/.vim/files/info/viminfo

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
"----------darkcolor----------"
"colorscheme Tomorrow-Night " 不设置默认跟随terminal
"colorscheme gruvbox
"colorscheme jellybeans
"colorscheme atom
"colorscheme busybee
"colorscheme darkblue
"colorscheme Tomorrow

"----------lightcolor----------"
"colorscheme beauty256
"colorscheme xcode-default
"colorscheme Tomorrow

"=================================一键运行代码==================================
map <F5> :call CompileRunGcc()<CR>
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
            exec "!time python %"
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
filetype on                " required
filetype plugin indent on  " required

"----------设置vundle!!!----------"
"set rtp+=~/.vim/bundle/Vundle.vim

" vundle 管理的插件列表必须位于 vundle#begin() 和 vundle#end() 之间
"call vundle#begin()

" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'

" 插件列表结束
"call vundle#end()

" Brief help
" :PluginList - lists configured plugins
" :PluginInstall - installs plugins
" :PluginUpdate  - upgrade plugins
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean - confirms removal of unused plugins; append `!` to auto-approve removal

"----------设置 vim-plug!!!----------"
call plug#begin('~/.config/nvim/plugged ')

Plug 'vim-scripts/indentpython.vim'
Plug 'tell-k/vim-autopep8'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'

call plug#end()

"----------设置fzf----------
set rtp+=/usr/local/opt/fzf
nnoremap <silent> <leader>f :FZF<CR>

"----------autopep8 快捷键映射----------
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>


"----------airline主题----------"
"let g:airline_powerline_fonts = 1              " 支持 powerline 字体
"let g:airline_theme='angr'
let g:airline_theme='bubblegum'
"let g:airline#extensions#tabline#enabled = 1   " 显示窗口tab和buffer
"let g:airline_statusline_ontop=1               " put status bar on the top

"----------markdown设置----------
"let g:vim_markdown_math = 1
"let g:vim_markdown_folding_disabled = 1
"let g:vim_markdown_toc_autofit = 1

"-----------deoplete 配置----------
let g:deoplete#enable_at_startup = 1

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-Tab> pumvisible() ? "\<C-p>" : "\<C-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

"-----------multi_cursor 配置----------
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_start_word_key      = '<S-n>'
let g:multi_cursor_select_all_word_key = '<S-P>'
let g:multi_cursor_next_key            = '<S-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

"-----------Defx配置!!!----------
call defx#custom#option('_', {
            \ 'winwidth': 24,
            \ 'split': 'vertical',
            \ 'direction': 'topleft',
            \ 'show_ignored_files': 0,
            \ 'buffer_name': '[defx]',
            \ 'root_marker': '≡ ',
            \ 'toggle': 1,
            \ 'resume': 1
            \ })
call defx#custom#column('filename', {
          \ 'min_width': 24,
          \ 'max_width': 30,
          \ })
"defx 图标
call defx#custom#column('icon', {
          \ 'directory_icon': '▸',
          \ 'opened_icon': '▾',
          \ })
call defx#custom#column('mark', {
          \ 'readonly_icon': '✗',
          \ 'selected_icon': '✓',
          \ })

"defx 快捷键
nnoremap <silent> <localLeader>]
           \ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()` <CR>
nnoremap <silent> <localLeader>a
           \ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')` <CR>
autocmd FileType defx call s:defx_mappings()

function! s:defx_mappings() abort
  nnoremap <silent><buffer><expr> <CR>     <SID>defx_toggle_tree()  " 打开或者关闭文件夹，文件
  nnoremap <silent><buffer><expr> .   defx#do_action('toggle_ignored_files')   
  nnoremap <silent><buffer><expr> d \ defx#do_action('remove') 
  nnoremap <silent><buffer><expr> r \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> m \ defx#do_action('move') 
  nnoremap <silent><buffer><expr> p \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> N \ defx#do_action('new_file')
endfunction

function! s:defx_toggle_tree() abort
    " Open current file, or toggle directory expand/collapse
    if defx#is_directory()
        return defx#do_action('open_or_close_tree')
    endif
    return defx#do_action('multi', ['drop'])
endfunction

" 只有defx窗口时自动关闭
autocmd BufEnter * if (!has('vim_starting') && winnr('$') == 1 && &filetype ==# 'defx') | quit | endif