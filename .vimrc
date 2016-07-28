set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Bundle 'Valloric/YouCompleteMe'
call vundle#end()            " required
filetype plugin indent on    " required
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
autocmd filetype python set ts=8
autocmd filetype python set sw=8
autocmd filetype python set sts=8
autocmd filetype python set noet
set listchars=tab:\|\ ,
set ls=2
set grepprg=ack-grep\ -a
ca wq call CheckDo()
ca w call CheckDo()
set foldmethod=indent
set foldlevel=99
nnoremap <space> za
nnoremap gl :YcmCompleter GoToDeclaration<CR>
nnoremap gf :YcmCompleter GoToDefinition<CR>
nnoremap gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap <F4> :YcmDiags<CR>
let g:syntastic_cpp_compiler = "g++"
let g:syntastic_cpp_compiler_options = "-std=c++11 -stdlib=libc++"
