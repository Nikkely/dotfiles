echo "Startig vim... (Press any Key)"
"settings
set fenc=utf-8
set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp
set noswapfile
set autoread
set showcmd
set nowritebackup
set nobackup
set backspace=indent,eol,start
set clipboard&
set clipboard^=unnamedplus
set timeoutlen=400
set nowrap
" set clipboard&
" set clipboard^=unnamedplus
set timeoutlen=500
inoremap <silent> jj <ESC>
:command! Svimrc :source ~/.vimrc
:command! Openvimrc call Open_vimrc ()
function! Open_vimrc()
	tabnew<CR>
	:e ~/.vimrc
endfunction
nnoremap OO :<C-u>call append(expand('.'), '')<Cr>

"complete
" inoremap { {}<LEFT>
" inoremap ( ()<LEFT>
" inoremap [ []<LEFT>
" inoremap {<Enter> {}<Left><CR><CR><UP>
inoremap {<CR> {<CR>}<UP><C-o>$<CR>
inoremap [<CR> [<CR>]<UP><C-o>$<CR>
inoremap (<CR> (<CR>)<UP><C-o>$<CR>
" inoremap }} <RIGHT>
"visual
set number
set title
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2

"filetype
autocmd BufRead,BufNewFile *.slim setfiletype slim

"tab
set tabstop=4
set shiftwidth=4
" set expandtab
autocmd BufRead,BufNewFile *.rb setlocal tabstop=2 shiftwidth =2
autocmd BufRead,BufNewFile *.erb setlocal tabstop=2 shiftwidth =2
autocmd BufRead,BufNewFile *.slim setlocal tabstop=2 shiftwidth =2
autocmd BufRead,BufNewFile *.py setlocal tabstop=4 shiftwidth =4

"search
set incsearch
set ignorecase
set smartcase
set wrapscan

"contest
:command! Opentemplate call Open_Template()
function! Open_Template()
	tabnew<CR>
	:e ~/contest_template.h
endfunction

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

nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>

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


"submode
if dein#tap('vim-submode')
	call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
	call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
	call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
	call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
	call submode#map('bufmove', 'n', '', '>', '<C-w>>')
	call submode#map('bufmove', 'n', '', '<', '<C-w><')
	call submode#map('bufmove', 'n', '', '+', '<C-w>+')
	call submode#map('bufmove', 'n', '', '-', '<C-w>-')
endif

"vim-indent-guides
if dein#tap('vim-indent-guides')
	let g:indent_guides_enable_on_vim_startup = 1
endif

"neosnippet
" SuperTab like snippets behavior.
if dein#tap('neosnippet.vim')
	let g:neosnippet#snippets_directory='~/.vim/my_snippet'
	imap  <expr><TAB>
	\ pumvisible() ? "\<C-n>" :
	\ neosnippet#expandable_or_jumpable() ?
	\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

	smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
	\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

	if has('conceal')
		set conceallevel=2 concealcursor=i
	endif
endif
"neocomplete
if dein#tap('neocomplete.vim')
	let g:neocomplete#enable_at_startup = 1
	let g:neocomplete#enable_smart_case = 1
	let g:neocomplete#min_keyword_length = 3
	let g:neocomplete#enable_auto_delimiter = 1
	let g:neocomplete#auto_completion_start_length = 1
    imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
    imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
endif

" Status bar
" ---------------------------------------------------
let g:last_mode = ""

function! Mode()
  let l:mode = mode()

  if l:mode !=# g:last_mode
    let g:last_mode = l:mode

    hi User2 guifg=#005f00 guibg=#dfff00 gui=BOLD ctermfg=22 ctermbg=190 cterm=BOLD
    hi User3 guifg=#FFFFFF guibg=#414243 ctermfg=255 ctermbg=241
    hi User4 guifg=#414234 guibg=#2B2B2B ctermfg=241 ctermbg=234
    hi User5 guifg=#4e4e4e guibg=#FFFFFF gui=bold ctermfg=239 ctermbg=255 cterm=bold
    hi User6 guifg=#FFFFFF guibg=#8a8a8a ctermfg=255 ctermbg=245
    hi User7 guifg=#ffff00 guibg=#8a8a8a gui=bold ctermfg=226 ctermbg=245 cterm=bold
    hi User8 guifg=#8a8a8a guibg=#414243 ctermfg=245 ctermbg=241

    if l:mode ==# 'n'
      hi User3 guifg=#dfff00 ctermfg=190
    elseif l:mode ==# "i"
      hi User2 guifg=#005fff guibg=#FFFFFF ctermfg=27 ctermbg=255
      hi User3 guifg=#FFFFFF ctermfg=255
    elseif l:mode ==# "R"
      hi User2 guifg=#FFFFFF guibg=#df0000 ctermfg=255 ctermbg=160
      hi User3 guifg=#df0000 ctermfg=160
    elseif l:mode ==? "v" || l:mode ==# ""
      hi User2 guifg=#4e4e4e guibg=#ffaf00 ctermfg=239 ctermbg=214
      hi User3 guifg=#ffaf00 ctermfg=214
    endif
  endif 

  if l:mode ==# "n"
    return "  NORMAL "
  elseif l:mode ==# "i"
    return "  INSERT "
  elseif l:mode ==# "R"
    return "  REPLACE "
  elseif l:mode ==# "v"
    return "  VISUAL "
  elseif l:mode ==# "V"
    return "  V·LINE "
  elseif l:mode ==# ""
    return "  V·BLOCK "
  else
    return l:mode
  endif
endfunction

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? 'OK' : printf(
    \   '☠ %d ⚠ %d ⬥ ok',
    \   all_errors,
    \   all_non_errors
    \)
endfunction

set statusline=%2*%{Mode()}%3*⮀%1*
set statusline+=%#StatusLine#
set statusline+=%{strlen(fugitive#statusline())>0?'\ ⭠\ ':''}
set statusline+=%{matchstr(fugitive#statusline(),'(\\zs.*\\ze)')}
set statusline+=%{strlen(fugitive#statusline())>0?'\ \ ⮁\ ':'\ '}
set statusline+=%f\ %{&ro?'⭤':''}%{&mod?'+':''}%<
set statusline+=%3*\ 
set statusline+=%{LinterStatus()}
set statusline+=\ %4*⮀
set statusline+=%#warningmsg#
set statusline+=%=
set statusline+=%4*⮂
set statusline+=%#StatusLine#
set statusline+=\ %{strlen(&fileformat)>0?&fileformat.'\ ⮃\ ':''}
set statusline+=%{strlen(&fileencoding)>0?&fileencoding.'\ ⮃\ ':''}
set statusline+=%{strlen(&filetype)>0?&filetype:''}
set statusline+=\ %8*⮂
set statusline+=%7*\ %p%%\ 
set statusline+=%6*⮂%5*⭡\ \ %l:%c\ 

" NERDTree
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable  = '→'
let g:NERDTreeDirArrowCollapsible = '↓'
" ctrl-n で NERDTree を起動
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

syntax on
" call map(dein#check_clean(),"delete(v:val, 'rf')")
"call dein#recache_runteimepath()
