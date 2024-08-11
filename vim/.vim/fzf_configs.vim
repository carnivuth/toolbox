" fzf options
let $FZF_DEFAULT_OPTS = '--cycle --bind "ctrl-j:down,ctrl-k:up,alt-j:preview-down,alt-k:preview-up,tab:toggle-up,btab:toggle-down"'

" set shortcut for fuzzyfinder
nmap <Leader>ff :call fzf#run({'sink':'tabedit'})<CR>
nmap <Leader>fc :call fzf#run({'sink':'r ! cat'})<CR>
nmap <Leader>ft :call fzf#run({'source': 'tabs', 'sink':'tabfind'})<CR>

if  ! empty(glob('./.git'))
  " show only git managed files
  nmap <Leader>fg :call fzf#run({'source': 'git ls-files', 'sink':'tabedit'})<CR>
endif

" search pattern in files integration (usinz fzf and ripgrep)
function! Fif(searchTerm)
  let file= system('fif.sh ' .a:searchTerm)
  execute 'tabedit ' .file
  execute 'redraw!'
endfunction

nnoremap <Leader>fw :call Fif("")<Left><Left>
