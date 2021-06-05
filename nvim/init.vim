let hostname = system('hostname')[:-2]

" Load split config files
let $VIMCONFIGS = $HOME."/.config/nvim/configs"
source $VIMCONFIGS/plugins.vim		" Plugins
source $VIMCONFIGS/mappings.vim		" Mappings

" General nvim settings. Some redundant.
filetype plugin on	" Enables loading plugins for filetypes
set tabstop=4		" Number of spaces that a <Tab> counts for
set shiftwidth=4	" Number of spaces to use for autoindent
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkon100	" Ensures a blinking block/pipe/underscore cursor
set linebreak		" Tells nvim to break at the breakat setting characters instead of doing its own thing
set mouse=a			" Enable using the mouse
set termguicolors	" Enable 24bit colour
set pumblend=15			" Some nice transparency on popup-menu
set foldmethod=syntax	" Default to using syntax-informed folding
autocmd BufWinEnter * normal zR		" Open all folds fully on opening a file
set hlsearch		" Highlight all search results.
set incsearch		" Show incremental search results
set ignorecase		" Ignore case in search patterns
set smartcase		" Override ignorecase if there are upper case letters
set splitright splitbelow 	" Open splits to the right or below
set noshowmode		" Don't show the mode in the cmd area. Airline shows it.
set updatetime=100	" Vim uses updatetime for both the swapfile and cursor holds
set completeopt=menuone,noselect

" Add a margin on the left for non-code files
set nonumber
set foldcolumn=2

" Various settings that are nice to have for coding
function! SetCodingSettings()
	setlocal foldmarker={,}
	setlocal number
	setlocal list listchars=tab:\╵\ \ ,eol:\ 
	setlocal foldmethod=expr
	setlocal foldcolumn=0
endfunction
autocmd FileType rust,cs,glsl,cpp,javascript,sh,gml,vim,caos,lua call SetCodingSettings()
" Some things work better with markers instead
autocmd FileType vim,glsl setlocal foldmethod=marker
