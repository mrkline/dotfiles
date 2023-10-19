call plug#begin()

Plug 'neovim/nvim-lspconfig'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'vijaymarupudi/nvim-fzf' " requires the nvim-fzf library
Plug 'vijaymarupudi/nvim-fzf-commands'

call plug#end()

"" Plugin config:

" We don't want per-filetype plugins running - they blow away omnifunc and
" other stuff set below.
filetype plugin off
filetype indent on

lua require('hls')
lua require('lspconfig').rust_analyzer.setup{}
noremap K :lua vim.lsp.buf.hover()<CR>
noremap <leader>a :lua vim.lsp.buf.code_action()<CR>
noremap <leader>D :lua vim.lsp.buf.declaration()<CR>
noremap <leader>d :lua vim.lsp.buf.definition()<CR>
noremap <leader>r :lua vim.lsp.buf.references()<CR>
set omnifunc=v:lua.vim.lsp.omnifunc

" Airline's mixed indentation messages are often wrong. Turn them off
let g:airline#extensions#whitespace#checks = [ 'trailing' ]
let g:airline_theme='papercolor'

" Get rid of the hot pink FZF widow.
set winhighlight=Normal:Normal

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

" Show line numbers
set number

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
highlight NormalFloat ctermfg=NONE ctermbg=NONE

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
noremap <leader>R :so ~/.config/nvim/init.vim<CR>

" Toggle relative numbers on and off
noremap <C-n> :set relativenumber!<CR>
" Enable and disable spell check with a key press
noremap <leader>sc :call ToggleSpell()<CR>
" Enable and disable suggestions from the spelling dictionary with a key press
noremap <leader>ss :call ToggleSpellSuggest()<CR>
" Enable and disable automatic hard wrapping
noremap <leader>w :call WordProcessorMode()<CR>
" Trim trailing whitespace
noremap <leader>rw :call RemoveTrailingWhitespace()<CR>

" Make Y consistent with C, D, etc.
noremap Y y$
" Space shuts off search highlighting
noremap <Space> :noh<CR>
" Make the enter key do something useful
noremap <CR> o<Esc>
noremap <S-CR> O<Esc>

" Insert mode mappings
inoremap <C-j> <Esc>o
inoremap <C-k> <Esc>O

" Use Ctrl+d for digraphs
inoremap <C-d> <C-k>
cnoremap <C-d> <C-k>

" FZF!
noremap <leader>f :lua require('fzf-commands').files()<CR>

command! -nargs=1 Rg call luaeval('require("fzf-commands").rg(_A)', <f-args>)
noremap <leader>g :call luaeval('require("fzf-commands").rg(_A)', expand("<cword>"))<CR>

" Neovim: When in the terminal, use Ctrl+] to escape the terminal,
" then seek to the end of the last non-whitespace.
if (has('nvim'))
    tnoremap <C-]> <C-\><C-n>G$:call search('\S', 'b')<CR>$
endif
