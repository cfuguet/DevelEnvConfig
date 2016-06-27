" VIM configuration file.
"
" Author:   Cesar Fuguet

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow modelines in vim
set modelines=5

" default space/tabs configuration
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

" command-line completion menu
set wmnu
set wildmode=list:longest,list:full

if has('gui_running')
	set guifont=Menlo\ Regular:h12
	" set guioptions-=m " remove menu bar
	set guioptions-=T " remove toolbar
	set guioptions-=r " remove right-hand scroll bar
	set guioptions-=L " remove left-hand scroll bar
endif

" color scheme settings
set syntax=enable
set background=dark
colorscheme solarized

set laststatus=2             " always display the status line

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" keep 50 lines of command line history
set history=50

" show the cursor position all the time
set ruler

" display incomplete commands
set showcmd

" {{{ VIM search configuration
" do incremental searching
set incsearch

" during search, ignore case when the pattern contains lowercase letters only
set ignorecase
set smartcase
" }}}

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" VIM swapfiles configuration
" {{{
set directory=~/.tmp,/var/tmp,.,/tmp
" }}}

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" {{{ wrap mode
function! ScreenMovement(movement)
	if &wrap
		return "g" . a:movement
	else
		return a:movement
	endif
endfunction
noremap <silent> <expr> j ScreenMovement("j")
noremap <silent> <expr> k ScreenMovement("k")
noremap <silent> <expr> 0 ScreenMovement("0")
noremap <silent> <expr> ^ ScreenMovement("^")
noremap <silent> <expr> $ ScreenMovement("$")
noremap <silent> <expr> <Down> ScreenMovement("j")
noremap <silent> <expr> <Up> ScreenMovement("k")

set display=lastline
" }}}
" {{{ cscope definitions
if has("cscope")
	""""""""""""" Standard cscope/vim boilerplate

	" use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
	set cscopetag

	" check cscope for definition of a symbol before checking ctags: set to 1
	" if you want the reverse search order.
	set csto=0

	" add any cscope database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
		" else add the database pointed to by environment variable
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif

	" show msg when any other cscope db added
	set cscopeverbose


	""""""""""""" My cscope/vim key mappings
	"
	" The following maps all invoke one of the following cscope search types:
	"
	"   's'   symbol: find all references to the token under cursor
	"   'g'   global: find global definition(s) of the token under cursor
	"   'c'   calls:  find all calls to the function name under cursor
	"   't'   text:   find all instances of the text under cursor
	"   'e'   egrep:  egrep search for the word under cursor
	"   'f'   file:   open the filename under cursor
	"   'i'   includes: find files that include the filename under cursor
	"   'd'   called: find functions that function under cursor calls
	"
	" Below are three sets of the maps: one set that just jumps to your
	" search result, one that splits the existing vim window horizontally and
	" diplays your search result in the new window, and one that does the same
	" thing, but does a vertical split instead (vim 6 only).
	"
	" I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
	" unlikely that you need their default mappings (CTRL-\'s default use is
	" as part of CTRL-\ CTRL-N typemap, which basically just does the same
	" thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
	" If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
	" of these maps to use other keys.  One likely candidate is 'CTRL-_'
	" (which also maps to CTRL-/, which is easier to type).  By default it is
	" used to switch between Hebrew and English keyboard mode.
	"
	" All of the maps involving the <cfile> macro use '^<cfile>$': this is so
	" that searches over '#include <time.h>" return only references to
	" 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
	" files that contain 'time.h' as part of their name).

	" To do the first type of search, hit 'CTRL-\', followed by one of the
	" cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
	" search will be displayed in the current window.  You can use CTRL-T to
	" go back to where you were before the search.

	nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

	" horizontal split
	nmap <C-_>s :scs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>g :scs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>c :scs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>t :scs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>e :scs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-_>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-_>d :scs find d <C-R>=expand("<cword>")<CR><CR>
endif
" }}}
" {{{ Folding
set fdm=manual  " by default, use the manual folding method
set fdls=99     " when opening a buffer, open all folds
" }}}
" {{{ LanguageTool plugin
let g:languagetool_jar='/opt/LanguageTool-2.9/languagetool-commandline.jar'
" }}}

" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	" Use the latex flavor by default for *.tex files
	let g:tex_flavor = "latex"

	" On tex files, disable syntax-based folding
	let g:tex_fold_enabled = 0
	let g:Tex_Folding = 0

	" Disable the latex-suite Insert Mode mappings
    let g:Imap_FreezeImap = 1
	imap <buffer> <leader>it <Plug>Tex_InsertItemOnThisLine

	" grep will sometimes skip displaying the file name if you search in a
	" single file. This will confuse Latex-Suite. Set your grep program to
	" always generate a file-name.
	set grepprg=grep\ -nH\ $*

	" On tex files, enable visual break of long lines, and keep its
	" indentation
	autocmd FileType tex setlocal tw=0 wrap lbr "sbr=» bri

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
		au!

		" For all text files set 'nu'.
		" autocmd FileType tex setlocal nu

		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event handler
		" (happens when dropping a file on gvim).
		" Also don't do it when the mark is in the first line, that is the default
		" position when opening a file.
		au BufReadPost *
		\ if line("'\"") > 1 && line("'\"") <= line("$") |
		\   exe "normal! g`\"" |
		\ endif

		" Balance split when vim's window resizes
		au VimResized * exe "normal \<C-w>="
	augroup END
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		\ | wincmd p | diffthis
endif

" vim: foldmethod=marker
