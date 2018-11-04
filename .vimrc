"git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"下面是三种实例方式安装插件

"从github安装，作者名/插件名称
"Plugin 'tpope/vim-fugitive'

"从vim-scripts安装的，直接使用插件名
" Plugin 'L9'
"没有托管在github的插件，使用git全地址
"Plugin 'git://git.wincent.com/command-t.git'

"本地插件，比如自己编写的插件
"Plugin 'file:///home/gmarik/path/to/plugin'
"taglist start
Plugin 'taglist.vim'

"taglist end

"ctags start
Plugin 'https://github.com/universal-ctags/ctags.git'
"ctags end


"nerdtree start,file tree
Plugin 'https://github.com/scrooloose/nerdtree.git'
"nerdtree end
"youcompleteme start
"Plugin 'https://github.com/Valloric/YouCompleteMe.git'
"youcompleteme end

"ctrlp start,find file
Plugin 'https://github.com/kien/ctrlp.vim'
"ctrlp end
"NerdCommenter start
Plugin 'https://github.com/scrooloose/nerdcommenter.git'
"NerdCommenter end

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax enable
syntax on
set nu
set t_Co=256
set background=dark
"colorscheme molokai
set autoindent
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab
set softtabstop=4
imap {<CR> {<CR>}<ESC>O
set pastetoggle=<F11> 
set hlsearch 
" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
      au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" For ctags
let Tlist_Ctags_Cmd='ctags'
let Tlist_Show_One_File=1               "不同时显示多个文件的tag，只显示当前文件的
let Tlist_WinWidt =28                   "设置taglist的宽度
let Tlist_Exit_OnlyWindow=1             "如果taglist窗口是最后一个窗口，则退出vim
"let Tlist_Use_Right_Window=1           "在右侧窗口中显示taglist窗口
let Tlist_Use_Left_Windo =1             "在左侧窗口中显示taglist窗口
let Tlist_Auto_Open=0
map <F5> :TlistToggle<CR>


" For cscope
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  endif
  set csverb
endif
nmap <C-/>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-/>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-/>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-/>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-/>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-/>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-/>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-/>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" For nerdtree
let NERDTreeQuitOnOpen=1 "打开文件时，关闭树
"nnoremap <silent> <F2> :NERDTree<CR> 
let g:NERDTreeWinSize = 28
:nnoremap <C-n> :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1

" 切换 tab
:nn <M-1> 1gt
:nn <M-2> 2gt
:nn <M-3> 3gt
:nn <M-4> 4gt
:nn <M-5> 5gt
:nn <M-6> 6gt
:nn <M-7> 7gt
:nn <M-8> 8gt
:nn <M-9> 9gt
:nn <M-0> :tablast<CR>
