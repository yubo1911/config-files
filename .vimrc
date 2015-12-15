execute pathogen#infect()
autocmd BufNewFile *.py exec ":call SetTitle()"
func SetTitle()
	if &filetype == 'python'
		call setline(1, "# -*- coding: utf-8 -*-")
	endif
	autocmd BufNewFile * normal G
endfunc
function CheckDo()
	execute ':w'
	let s:bufname=bufname("%")
	let s:filename=getcwd() . "/" . bufname("%")
	if matchstr(s:filename, "[.]py$") != ""
	\ && matchstr(s:filename, "\/data\/") == ""
	\ && matchstr(s:filename, "\/cdata\/") == ""
		let s:pfret=system("pyflakes " . s:bufname)
		if s:pfret!=""
			echohl Statement
			echo "Pyflakes Warning or Error"
			echohl ErrorMsg
			echo s:pfret
			echohl None
		endif
	endif
endfunction
set list
filetype plugin indent on
set listchars=tab:\|\ ,
set ls=2
set grepprg=ack-grep\ -a
ca wq call CheckDo()
ca w call CheckDo()
