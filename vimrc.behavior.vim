set isk=a-z,A-Z,48-57,_
set history=50
set ttyfast
set hidden
if has('cryptv')
    set cryptmethod="blowfish"
endif

syntax enable
filetype plugin indent on

set wildmode=longest,list
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

set modeline
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set hlsearch
set incsearch

set autoindent
set smartindent
set backspace=indent,eol,start

set ignorecase
set smartcase

set grepprg=ag


if has('cscope')
    "set cscopetag cscopeverbose

    if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    endif

    command! -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
endif


let g:ag_highlight= 1

let g:sneak#s_next = 0
let g:sneak#use_ic_scs = 1
let g:sneak#textobject_z = 0


" vim: fdm=marker
