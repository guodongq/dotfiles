cnoreabbrev Ack Ack!
nnoremap <leader>sa :Ack!<Space>

if executable('ag')
    let g:ackprg = 'ag --vimgrep --nogroup --column'
endif

" 高亮搜索关键词
let g:ackhighlight = 1
