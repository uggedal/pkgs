""
"" Productivity
""

" vimwiki
let g:vimwiki_global_ext = 0
let wiki_1 = {}
let wiki_1.path = '~/src/notes/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'
let wiki_1.index = 'README'

let g:vimwiki_list = [wiki_1]
let g:vimwiki_ext2syntax = {'.md': 'markdown'}
let g:vimwiki_markdown_link_ext = 1

" taskwiki
let g:taskwiki_sort_order = 'status+,end+,due+,project+'
