" Activates the Pathogen plugin (package vim-pathogen on Debian).
silent! call pathogen#infect()
silent! call pathogen#helptags()

" Enable syntax highlighting.
syntax enable

" Activate file type plugins.
filetype plugin indent on

function CanWriteToDir(PathToDir)

    " Returns a truthy value if the argument PathToDir is the path to a
    " writable directory. If the directory does not exist, then the function
    " attempts to create it, with permission 0700 (rwx------: readable and
    " writable only for the owner).

    let l:Ret = (filewritable(a:PathToDir) == 2)
    if !l:Ret
        if exists("*mkdir")
            silent! call mkdir(a:PathToDir, "p", 0700)
        endif
        let l:Ret = (filewritable(a:PathToDir) == 2)
    endif
    return l:Ret

endfunction

" Get the path to the Vim home directory (~/.vim on Unix / Linux systems).
let s:DotVimPath = split(&runtimepath,",")[0]

let s:BackupDir = s:DotVimPath . "/backup"
if CanWriteToDir(s:BackupDir)
    set backup

    " Write backup files preferably in "~/.vim/backup".
    let &backupdir = s:BackupDir . "," . &backupdir
endif

let s:SwapDir = s:DotVimPath . "/swap"
if CanWriteToDir(s:SwapDir)

    " Write swap files preferably in "~/.vim/swap". The "//" causes Vim to name
    " the swap files based on the full path name of the edited files.
    let &directory = s:SwapDir . "//" . "," . &directory
endif

" Don't wrap lines.
set nowrap

" Highlight search.
set hlsearch

" Disable temporarily the search highlighting when the user presses Ctrl-H.
nnoremap <C-H> :nohlsearch<CR>

" Do incremental search.
set incsearch

" Make tabs, trailing spaces and end of lines show up and make a '+' show up
" in the last column of the screen if the line is longer than the window width.
set listchars=tab:>-,trail:-,eol:$,extends:+
set list

if !has("win16") && !has("win32") && !has("win64") && !has("win32unix")
            \ && $LANG =~# "\.UTF-8$"
    " Make the split separator appear like a thin line.
    set fillchars+=vert:│
endif

" Don't show the tool bar.
set guioptions-=T

" Don't show the menu.
set guioptions-=m

" Don't show the scroll bars.
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=b

" Use the whole window height.
set guiheadroom=0

" Do not use automatic folding.
set foldmethod=manual

" Invert foldenable when the user presses the space bar.
nnoremap <space> zi

" On Windows, try to use Consolas font, On Unix / Linux, try to use
" Inconsolata.
if has("unix")
    silent! set guifont=inconsolata\ 12
elseif has("win32")
    silent! set guifont=Consolas
endif

" Do auto-indentation.
set autoindent

" Apply the Moria color scheme if installed, available at
" http://www.vim.org/scripts/script.php?script_id=1464).
set background=dark
silent! color moria

" Make "," the "leader" key (instead of the backslash).
let mapleader = ","

if !has("win16") && !has("win32") && !has("win64") && !has("win32unix")
            \ && $LANG =~# "\.UTF-8$"
    " Make guides displayed by the plugin indentLine appear like
    " thin lines (https://github.com/Yggdroot/indentLine).
    let g:indentLine_char = '│'
endif

" Make regular expression mode the default search mode in the Ctrl-P plugin
" (https://github.com/kien/ctrlp.vim).
let g:ctrlp_regexp = 1

" Have Ctrl-P plugin scan hidden files and directories.
let g:ctrlp_show_hidden = 1

" Use single leader key instead of double leader key in the EasyMotion plugin
" (https://github.com/Lokaltog/vim-easymotion).
let g:EasyMotion_leader_key = '<Leader>'

" Remap <Leader>w to the bidirectional word search function of the EasyMotion
" plugin.
map <Leader>w <Plug>(easymotion-bd-w)

" Make the BufExplorer plugin (https://github.com/jlanzarotta/bufexplorer)
" show relative paths by default.
let g:bufExplorerShowRelativePath = 1
