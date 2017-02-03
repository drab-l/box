set ambiwidth=double
set clipboard=unnamed
set nocompatible
set number
set showmatch
set autoindent
set smartindent
set cinoptions+=:0,(0
set smarttab
set tabstop=8
set hlsearch
set foldopen=all
set nofoldenable
colorscheme elflord
augroup InsertHook
	autocmd!
	autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
	autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

function! ZenkakuSpace()
	highlight ZenkakuSpace cterm=reverse ctermfg=Blue gui=reverse guifg=Blue
endfunction

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis,utf-8
set listchars=tab:>-,trail:-,eol:↲,extends:>,precedes:<,nbsp:%
set list
"set cursorline
highlight JpSpace ctermbg=darkcyan guibg=darkcyan
au BufRead,BufNew * match JpSpace /　/
set backspace=indent,eol,start "Backspaceを調整
set statusline=%<%f\ %m%{&ro?'[RO]':''}%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V,%p%%
set laststatus=2
syntax on
autocmd QuickFixCmdPost *grep* cwindow
set grepprg=grep\ -nrH
set ignorecase
set smartcase
if has('syntax')
	augroup ZenkakuSpace
	autocmd!
	autocmd ColorScheme       * call ZenkakuSpace()
	autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
	augroup END
	call ZenkakuSpace()
endif
if has('path_extra')
	set tags+=tags;${HOME}
endif
noremap <C-j> :GtagsCursor<CR>
noremap <C-n> :cn<CR>
noremap <C-p> :cp<CR>

set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

let g:neocomplete#enable_at_startup = 1
NeoBundleLazy "Shougo/neocomplete.vim", {"autoload": {"insert": 1,}}
let g:neocomplete#enable_at_startup = 1
let s:hooks = neobundle#get_hooks("neocomplete.vim")
function! s:hooks.on_source(bundle)
	let g:acp_enableAtStartup = 0
	let g:neocomplete#enable_ignore_case = 1
	let g:neocomplete#enable_smart_case = 1
	let g:neocomplete#sources#dictionary#dictionaries = {
		\ 'default' : '',
		\ }
endfunction

"NeoBundle 'https://github.com/scrooloose/syntastic.git'

NeoBundle 'https://github.com/neomake/neomake'
let g:neomake_error_sign = {'text': '>>', 'texthl': 'Error'}
let g:neomake_warning_sign = {'text': '>>',  'texthl': 'Todo'}
autocmd BufWritePost * Neomake

NeoBundleLazy 'https://github.com/vim-erlang/vim-erlang-omnicomplete.git', {"autoload": {"filetypes": ['erlang']}}
NeoBundleLazy 'https://github.com/vim-erlang/vim-erlang-runtime.git', {"autoload": {"filetypes": ['erlang']}}

NeoBundleLazy "lambdalisue/vim-django-support", {"autoload": {"filetypes": ["python", "python3", "djangohtml"]}}
NeoBundleLazy "jmcantrell/vim-virtualenv", {"autoload": {"filetypes": ["python", "python3", "djangohtml"]}}

NeoBundleLazy "davidhalter/jedi-vim", {"autoload": {"filetypes": ["python", "python3", "djangohtml"]}}
let s:hooks = neobundle#get_hooks("jedi-vim")
function! s:hooks.on_source(bundle)
	autocmd FileType python setlocal omnifunc=jedi#completions
	let g:jedi#completions_enabled = 0
	let g:jedi#auto_vim_configuration = 0
	let g:jedi#popup_select_first = 0
	if !exists('g:neocomplete#force_omni_input_patterns')
		let g:neocomplete#force_omni_input_patterns = {}
	endif
	let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
endfunction

call neobundle#end()

runtime! ftplugin/man.vim
"runtime! ftplugin/erlang.vim

filetype plugin indent on

autocmd FileType python setlocal completeopt-=preview

noremap K :Man <C-r><C-w><CR>
