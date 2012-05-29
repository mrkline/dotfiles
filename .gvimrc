" Re-run the vimrc since some settings (notably window width) appear to get
" lost on GUI startup
if has("win32")
	so ~/_vimrc
else
	so ~/.vimrc
endif
" Disable beep on error
set noeb vb t_vb=
