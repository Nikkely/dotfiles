"settings
set fenc=utf-8
set encoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp
set noswapfile
set autoread
set showcmd
set nowritebackup
set nobackup
set backspace=indent,eol,start
if has('unix')
    set clipboard=unnamed
endif
set nowrap
set timeoutlen=400
set belloff=all
set wildmenu wildmode=full              " Display all matching files when we tab complete
set completeopt=menuone                 " Dont show preview window in writing python code
set ttyfast
set mouse=a
set ttymouse=xterm2
inoremap <silent> jj <ESC>
:command! Svimrc :source ~/.vimrc
nnoremap OO :<C-u>call append(expand('.'), '')<Cr>
:command! SudoSave :w !sudo tee %
vnoremap > >gv
vnoremap < <gv
syntax enable

"complete
inoremap {<CR> {<CR>}<UP><C-o>$<CR>
inoremap [<CR> [<CR>]<UP><C-o>$<CR>
inoremap (<CR> (<CR>)<UP><C-o>$<CR>

"visual
set number
set title
set virtualedit=onemore
set visualbell
set showmatch
set laststatus=2
set ambiwidth=double
set wrapscan
set splitright
let loaded_matchparen = 1
set list

"filetype
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent

augroup fileTypeConvert
    autocmd!
    autocmd BufNewFile,BufRead *.txt setfiletype text
    autocmd BufNewFile,BufRead *.conf setfiletype config
augroup END

augroup fileTypeIndent
        autocmd!
        autocmd FileType html setlocal ts=2 sts=2 sw=2
        autocmd FileType javascript setlocal ts=2 sts=2 sw=2
        autocmd FileType vue setlocal ts=2 sts=2 sw=2
        autocmd FileType python setlocal ts=4 sts=4 sw=4
        autocmd FileType yaml setlocal ts=2 sts=2 sw=2
        autocmd FileType config setlocal ts=2 sts=2 sw=2
augroup END

"search
set incsearch
set ignorecase
set smartcase
set hlsearch

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

map <silent> [Tag]t :tablast <bar> tabnew<CR>
map <silent> [Tag]w :tabclose<CR>
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

nnoremap ft :set filetype=
