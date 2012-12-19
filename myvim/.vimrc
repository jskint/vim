" 使用vim默认配置，推荐这样做
set nocompatible 
set ff=unix

"默认长度的空格
set backspace=indent,eol,start

" 读写.viminfo文件，不要额外存储
set viminfo='20,\"50 
set formatoptions=mtcql

au BufNewFile,BufRead * set foldlevel=99

"折叠配置
set fdm=manual

" 折叠样式
highlight Folded ctermbg=darkgray ctermfg=lightmagenta

if has ( "autocmd" )
	" 打开文件时，自动定位到上次光标位置
	autocmd BufReadPost *
	\ if line("'\"") > 0 && line ("'\"") <= line("$") |
	\   exe "normal g'\"" |
	\ endif
endif  " has ("autocmd") 


" 编辑器界面配置
"

" 鼠标滚轮的事件
" just for gvim
if has("gui_running")
	"color lucius
	au GUIEnter * cd ~
	" 列高亮，暂时关闭
	" set cursorcolumn
	map <MiddleMouse> <Nop>
	" 行高亮，gui模式下起作用
	set cursorline
	set guifont=Consolas:h13
else
	set showtabline=2
	"鼠标隐藏,鼠标右键无作用
	set mouse=v
endif

" 字体设置
if has("unix") && !has("mac")
	set guifont=Inconsolata\ Medium\ 11
	" gui下字体默认样式
	set guifont=Courier\ 10\ Pitch
	set guifontwide=WenQuanYi\ Micro\ Hei\ Mono\ Medium\ 10
endif
if has("mac")
	set guifont=Monaco:h13
endif

" 文件设置
filetype on
filetype plugin on
filetype indent on


" js文件格式化，Shift-b
map <S-b> :call g:Jsbeautify()<CR>

"编辑器样式hack
hi Comment      term=bold ctermfg=darkcyan
hi Constant     term=underline ctermfg=Red
hi Special      term=bold ctermfg=Magenta
hi Identifier   term=underline ctermfg=cyan
hi Statement    term=bold ctermfg=Brown
hi PreProc      term=bold ctermfg=DarkYellow
hi Type         term=bold ctermfg=DarkGreen
hi Ignore       ctermfg=white
hi Error        term=reverse ctermbg=Red ctermfg=White
hi Todo         term=standout ctermbg=Yellow ctermfg=Red
hi Search       term=standout ctermbg=Yellow ctermfg=Black
hi ErrorMsg     term=reverse ctermbg=Red ctermfg=White
hi StatusLine   ctermfg=darkblue  ctermbg=gray
hi StatusLineNC ctermfg=brown   ctermbg=darkblue

"高亮搜索结果
set incsearch
set hlsearch

"显示行号
set nu

"状态栏
set laststatus=2
set statusline=%<[%n]\ %F\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}][%{&ff}][ASCII=\%03.3b]\ %-10.(%l,%c%V%)\ %P

"欢迎文字
" autocmd VimEnter * echo "Welcome back jayli :)"
" autocmd VimLeave * echo "Byebye.."

"一个tab占4个空格
set ts=4
set sw=4

"自动缩进动作，粘贴自动缩进
set smartindent
"自动缩进长度
set cino=:0g0               

"长句在单词间折行
set wrap

"搜索忽略大小写
set ignorecase

"编辑源备份
set backupcopy=yes

"编辑模式自动缩进
set autoindent 
"记录历史
set history=150 
"标尺
set ruler
"显示不完整的命令
set showcmd
" Added to default to high security within Gentoo. Fixes bug #14088
set modelines=0

"文件编码
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,GB18030,gbk
"gui字体，随意模式
set guifontset=*-r-*

"语法高亮
syntax enable
syntax on

"F功能键定义
map <F2> <ESC>zA<CR>            
map <F3> <ESC>*
map <F11> :bp<CR>              
map <F12> :bn<CR>               
map <F7> <ESC>:wa<CR>:make<CR>

" JSHint
map <F8> :JSHint<CR>

"tab操作多文件
map <C-t> :tabnew 
nmap wm :tabnew .<CR>
"nmap wm :NERDTreeToggle<CR>
map <Tab> :tabnext<CR> 
map <S-Tab> :tabprevious<CR>

"使用 Ctrl+C 或者 Y 复制到系统剪贴板
vnoremap <C-C> "+y
vnoremap Y "+y

"快速左右移动光标
map <C-l> <ESC>10l
map <C-h> <ESC>10h

"tab尺寸
set shiftwidth=4
set tabstop=4   "tab

"tab自动补全
function! CleverTab()
	if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
		return "\<Tab>"
	else
		return "\<C-N>"
endfunction
function! CleverShiftTab()
	return pumvisible()?"\<C-P>":"\<Tab>"
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>
inoremap <S-Tab> <C-R>=CleverShiftTab()<CR>
inoremap <C-F> <C-X><C-F><C-P> 
inoremap <C-O> <C-X><C-O><C-P>

inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
autocmd Filetype css inoremap <buffer>  :  :<C-X><C-O><C-P>

"退出模式，退出时保留残存窗口
set t_ti=
set t_te= 


"选择编辑器主题
"colorscheme evening
"colorscheme blue
colorscheme darkblue
"colorscheme default
"colorscheme delek
"colorscheme desert
"colorscheme elflord
"colorscheme darkburn  "依赖.vim/colors/darkburn.vim
"colorscheme evening
"colorscheme koehler
"colorscheme morning
"colorscheme murphy
"colorscheme pablo
"colorscheme peachpuff
"colorscheme ron
"colorscheme shine
"colorscheme torte
"colorscheme zellner
"colorscheme gemcolors 

"编辑器主题样式hack，针对evening
"hi StatusLine	cterm=bold ctermbg=blue ctermfg=white guibg=gold guifg=blue
"hi StatusLineNC	cterm=bold ctermbg=blue ctermfg=black guibg=gold guifg=blue
"hi TabLine cterm=bold ctermbg=lightgray ctermfg=black guibg=gold guifg=blue
"hi TabLineSel cterm=bold ctermbg=darkblue ctermfg=white guibg=gold guifg=blue
"hi CursorLine cterm=bold ctermbg=darkgray guibg=gold guifg=blue

"hack for elflord 
"状态栏样式hack，针对evening,包括gui模式下的状态栏样式
hi StatusLine	cterm=bold ctermbg=blue ctermfg=white guifg=darkblue guibg=white
hi StatusLineNC	cterm=bold ctermbg=blue ctermfg=black guifg=darkblue guibg=white
hi TabLine cterm=bold ctermbg=white ctermfg=black guibg=blue guifg=white
hi TabLineSel cterm=bold ctermbg=blue ctermfg=white guibg=blue guifg=white
"hi CursorLine cterm=bold ctermbg=darkgray guibg=gold guifg=blue

"显示tab line
"set showtabline=2

"最大tab个数
set tabpagemax=40

"darkburn 颜色设置
"set t_Co=256

"对所有文件设置关键字提示
set dictionary-=~/.vim/dict/dict.txt dictionary+=~/.vim/dict/dict.txt
set complete-=k complete +=k

:filetype plugin on 

" 将less识别为css
au BufRead,BufNewFile *.less set filetype=css

" zen coding 配置
let g:user_zen_expandabbr_key = '<C-k>' "设置为ctrl+k,展开

" 注释生成
let g:DoxygenToolkit_authorName="jayli, bachi@taobao.com" 
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:doxygen_enhanced_color=1
let g:DoxygenToolkit_versionString=""
let g:DoxygenToolkit_compactOneLineDoc = "yes"

" 注释生成
function! InsertDox()
	"return "\:".getline('.')
	" 空行C-D生成文件注释
	if getline('.') =~ '^\s*$'
		return "\:DoxAuthor\<CR>"
	else 
	" 非空行C-D生成函数注释
		return "\:Dox\<CR>\<ESC>"
endfunction

" C-D生成注释
map <expr> <C-D> InsertDox()


