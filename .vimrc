" colorscheme seattle
color desert
set number
set autoindent

" https://superuser.com/a/698978
if has('mouse')
  set mouse=a
endif

" Globally prefer spaces to tabs
set expandtab

" Set the current line number to a subtle white
highlight CursorLineNr cterm=none term=none ctermfg=White
highlight CursorLine cterm=none term=none
set cursorline
