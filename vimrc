" vimrc
" jwc < http://jwcxz.com>
"
" see especially the key mappings section
" also, I use ack instead of grep, so if vimgrep breaks, that's why (grepprg)

if has('vim_starting')
    set nocompatible
    let g:completer = 'youcompleteme'
endif

let g:cfg_vimcfg_dir = expand('~/.vim')

exec 'source ' . g:cfg_vimcfg_dir.'/vimrc.neobundle.vim'

autocmd!
" stop vim from pushing # to indent level 0 on python files
autocmd Filetype python set cms=#%s | inoremap # X<C-h>#
autocmd Filetype c set grepprg=ag\ --cc
" }}}

" {{{ general behavior 
set isk=a-z,A-Z,48-57,_
set fdm=syntax
set foldlevelstart=20
set mouse=nvcr
set history=50
set ttyfast
set hidden
set cryptmethod="blowfish"

syntax enable
filetype plugin indent on

set wildmode=longest,list
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

set modeline
set foldcolumn=1
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set et
set hlsearch
set incsearch

set ruler
set laststatus=2

set autoindent
set smartindent
set backspace=indent,eol,start

set ignorecase
set smartcase

set grepprg=ag

let mapleader='\'
" }}}

" {{{ key mappings 
    " sneak.vim mappings
    let  g:sneak#nextprev_f = 0
    let  g:sneak#use_ic_scs = 1
    nmap F      <Plug>SneakBackward
    nmap <ESC>f <Plug>SneakForward
    nmap ,      <Plug>SneakNext
    nmap _      <Plug>SneakPrevious
    xmap ,      <Plug>VSneakNext
    xmap _      <Plug>VSneakPrevious
    silent! nunmap s
    silent! nunmap S

    " C-{hjkl} resize windows
    map <silent> <C-h> <C-w><
    map <silent> <C-j> <C-w>-
    map <silent> <C-k> <C-w>+
    map <silent> <C-l> <C-w>>

    " C-{n,p} move between buffers
    noremap <silent> <C-p> :bp<CR>
    noremap <silent> <C-n> :bn<CR>

    " ; is C-w, ;, is ,
    "noremap <silent> ,  ;
    "noremap <silent> ;, ,
    noremap <silent> ;  <C-w>
    noremap <silent> ;] <C-w><C-]>

    " alt-{n,p} move between tabs, alt-t creates a new tab, alt-c closes one
    noremap <silent> <Esc>n :tabnext<CR>
    noremap <silent> <Esc>p :tabprev<CR>
    noremap <silent> <Esc>t :tabnew<CR>
    noremap <silent> <Esc>c :tabclose<CR>

    " tt means :ta
    noremap <silent> tt :ta 

    " unite.vim
	call unite#filters#matcher_default#use(['matcher_fuzzy'])

	autocmd FileType unite call s:unite_custom_settings()
	function! s:unite_custom_settings() "{{{
        nmap <buffer> <ESC> <Plug>(unite_all_exit)
        nmap <buffer> ;c    <Plug>(unite_all_exit)
        nmap <buffer> '     <Plug>(unite_quick_match_default_action)

        imap <buffer> <TAB> <Plug>(unite_select_next_line)
        imap <buffer> '     <Plug>(unite_quick_match_default_action)
        imap <buffer> <C-o> <ESC><Plug>(unite_all_exit)
        imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
	endfunction "}}}

	nnoremap <silent> ;; :<C-u>Unite -start-insert buffer<CR>
    nnoremap <silent> ;t :<C-u>Unite -start-insert tag<CR>
	nnoremap <silent> ;f :<C-u>Unite -start-insert file<CR>
	nnoremap <silent> ;R :<C-u>Unite -start-insert file_rec<CR>
	nnoremap <silent> ;r :<C-u>Unite -start-insert file_rec/async<CR>

    " tree view
    nnoremap <F10> :NERDTreeToggle<CR>
    nnoremap ;aF   :NERDTreeFind<CR>

    " taglist
    nnoremap <silent> <F9> :Tlist<CR>
    nnoremap <silent> ;aT  :TlistOpen

    " Xorg paste escape codes
    map  <ESC>[200~ :set paste<CR>a
    map  <ESC>[201~ :set nopaste<CR>
    imap <ESC>[200~ <C-o>:set paste<CR>
    imap <ESC>[201~ <nop>
    set  pastetoggle=<ESC>[201~
" }}}

" {{{ filetype commands
    autocmd Filetype tex noremap K :w<CR>:!pdflatex -halt-on-error %<CR>
" }}}

" {{{ color 
set cursorline
let g:airline_theme = 'murmur'
let g:tmuxline_powerline_separators = 0
let g:airline_left_sep = ' '

if &term =~ "256"
    " 256-color terminals get a modified version of lucius
    set t_Co=256
    colorscheme lucius
    LuciusDark

    " make things a little nicer
    hi Normal       ctermfg=255  ctermbg=none
    hi NonText                   ctermbg=none
    hi VertSplit    ctermfg=234  ctermbg=234
    hi Comment      ctermfg=250
    hi Todo         ctermfg=160
    hi Pmenu        ctermfg=250  ctermbg=237
    hi PmenuSel     ctermfg=186  ctermbg=59
    hi CursorLine                ctermbg=17
    hi CursorColumn              ctermbg=17
    hi TabLine      ctermfg=244  ctermbg=238 cterm=underline
    hi TabLineFill  ctermfg=244  ctermbg=238 cterm=underline
else
    colorscheme murphy
    hi CursorLine   term=underline
    hi CursorColumn term=underline
    hi PmenuSel     cterm=none  ctermfg=yellow  ctermbg=black
    hi PmenuThumb   cterm=none  ctermfg=yellow  ctermbg=yellow
    hi PmenuSbar    cterm=none  ctermfg=cyan    ctermbg=cyan
endif
" }}}

" {{{ completion
    if g:completer ==? 'youcompleteme'
        NeoBundleSource YouCompleteMe

        let g:ycm_enable_diagnostic_signs = 0
        let g:ycm_key_invoke_completion =''
        let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
        let g:ycm_confirm_extra_conf = 0
        let g:ycm_autoclose_preview_window_after_completion = 1
    elseif g:completer ==? 'neocomplete'
        NeoBundleSource neocomplete

        let g:neocomplete_use_vimproc = 1

        " Disable AutoComplPop.
        let g:acp_enableAtStartup = 0
        " Use neocomplcache.
        let g:neocomplete#enable_at_startup = 1
        " Use smartcase.
        let g:neocomplete#enable_smart_case = 1
        " Use camel case completion.
        "let g:neocomplcache_enable_camel_case_completion = 1
        " Use underbar completion.
        "let g:neocomplcache_enable_underbar_completion = 1
        " Set minimum syntax keyword length.
        let g:neocomplete#sources#syntax#min_keyword_length = 5
        let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

        " Define dictionary.
        let g:neocomplete#sources#dictionary#dictionaries = {'default' : ''}

        " Define keyword.
        if !exists('g:neocomplete#keyword_patterns')
            let g:neocomplete#keyword_patterns = {}
        endif
        let g:neocomplete#keyword_patterns['default'] = '\h\w*'

        " Plugin key-mappings.
        "imap <C-k>           <Plug>(neocomplcache_snippets_expand)
        "smap <C-k>           <Plug>(neocomplcache_snippets_expand)
        inoremap <expr><C-g> neocomplete#undo_completion()
        inoremap <expr><C-l> neocomplete#complete_common_string()

        " SuperTab like snippets behavior.
        "imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

        " Recommended key-mappings.
        " <CR>: close popup and save indent.
        inoremap <expr><CR>  neocomplete#smart_close_popup() ."\<CR>"
        " <TAB>: completion.
        "inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y> neocomplete#close_popup()
        inoremap <expr><C-e> neocomplete#cancel_popup()

        " AutoComplPop like behavior.
        "let g:neocomplcache_enable_auto_select = 1

        " Enable omni completion.
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

        NeoCompleteEnable
    elseif g:completer ==? 'neocomplcache'
        NeoBundleSource neocomplcache

        NeoComplCacheEnable
        " Disable AutoComplPop.
        let g:acp_enableAtStartup = 0
        " Use neocomplcache.
        let g:neocomplcache_enable_at_startup = 1
        " Use smartcase.
        let g:neocomplcache_enable_smart_case = 1
        " Use camel case completion.
        "let g:neocomplcache_enable_camel_case_completion = 1
        " Use underbar completion.
        "let g:neocomplcache_enable_underbar_completion = 1
        " Set minimum syntax keyword length.
        let g:neocomplcache_min_syntax_length = 5
        let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

        " Define dictionary.
        let g:neocomplcache_dictionary_filetype_lists = {'default' : ''}

        " Define keyword.
        if !exists('g:neocomplcache_keyword_patterns')
            let g:neocomplcache_keyword_patterns = {}
        endif
        let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

        " Plugin key-mappings.
        imap <C-k>           <Plug>(neocomplcache_snippets_expand)
        smap <C-k>           <Plug>(neocomplcache_snippets_expand)
        inoremap <expr><C-g> neocomplcache#undo_completion()
        inoremap <expr><C-l> neocomplcache#complete_common_string()

        " SuperTab like snippets behavior.
        "imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

        " Recommended key-mappings.
        " <CR>: close popup and save indent.
        inoremap <expr><CR>  neocomplcache#smart_close_popup() ."\<CR>"
        " <TAB>: completion.
        "inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><BS>  neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y> neocomplcache#close_popup()
        inoremap <expr><C-e> neocomplcache#cancel_popup()

        " AutoComplPop like behavior.
        "let g:neocomplcache_enable_auto_select = 1

        " Enable omni completion.
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

        " Enable heavy omni completion.
        if !exists('g:neocomplcache_omni_patterns')
        let g:neocomplcache_omni_patterns = {}
        endif
        "let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
        "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    endif
" }}}

" {{{ cscope
    if has('cscope')
        "set cscopetag cscopeverbose

        if has('quickfix')
        set cscopequickfix=s-,c-,d-,i-,t-,e-
        endif

        command! -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
    endif
" }}}

" vim: ts=4 sw=4 fdm=marker
