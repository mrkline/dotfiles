"" Vundle Setup:
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" My bundles:
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'valloric/youcompleteme'
Plugin 'rust-lang/rust.vim'
Plugin 'tpope/vim-fugitive'
"Plugin 'wincent/command-t'

"" Plugin config:

" YouCompleteMe:
let g:ycm_extra_conf_globlist = ['~/mantis-top/*']
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/youcompleteme/ycm_extra_conf.py'
let g:ycm_min_num_of_chars_for_completion = 8
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_enable_diagnostic_signs = 0

" Airline's mixed indentation messages are often wrong. Turn them off
let g:airline#extensions#whitespace#checks = [ 'trailing' ]
let g:airline_theme='papercolor'

" Use git ls-files and find to scan in Command-T
let g:CommandTFileScanner = "git"

call vundle#end()
filetype plugin indent on

"" Normal vimrc stuff:

" No text wrapping
set nowrap

" Show current command
set showcmd

" Show line and column
set ruler

" Highlight found terms
set hlsearch

" Don't jump around
set noincsearch

" Do not jump back to matching parens
set noshowmatch

" Always display the file name at the bottom
set modeline
set ls=2

" Re-read a file if it's been modified outside vim
set autoread

" Prefer Unix file endings to Windows ones.
" (This is a default on a Linux system but not on a Windows one)
set fileformats=unix,dos

" Split down and to the right
set splitright
set splitbelow

" Show line numbers, relative when not in insert mode.
set number
set relativenumber
" Numbers take up four columns
set numberwidth=4

" Mark column 81 (to encourage 80-column lines)
set colorcolumn=81

" Tabs are four spaces wide, and are expanded into spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Use par with 80-character lines for formatting.
set formatprg=par\ 80

" Show tabs (as >   ) and trailing whitespce (as ~)
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
syntax on

" No fancy indentation
set nocindent
set noautoindent
set smartindent

" I find the LaTeX auto indenting annoying
autocmd BufRead,BufNewFile *.tex set inde=

" SemTeX gets LaTeX highlighting
autocmd BufRead,BufNewFile *.stex set filetype=tex
autocmd BufRead,BufNewFile *.sex set filetype=tex

" *.md is Markdown, not modula 2
autocmd BufRead,BufNewFile *.md set filetype=markdown

" .rs is Rust
autocmd BufRead,BufNewFile *.rs set filetype=rust

" Makefiles use tabs
autocmd BufRead,BufNewFile Makefile setlocal noexpandtab

" https://tools.ietf.org/html/rfc2822#section-2.1.1
" (78 char lines)
autocmd BufRead,BufNewFile,FileType mail call MuttSetup()

function MuttSetup()
	setlocal colorcolumn=79
	setlocal formatprg=par\ 78
	setlocal textwidth=78
endfunction

" Color preferences

set background=light

highlight SpecialKey ctermfg=grey

" Key mapping and functions

function! ToggleRelativeNumbers()
	if &relativenumber
		set norelativenumber
	else
		set relativenumber
	endif
endfunction

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

" Toggle relative numbers on and off
noremap <C-n> :call ToggleRelativeNumbers()<CR>
" Enable and disable spell check with a key press
noremap <leader>sc :call ToggleSpell()<CR>
" Enable and disable suggestions from the spelling dictionary with a key press
noremap <leader>ss :call ToggleSpellSuggest()<CR>
" Enable and disable automatic hard wrapping
noremap <leader>w :call WordProcessorMode()<CR>
" Trim trailing whitespace
noremap <leader>rw :call RemoveTrailingWhitespace()<CR>
" ctags this directory using C++ settings
noremap <leader>c :!ctags --sort=1 --c++-kinds=+p --fields=+iaS --extra=+fq ./*<CR>
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

noremap <C-k> :py3f /usr/share/clang/clang-format.py<CR>

" Insert mode mappings
inoremap <C-j> <Esc>o
inoremap <C-k> <Esc>O

" Use Ctrl+d for digraphs
inoremap <C-d> <C-k>
cnoremap <C-d> <C-k>

" Neovim: When in the terminal, use Ctrl+] to escape the terminal,
" then seek to the end of the last non-whitespace.
if (has('nvim'))
    tnoremap <C-]> <C-\><C-n>G$:call search('\S', 'b')<CR>$
endif
