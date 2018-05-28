"settings
set fenc=utf-8
set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp
set noswapfile
set autoread
set showcmd
set nowritebackup
set nobackup
set backspace=indent,eol,start


"visual
set number
set title
set cursorline
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2

"tab
set tabstop=4
set shiftwidth=4

"search
set ignorecase
set smartcase
set wrapscan

"tabpage
function! s:SID_PREFIX()
	return matchstr(expand('<sfile>'),'<SNR>\d\+_\zeSID_PREFIX$')
endfunction

function! s:my_tabline()
	let s = ''
	for i in range(1, tabpagenr('$'))
		let bufnrs = tabpagebuflist(i)
		let bufnr = bufnrs[tabpagewinnr(i) - 1]
		let no = i
		let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
		let title = fnamemodify(bufname(bufnr),':t')
		let title = '['.title.']'
		let s .= '%'.i.'T'
		let s .= '%#' . (i ==tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
		let s .= no . ':' . title
		let s .= mod
		let s .= '%#TabLineFill#'
	endfor
	let s .= '%#TabLineFill#%T%=%#TabLine#'
	return s
endfunction

let &tabline = '%!' . s:SID_PREFIX() .'my_tabline()'
set showtabline=2

nnoremap [Tag] <Nop>
nmap t [Tag]
for n in range(1, 9)
	execute 'nnoremap <silent> [Tag]' .n ':<C-u>tabnext' . n . '<CR>'
endfor

map <silent> [Tag]c :tablast <bar> tabnew<CR>
map <silent> [Tag]x :tabclose<CR>
map <silent> [Tag]n : tabnext<CR>
map <silent> [Tag]p : tabprevious<CR>

"change status bar by mode
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
	augroup InsertHook
		autocmd!
		autocmd InsertEnter * call s:StatusLine('Enter')
		autocmd InsertLeave * call s:StatusLine('Leave')
	augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
	if a:mode == 'Enter'
		set cursorline
		silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
		silent exec g:hi_insert
	else
		set nocursorline
		highlight clear StatusLine
		silent exec s:slhlcmd
	endif
endfunction

function! s:GetHighlight(hi)
	redir => hl
	exec 'highlight '.a:hi
	redir END
	let hl = substitute(hl, '[\r\n]', '', 'g')
	let hl = substitute(hl, 'xxx', '', '')
	return hl
endfunction

if has('unix') && !has('gui_running')
	inoremap <silent> <ESC> <ESC>
endif

"dein
let s:dein_dir = expand('~/.cache/dein')

let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

"colorscheme
let g:molokai_original = 1
if dein#tap('molokai')
	colorscheme molokai
	set t_Co=256
	syntax enable
endif 

"neocomplete
if dein#tap('neocomplete.vim')
	" Vim起動時にneocompleteを有効にする
	let g:neocomplete#enable_at_startup = 1
	" smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
	let g:neocomplete#enable_smart_case = 1
	" 3文字以上の単語に対して補完を有効にする
	let g:neocomplete#min_keyword_length = 3
	" 区切り文字まで補完する
	let g:neocomplete#enable_auto_delimiter = 1
	" 1文字目の入力から補完のポップアップを表示
	let g:neocomplete#auto_completion_start_length = 3
	" バックスペースで補完のポップアップを閉じる
	inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

	" エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定・・・・・・②
	imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
	" タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ・・・・・・③
	imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
endif
