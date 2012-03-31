set nocompatible

" display incomplete commands
set showcmd

" tabs/indents
set expandtab
set tabstop=4
set shiftwidth=4

" line width
set textwidth=79
:au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>79v.\+', -1)

set background=dark

" works fine when you save often
set noswapfile

set wrap
set vb t_vb=
set nohlsearch
set ignorecase
set smartcase
set modeline
set dictionary=/usr/share/dict/words

filetype indent on

" stash backup files in one place
set backup
silent execute '!mkdir ~/.backup 2>/dev/null'
set backupdir=~/.backup/
au BufWritePre * let &bex = '@' . substitute(getcwd(), '/', '%', 'g')

" syntax highlighting
filetype plugin on
syntax on
highlight LineNr ctermfg=darkgray

" java specific
let java_highlight_all=1
let java_ignore_javadoc=1
let java_highlight_java_lang_ids=1
highlight javaComment ctermfg=DarkGreen

" eclim settings
let b:EclimLocationListFilter = ["R cannot be resolved to a variable", "TODO"]
let g:EclimJavaImportExclude = ["^android.R",]
let g:EclimPythonValidate=0

" status line
set laststatus=2
set statusline=%F%m%r%h%w\ %=%l,%v(%L\L)

" folds
"set foldnestmax=2
"set foldmethod=indent
au BufWinLeave * mkview
au BufWinEnter *.* silent loadview

" javaimp plugin
let g:JavaImpPaths="/home/bourke/documents/android-15-src/," .
    \ "/home/bourke/sandbox/ActionBarSherlock/library/src," .
    \ "/usr/lib/jvm/java-6-sun-1.6.0.26/src," .
    \ "/home/bourke/sandbox/twitter4j-android-2.2.5/twitter4j-core/src/main/java/twitter4j/"
let g:JavaImpDataDir = $HOME . "/vim/JavaImp"
let g:JavaImpDocPaths = "/home/bourke/bin/android-sdk-linux_x86/docs/reference," .
    \ ""
let g:JavaImpDocViewer = "google-chrome"

" F2 to toggle paste
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" F4 to call clearmatches()
:nnoremap <F4> :call clearmatches()<CR>

" F5 to delete all trailing whitespace
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" F6 to call JavaImp
:nnoremap <F6> :JavaImpSilent<CR>

" F7 to call clean redundant Java imports and sort them
function JavaImpClean()
    %!/home/bourke/bin/clean_imports.sh %
    :JavaImpSort
endfunction
:command JavaImpClean exec JavaImpClean()
:nnoremap <F7> :JavaImpClean<CR>
