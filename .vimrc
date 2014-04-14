" No vi compatibility
set nocompatible

"" Vundle Setup:
filetype off
set rtp+=~/.vim/bundle/vundle/

call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" My bundles:
Bundle 'ervandew/supertab'
Bundle 'myusuf3/numbers.vim'
Bundle 'bling/vim-airline'
Bundle 'vim-scripts/taglist.vim'

"" Plugin config:

" SuperTab:
" SuperTab option for context aware completion
"let g:SuperTabDefaultCompletionType="context"
"let g:SuperTabMappingForward='<c-space>'
"let g:SuperTabMappingBackward='<c-s-space>'

" Airline's mixed indentation messages are often wrong. Turn them off
let g:airline#extensions#whitespace#checks = [ 'trailing' ]

" numbers.vim:
noremap <C-n> :NumbersToggle<CR>

"" Normal vimrc stuff:

" No text wrapping
set nowrap

" Show current command
set showcmd

" Show line and column
set ruler

" Highlight found terms
set hlsearch

" Do not jump back to matching parens
set noshowmatch

" Always display the file name at the bottom
set modeline
set ls=2

" Remove the buffer when a tab is closed
set nohidden

" Re-read a file if it's been edited outside vim
set autoread

" Prefer Unix file endings to Windows ones.
" (This is a default on a Linux system but not on a Windows one)
set fileformats=unix,dos

" Split down or to the right
set splitright
set splitbelow

" Show line numbers
set number
" Numbers take up four columns
set numberwidth=4

" Make the window 120 columns wide, plus 4 for the line numbers
if &columns < 124
	set columns=124
endif

" Mark column 121
set colorcolumn=121

" Tabs are four spaces wide, and aren't expanded into spaces
set tabstop=4
set shiftwidth=4
set noexpandtab

" Show tabs and trailing whitespce
set list
set listchars=tab:>\ ,trail:~

" Don't start with spell checking
set nospell

" Autocomple commands and such
set wildmenu
set wildmode=longest,list,full

" Default completion sources are .,w,b,u,t,i
set complete=.,w,b,t,i
" Complete options (disable preview scratch window)
set completeopt=menu,menuone,longest

" Continue comment headers when enter is pressed
set formatoptions+=or

" Code folding based on syntax
set foldmethod=syntax
set foldlevelstart=99

" Mouse support
set mouse=a

" Backspace default behavior
set backspace=2

" .tex files are LaTeX by default
let g:tex_flavor = "latex"

" File type detection and syntax highlighting
filetype on
syntax on

" No fancy indentation
set nocindent
set noautoindent
set smartindent

" I find the LaTeX auto indenting annoying
au BufRead,BufNewFile *.tex set inde=

" SemTeX gets LaTeX highlighting
au BufRead,BufNewFile *.stex set filetype=tex
au BufRead,BufNewFile *.sex set filetype=tex

" *.md is Markdown, not modula 2
au BufRead,BufNewFile *.md set filetype=markdown

" 8 tabs for fstab are 8 spaces
au BufRead,BufNewFile fstab setlocal tabstop=8

if match($TERM, "xterm") == 0
	" Make sure we support 256 colors in the terminal emulator
	set t_Co=256
	" Set our color scheme
	colorscheme torte
endif
if has("gui_running")
	" Set our color scheme
	colorscheme torte
	" Behave like the console version
	set guioptions=aci

	" Set our font
	" Windows needs additional font params
	if has("win32")
		set guifont=Envy\ Code\ R:h10
	else
		set guifont=Envy\ Code\ R
	endif

	" Cursor preferences
	set guicursor=n-v-c:block-Cursor
	set guicursor+=o:hor50-Cursor
	set guicursor+=i-r:ver15-iCursor
	set guicursor+=a:blinkwait700-blinkon700-blinkoff700

	" Color preferences
	highlight Cursor guibg=fg guifg=bg gui=NONE
	highlight iCursor guibg=NONE guifg=NONE gui=reverse
	highlight Search guibg=blue guifg=white
	highlight Pmenu guibg=white guifg=black
	highlight PmenuSel guibg=blue guifg=white gui=bold
	highlight PmenuSbar guibg=white
	highlight PmenuThumb guifg=DarkGray
	highlight StatusLine guifg=black gui=bold
	highlight ModeMsg gui=NONE
	highlight Visual guibg=blue guifg=white gui=NONE
	highlight Folded guibg=bg guifg=fg gui=italic
	highlight MatchParen guifg=fg guibg=blue
	highlight LineNr guifg=gray
	highlight NonText guifg=gray
	highlight Normal guifg=white
	highlight SpecialKey guifg=#505050

else
	" Color preferences
	highlight Search ctermbg=blue ctermfg=white
	highlight Pmenu ctermbg=white ctermfg=black
	highlight PmenuSel ctermbg=blue ctermfg=white cterm=bold
	highlight PmenuSbar ctermbg=white
	highlight PmenuThumb ctermfg=DarkGray
	highlight ModeMsg cterm=NONE
	highlight Visual ctermbg=blue ctermfg=white cterm=NONE
	highlight Folded ctermbg=black ctermfg=white
	highlight MatchParen ctermfg=NONE ctermbg=blue
	highlight LineNr ctermfg=gray
	highlight NonText ctermfg=gray
	highlight Normal ctermfg=white
	highlight SpecialKey ctermfg=237
endif

" Key mapping and functions

function! ToggleSpell()
	set spell!
	if &spell
		echo "Spell check enabled"
	else
		echo "Spell check disabled"
	endif
endfunction

function! ToggleSpellSuggest()
	if match(&complete, "kspell") < 0
		set spell " Spell check needs to be enabled
		set complete+=kspell
		echo "Spelling suggestions enabled"
	else
		set complete-=kspell
		echo "Spelling suggestions disabled"
	endif
endfunction

" Inspired by http://www.drbunsen.org/writing-in-vim.html
function! WordProcessorMode()
	set formatoptions=l
	set spell spelllang=en_us
	set complete+=kspell
	set formatprg=par\ w\ 120
	set wrap
	set linebreak
	set nolist " List breaks word wrapping
	set colorcolumn&
	map j gj
	map k gk
	echo "Enabled word processor mode"
endfunction

function! RemoveTrailingWhitespace()
	let l:line = line('.')
	let l:column = col('.')
	%s/\s\+$//ge
	call cursor(l:line, l:column)
	echo "Removed trailing whitespace"
endfunction

" Reload settings
noremap <leader>r :so ~/.vimrc<CR>

" Enable and disable spell check with a key press
noremap <leader>sc :call ToggleSpell()<CR>
" Enable and disable suggestions from the spelling dictionary with a key press
noremap <leader>ss :call ToggleSpellSuggest()<CR>
" Enable and disable automatic hard wrapping
noremap <leader>w :call WordProcessorMode()<CR>
" Trim trailing whitespace
noremap <leader>t :call RemoveTrailingWhitespace()<CR>
" ctags this directory using C++ settings
noremap <leader>c :silent !ctags --sort=1 --c++-kinds=+p --fields=+iaS --extra=+fq ./*<CR>
" Build main.stex in the current directory (useful for note-taking)
noremap <leader>p :!semtex -v -p xelatex main.stex<CR>
" Do the same for the current file
noremap <leader>P :!semtex -v -p xelatex %<CR>

" Make Y consistent with C, D, etc.
noremap Y y$
" Space shuts off search highlighting
noremap <Space> :noh<CR>
" Make the enter key do something useful
noremap <CR> o<Esc>
noremap <S-CR> O<Esc>

"--------------------
" Function: Open tag under cursor in new tab
" Source:   http://stackoverflow.com/questions/563616/vimctags-tips-and-tricks
"--------------------
noremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Insert mode mappings
inoremap <C-j> <Esc>o
inoremap <C-k> <Esc>O
inoremap <C-l> <Esc>>>A
" C-h is backspace in the windows shell, causing some issues
if has("gui_running") || !has("win32")
	inoremap <C-h> <Esc><<A
endif
