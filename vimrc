" USEFULL DOC FOR SCRIPTING
" useful lkn for vimscripting https://devhints.io/vimscript
" fzf vim function docs https://github.com/junegunn/fzf/blob/master/README-VIM.md

" import tabline configuration
if  filereadable("~/.config/vim/tabline.vim")
  source ~/.config/vim/tabline.vim
endif

" set colorscheme
colorscheme slate

" set relative line numbers
set relativenumber

" enable syntax highlighting
syntax on

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" set space as tab characters and tab dimension to 2
set tabstop=2
set expandtab

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" KEYMAPS
" vim maps miniguide
" for knowledge :help :map
" [niv][nore]map charsequence charsequence

" set space as the leader key
nnoremap <SPACE> <Nop>
let mapleader=" "

" set shortcut for cycling tabs

" forward
noremap <Leader>bn gt

" backward
noremap <Leader>bb gT

" close buffer
nnoremap <Leader>c :bw<CR>
nnoremap <Leader>C :bw!<CR>

" save buffer
nnoremap <Leader>w :w<CR>

" quit vim
nnoremap <Leader>q :qa<CR>
nnoremap <Leader>Q :qa!<CR>

" open vim configuration
nnoremap <Leader>Vc :tabe $MYVIMRC<CR>

" reload vim configuration
nnoremap <Leader>Vr :source $MYVIMRC<CR>
noremap <Leader>e :tabedit .<CR>

" ALE options

" enable default ALE completition
let g:ale_completion_enabled = 1

" remove error highlight
let g:ale_set_highlights = 0

" set error messages format
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
nnoremap <Leader>lf :ALEFix<CR>
nnoremap <Leader>lS :ALEStopAllLSPs<CR>

" fzf options
let $FZF_DEFAULT_OPTS = '--cycle --bind "ctrl-j:down,ctrl-k:up,alt-j:preview-down,alt-k:preview-up,tab:toggle-up,btab:toggle-down"'

" git shortcut
 if  ! empty(glob('/usr/bin/git'))
  noremap <Leader>G :! git<Space>
 endif

" lazygit shortcut
if  ! empty(glob('/usr/bin/lazygit'))
  nmap <Leader>gg :!lazygit<CR>
else
  " if lazygit is absent, handy solution
  nmap <Leader>gg :!git diff --name-only \| fzf --cycle --multi --preview 'git diff {}' \| xargs git add<CR>
endif
  
" set shortcut for fuzzyfinder
nmap <Leader>ff :call fzf#run({'sink':'tabedit'})<CR>

if  ! empty(glob('./.git'))
  " show only git managed files
  nmap <Leader>fg :call fzf#run({'source': 'git ls-files', 'sink':'tabedit'})<CR>
endif

" keep cursor on center when scrolling files
nnoremap n nzz
nnoremap N Nzz

nnoremap { {zz
nnoremap } }zz

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" wrap word into symbols
nmap <Leader>m` i`<Esc>ea`<Esc>
nmap <Leader>m' i'<Esc>ea'<Esc>
nmap <Leader>m" i"<Esc>ea"<Esc>
nmap <Leader>m[ i[<Esc>ea]<Esc>
nmap <Leader>m{ i{<Esc>ea}<Esc>
nmap <Leader>m( i(<Esc>ea)<Esc>
nmap <Leader>m< i<<Esc>ea><Esc>

" copy to clipboard (wayland only)
if ! empty(glob('/usr/bin/wl-copy'))
  vnoremap <silent>Y :w !wl-copy<CR><CR>
  nnoremap <silent>Y :call system("wl-copy", @")<CR>
endif


" tab command shortcut
nnoremap <Leader>te :tabedit<Space>
