" comment blocks in visual mode
vnoremap <Leader>c I#<ESC>
nnoremap <Leader>r :! python %<ESC>

let b:ale_fixers = ['prettier']

inoremap ' ''<C-c>i
inoremap [ []<C-c>i
inoremap { {}<C-c>i
inoremap ( ()<C-c>i
inoremap " ""<C-c>i
inoremap ` ``<C-c>i
