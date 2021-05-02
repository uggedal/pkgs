if exists('g:loaded_dev')
  finish
endif

let g:loaded_dev = 1

lua require'dev'
