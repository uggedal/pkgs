
""
"" Git
""

" git sync commit leader binding:
function GitCi()
	!cd %:p:h && git add . && git ci -am sync && git push
endfunction
command! GitCi :call GitCi()
nnoremap <leader>g :GitCi<CR>
