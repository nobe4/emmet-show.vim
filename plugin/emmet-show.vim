" load plugin only once
" && verify vim is nocompatible
if exists("g:emmet_show_version") || &cp
	  finish
endif

" plugin version
let g:emmet_show_version = 0.1

" create the new emmet buffer where the preview will be placed
function! s:NewEmmetBuffer()
	new
	set ft=html " change filetype for preview coloration
	" map every key in insertmode to call the rendering
	autocmd CursorMovedI <buffer> :call EmmetAutoShow()
	" map return to save and quit
	nnoremap <buffer> <CR> :call CloseEmmetBuffer()<CR>
endfunction

" render the emmet line
function! s:EmmetAutoShow()
	" save the current cursor position to the register a
	" yank the current line and past it below
	normal mayyp
	" if there are more than two lines
	" remove every line below the one just copied
	if line('$') > 2
		:3,$:d
	endif
	" move the cursor to the end of the copied line
	normal $
	" expand the emmet abbreviaiton
	call emmet#expandAbbr(3,"")
	" go back to the saved cursor position
	normal `a
	" go back in insert mode 
	startinsert!
endfunction

" save the emmet line and close the buffer
function! s:CloseEmmetBuffer()
	normal yy
	quit!
endfunction

" define user-accessible command
command! SE call s:NewEmmetBuffer()
