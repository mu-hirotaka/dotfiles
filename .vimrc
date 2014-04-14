set nocp

set number

set encoding=utf-8
set termencoding=utf-8

" incremental search
set incsearch
" search without capital
set ic
set smartcase

set smarttab

" set color on searched word
set hlsearch
"set nohlsearch

" delete indent, start, eol
set backspace=indent,eol,start

" show parenthis
set showmatch

" smart command completion
set wildmenu

" show cursor line
set cursorline

" show Zenkaku character
set ambiwidth=double

"########### Neo Vundle Settings ################
 filetype off                   " Required!

 if has('vim_starting')
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

 call neobundle#rc(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
 NeoBundle 'Shougo/neobundle.vim'

 " Recommended to install
 " After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
 NeoBundle 'Shougo/vimproc'
 NeoBundle 'Shougo/neocomplcache.git'
 NeoBundle 'Shougo/neosnippet.git'
 NeoBundle 'Shougo/neosnippet-snippets'
 NeoBundle 'Shougo/unite.vim'
 NeoBundle 'Shougo/vimfiler'
 NeoBundle 'h1mesuke/unite-outline'
 NeoBundle 'taglist.vim'
 NeoBundle 'scrooloose/nerdcommenter'
 NeoBundle 'scrooloose/nerdtree'
 NeoBundle 'thinca/vim-quickrun'
 NeoBundle 'hotchpotch/perldoc-vim'
 NeoBundle 'Lokaltog/vim-powerline'
 NeoBundle 'thinca/vim-ref'
 NeoBundle 'ack.vim'
 NeoBundle 'surround.vim'
 NeoBundle 'sudo.vim'
 "### COLOR SCHEME ###
 NeoBundle 'tomasr/molokai'
 NeoBundle 'tpope/vim-fugitive'
 NeoBundle 'nanotech/jellybeans.vim'
 NeoBundle 'altercation/solarized'

 filetype plugin indent on     " Required!

 " Installation check.
 if neobundle#exists_not_installed_bundles()
   echomsg 'Not installed bundles : ' .
         \ string(neobundle#get_not_installed_bundle_names())
   echomsg 'Please execute ":NeoBundleInstall" command.'
   "finish
 endif
"########### Vundle Settings End ############

filetype indent on
filetype plugin on
syntax on

" status にエンコード表示
" set statusline+=[%{&fileencoding}]

set nobackup
set noswapfile

" ファイルパスを現在のファイルからはじめる
" set autochdir

" 対応カッコの強調時間
set matchtime=3

" 複数ファイルを開く
set hidden

set list
set listchars=tab:>-,extends:»,trail:▫,eol:¬

" set autoindent
" set cindent
" set smartindent

set tabstop=2
set softtabstop=0 " set 0 to set same value as tabstop
set shiftwidth=4


" 変更があれば再読み込み
set autoread

set fileformat=unix

" Normal モードでEnterするだけで改行挿入
" QuickFixでも有効になってしまうので一旦off
" noremap <CR> o<ESC>

" color scheme
" colorscheme molokai

"全角スペースを視覚化
if has('syntax')
  syntax enable
  function! ActivateInvisibleIndicator()
    highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=#FF0000
    match ZenkakuSpace /　/
  endfunction
  augroup InvisibleIndicator
    autocmd!
    autocmd BufEnter * call ActivateInvisibleIndicator()
  augroup END
endif

autocmd FileType perl,cgi :compiler perl

"windowsのvimfilesを.vimに変更する
if has('win32') + has('win64')
	source ~/.vimrc_win
endif


"############################################
"        neocomplcache settings

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
 " Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Select with <TAB>
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

let g:neocomplcache_ctags_arguments_list = {
  \ 'perl' : '-R -h ".pm"'
  \ }

" let g:neocomplcache_snippets_dir = "~/.vim/snippets"
" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default'    : '',
    \ 'perl'       : $HOME . '/.vim/dict/perl.dict'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" " for snippets
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif


" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif


" Always show status line
set laststatus=2

" ### NERDTree ####
" shortcut
" noremap <c-e> :<c-u>:call ExcecuteNERDTree()<cr>
"</cr></c-u></c-e>
nmap <c-a> :NERDTreeToggle<cr><c-l>
"noremap <c-a> <c-e>

if filereadable(expand('~/.vim/sub_vimrc/vimfiler.vim'))
	  source ~/.vim/sub_vimrc/vimfiler.vim
endif

" ### Syntastic ###
" let g:syntastic_enable_signs=2
" let g:syntastic_enable_balloons = 1
" let g:syntastic_enable_highlighting = 1
" let g:syntastic_echo_current_error = 1
" let g:syntastic_quiet_warnings = 1
" let g:syntastic_auto_jump = 1
" let g:syntastic_check_on_open=1
" let g:syntastic_loc_list_height = 1

" ### Unite ###
"unite prefix key.
nnoremap [unite] <Nop>
nmap <Space>f [unite]

"unite general settings
" Start with insert mode
let g:unite_enable_start_insert=1
" file history
let g:unite_source_file_mru_limit = 50
"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''
"現在開いているファイルのディレクトリ下のファイル一覧。
"開いていない場合はカレントディレクトリ
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -no-split -buffer-name=files file<CR>
"バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite -no-split buffer<CR>
"レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -no-split -buffer-name=register register<CR>
"最近使用したファイル一覧
nnoremap <silent> [unite]m :<C-u>Unite -no-split file_mru<CR>
"ブックマーク一覧
nnoremap <silent> [unite]c :<C-u>Unite -no-split bookmark<CR>
"ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
" usually used
nnoremap <silent> [unite]u :<C-u>Unite -no-split file_mru buffer<CR>
" outline
nnoremap <silent> [unite]o :<C-u>Unite -no-split outline<CR>
"uniteを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  "ESCでuniteを終了
  nmap <buffer> <ESC> <Plug>(unite_exit)
  "入力モードのときjjでノーマルモードに移動
  imap <buffer> jj <Plug>(unite_insert_leave)
  "入力モードのときctrl+wでバックスラッシュも削除
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  "ctrl+jで縦に分割して開く
  nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  "ctrl+lで横に分割して開く
  nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  "ctrl+oでその場所に開く
  nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
  inoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
endfunction"}}}
" 
" NERD commenter
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
nmap <Leader>/ <Plug>NERDCommenterToggle
vmap <Leader>/ <Plug>NERDCommenterToggle
nmap <Leader>/a <Plug>NERDCommenterAppend


" 日本語入力中にカーソルの色を変更
if has('multi_byte_ime') || has('xim')
	highlight CursorIM guibg=Purple guifg=None
endif
" indent
noremap <c-i> <c-t>

if filereadable(expand('~/.vim/sub_vimrc/powerline.vim'))
	  source ~/.vim/sub_vimrc/powerline.vim
endif
" Powerline Settings
let g:Powerline_symbols = 'unicode'
let g:Powerline_theme="default"
let g:Powerline_colorscheme="solarized256"


if filereadable(expand('~/.vim.local'))
	source ~/.vim.local
endif


" ##### Boost Vim Settings #####
" http://nvie.com/posts/how-i-boosted-my-vim/
nmap <silent> <leader>ev :e $MYVIMRC <CR>
nmap <silent> <leader>sv :so $MYVIMRC <CR>


set pastetoggle=<F2>

" Boost vim key mapping!
nnoremap ; :

" Boost make
nnoremap <leader>m :silent make!\|redraw!\|cw<CR>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-q> <C-w>q
map <Leader>rd :redraw!<CR>

" not noisy search highlightning
nmap <silent> ,/ :nohlsearch<CR>

" 現在開いているファイルの場所にcd
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" Aliases
command Grace !sudo apachectl graceful
command Apr   !sudo apachectl restart
