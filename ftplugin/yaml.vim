" comment blocks in visual mode
vnoremap <Leader>c I#<ESC>
nnoremap ci{ c2i{

" add elements to begining and endig of a visual highlighted block
vnoremap ` <ESC>`>a`<ESC>`<i`<ESC>
vnoremap ( <ESC>`>a)<ESC>`<i(<ESC>
vnoremap [ <ESC>`>a]<ESC>`<i[<ESC>
vnoremap { <ESC>`>a}<ESC>`<i}<ESC>
vnoremap ' <ESC>`>a'<ESC>`<i'<ESC>
vnoremap " <ESC>`>a"<ESC>`<i"<ESC>
