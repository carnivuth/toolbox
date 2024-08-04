" git shortcut
if  ! empty(glob('/usr/bin/git'))
  noremap <Leader>G :! git<Space>
endif

" lazygit shortcut
if  ! empty(glob('/usr/bin/lazygit'))
  nmap <Leader>gg :!lazygit<CR>
else
  " if lazygit is absent, handy solution
  nmap <Leader>gg :! lz_git.sh<CR>
endif
