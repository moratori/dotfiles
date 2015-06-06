"-------------------------------------------------------
" Note: Skip initialization for vim-tiny or vim-small.
 if !1 | finish | endif

 if has('vim_starting')
   if &compatible
     set nocompatible               " Be iMproved
   endif

   " Required:
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

 " Required:
 call neobundle#begin(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
 " Required:
 NeoBundleFetch 'Shougo/neobundle.vim'

 " My Bundles here:
 " Refer to |:NeoBundle-examples|.
 " Note: You don't set neobundle setting in .gvimrc!
 

 NeoBundle 'scrooloose/nerdtree'
 NeoBundle 'mattn/emmet-vim'
 NeoBundle 'scrooloose/syntastic'
 NeoBundle 'Shougo/neocomplete.vim'
 NeoBundle 'thinca/vim-quickrun'
 NeoBundle 'derekwyatt/vim-scala'
 NeoBundle 'kovisoft/slimv'
 NeoBundle 'Shougo/unite.vim'
 NeoBundle 'Shougo/neomru.vim'
 NeoBundle 'Shougo/neosnippet'
 NeoBundle 'Shougo/neosnippet-snippets'
 NeoBundle 'sudo.vim'
 NeoBundle 'Yggdroot/indentLine'

 call neobundle#end()

 " Required:
 filetype plugin indent on
 filetype on


 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
 NeoBundleCheck

 "-------------------------------------------------------
 
 let lisp_rainbow=1
 let g:slimv_clhs_root = "/home/moratori/CLHS/HyperSpec-7-0/HyperSpec/Body/"
 let g:slimv_python = "/usr/bin/python2.7"
 let g:slimv_swank_cmd = "! xterm -e sbcl --eval '(ql:quickload :swank)' --eval '(swank:create-server)' &"

 "-------------------------------------------------------

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags



 "-------------------------------------------------------

 let g:quickrun_config={'*': {'split': ''}} 
 set splitbelow
 set list listchars=tab:\¦\

"------------------------------------------------------

 syn on
 set number
 set statusline=%<%f\ %m%r%h%w%=%{GetStatusEx()}\ \ %l,%c%V%8P
 set laststatus=2
 setl shiftwidth=2 tabstop=2 softtabstop=2
 set expandtab
 set hlsearch
 set ruler
 set cursorline
 set cursorcolumn
 set nostartofline
 set autoread
 set ignorecase
 set smartcase
 set ic

 "------------------------------------------------------


" change buffer size left
 nmap <C-A> <C-W><

 "change buffer size right
 nmap <C-B> <C-W>>

 "change buffer size upper
 nmap <C-C> <C-W>+

 "change buffer size lower
 nmap <C-D> <C-W>-

 " mvoe buffer
 nmap <C-E> <C-W><C-W>

  " open nerdtree
 nmap <C-F> :NERDTree<CR>

 " run this script
 nmap <C-R> :QuickRun<CR>


 "redraw
 nmap <F5> :redraw!<CR>

 " move tab
 nmap <F7> :tabN<CR>
 nmap <F8> :tabn<CR>

 "------------------------------------------------------
 
 " ステータスラインを作る
 "format="[filename] [kind][encodeing][new line code] [row][width] [position%]"
 function! GetStatusEx()
   let str = ''
   if &ft != ''
     let str = str . '[' . &ft . ']'
   endif
   if has('multi_byte')
     if &fenc != ''
       let str = str . '[' . &fenc . ']'
     elseif &enc != ''
       let str = str . '[' . &enc . ']'
     endif
   endif
   if &ff != ''
     let str = str . '[' . &ff . ']'
   endif
   return str
 endfunction


"------------------------------------------------------
" モードによって色を変える

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
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
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

"------------------------------------------------------
"最後のカーソルの位置を復元
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif
"------------------------------------------------------
