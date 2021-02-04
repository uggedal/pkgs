" vimwiki
augroup vimwikitemplate
	autocmd!
	autocmd BufNewFile ~/src/notes/diary/*.md :silent 0r !vimwiki-work-diary-template '%'
augroup END
