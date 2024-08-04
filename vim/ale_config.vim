" ALE options

" enable default ALE completition
let g:ale_completion_enabled = 1

" remove error highlight
let g:ale_set_highlights = 0

" set error messages format
let g:ale_virtualtext_cursor = 'disabled'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" enable ALE lint only on filesave
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

" ALE bindings
nnoremap <Leader>l :ALE
nnoremap <Leader>ld :ALEGoToDefinition<CR>
nnoremap <Leader>li :ALEGoToImplementation<CR>
nnoremap <Leader>ln :ALENext<CR>
nnoremap <Leader>lp :ALEPrevious<CR>
nnoremap <Leader>lf :ALEFix<CR>
nnoremap <Leader>lS :ALEStopAllLSPs<CR>

let g:ale_fixers = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace']
      \}
