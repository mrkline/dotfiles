" Disable beep on error
set noeb vb t_vb=

" Behave like the console version
set guioptions=aci

colorscheme torte

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
