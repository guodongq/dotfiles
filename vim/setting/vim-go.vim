let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" debug
let g:go_fmt_command = "goimports"
autocmd FileType go nnoremap <buffer> <leader>db :GoDebugBreakpoint<CR>
autocmd FileType go nnoremap <buffer> <leader>dn :GoDebugNext<CR>
autocmd FileType go nnoremap <buffer> <leader>di :GoDebugStep<CR>
autocmd FileType go nnoremap <buffer> <leader>do :GoDebugStepOut<CR>
autocmd FileType go nnoremap <buffer> <leader>dp :GoDebugPrint<CR>
autocmd FileType go nnoremap <buffer> <leader>dc :GoDebugContinue<CR>


"nnoremap <F7> :GoDebug
