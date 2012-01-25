" No vi compatibility
set nocompatible

" No text wrapping
set nowrap

" Show current command
set showcmd

" Show line and column
set ruler

" Highlight found terms
set hlsearch

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

" Make the window 80 columns wide, plus 4 for the line numbers
set columns=84

" Mark column 81
set colorcolumn=81

" Wrap text to column 80
set textwidth=80
let g:default_textwidth = &textwidth

" Tabs are four spaces wide, and aren't expanded into spaces
set tabstop=4
set shiftwidth=4
set noexpandtab

" auto indent (this may not be needed with auto syntax detection)
set autoindent

" File type detection and syntax highlighting
filetype plugin indent on
syntax on
set grepprg=grep\ -nH\ $*

" I type in english.
set spl=en spell
" Except when I'm coding, so don't start with spell checking
set nospell

" Autocomple commands and such
set wildmenu
set wildmode=list:longest,full

" OmniCppComplete:
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
" Don't auto complete anything.
let OmniCpp_MayCompleteDot = 0
let OmniCpp_MayCompleteArrow = 0
let OmniCpp_MayCompleteScope = 0


" Default completion sources are .,w,b,u,t,i
" Instead, only complete based on include files and the current buffer
set complete=.,i
" Complete options (disable preview scratch window)
set completeopt=menu,menuone,longest


" SuperTab:
" SuperTab option for context aware completion
let g:SuperTabDefaultCompletionType="context"

" Code folding based on syntax
set foldmethod=syntax
set foldlevelstart=99

" Mouse support
set mouse=a

" Backspace default behavior
set backspace=2

" .tex files are LaTeX by default
let g:tex_flavor = "latex"

" I find the LaTeX auto indenting annoying
au BufRead,BufNewFile *.tex set inde=

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
	highlight Cursor guibg=NONE guifg=NONE gui=reverse
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

else
	" Color preferences
	highlight Cursor ctermbg=NONE ctermfg=NONE cterm=reverse
	highlight iCursor ctermbg=NONE ctermfg=NONE cterm=reverse
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
		set complete+=kspell
		echo "Spelling suggestions enabled"
	else
		set complete-=kspell
		echo "Spelling suggestions disabled"
	endif
endfunction

function! ToggleWrap()
	if (&textwidth > 0)
		let b:last_textwidth = &textwidth
		set textwidth=0
		echo "Disabled auto-wrap"
	else
		if exists("b:last_textwidth")
			let &textwidth=b:last_textwidth
		else
			let &textwidth=g:default_textwidth
		endif
		echo "Enabled auto-wrap. textwidth set to " . &textwidth
	endif
endfunction

function! RemoveTrailingWhitespace()
	let l:line = line('.')
	let l:column = col('.')
	%s/\s\+$//ge
	call cursor(l:line, l:column)
	echo "Removed trailing whitespace"
endfunction

" Map <leader> to comma
let mapleader=','

" Reload settings
if has("win32")
	noremap <leader>r :so ~/_vimrc<CR>
else
	noremap <leader>r :so ~/.vimrc<CR>
endif

" Enable and disable spell check with a key press
noremap <leader>sc :call ToggleSpell()<CR>
" Enable and disable suggestions from the spelling dictionary with a key press
noremap <leader>ss :call ToggleSpellSuggest()<CR>
" Enable and disable automatic hard wrapping
noremap <leader>w :call ToggleWrap()<CR>
" Trim trailing whitespace
noremap <leader>t :call RemoveTrailingWhitespace()<CR>
" ctags this directory using C++ settings
noremap <leader>c :silent !ctags -a --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q ./*<CR>

" Make Y consistent with C, D, etc.
noremap Y y$
" Ctrl-A is select all
noremap <C-a> ggvG$
" Space shuts off search highlighting
noremap <Space> :noh<CR>
" Make the enter key do something useful
noremap <CR> o<Esc>
noremap <S-CR> O<Esc>
" Make <C-i> and <C-j> do something similar in insert mode
inoremap <C-j> <Esc>o
inoremap <C-k> <Esc>O

" Resize the screen with movement keys
noremap <C-j> :set lines+=1<CR>:echo &lines<CR>
noremap <C-k> :set lines-=1<CR>:echo &lines<CR>
noremap <C-l> :set columns+=1<CR>:echo &columns<CR>
noremap <C-h> :set columns-=1<CR>:echo &columns<CR>

" Do the same with internal windows
noremap <C-w>j <C-w>+
noremap <C-w>k <C-w>-
noremap <C-w>l <C-w>>
noremap <C-w>h <C-w><

"--------------------
" Function: Open tag under cursor in new tab
" Source:   http://stackoverflow.com/questions/563616/vimctags-tips-and-tricks
"--------------------
noremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
