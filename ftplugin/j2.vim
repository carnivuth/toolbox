" comment blocks in visual mode
vnoremap <Leader>c I#<ESC>
nnoremap ci{ c2i{
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']

inoremap ' ''<C-c>i
inoremap ` ``<C-c>i
inoremap " ""<C-c>i
inoremap ( ()<C-c>i
inoremap [ []<C-c>i
inoremap { {}<C-c>i
