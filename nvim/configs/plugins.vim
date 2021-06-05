" Install vim-plug if we don't have it yet {
	if empty(glob('$HOME/.config/nvim/autoload/plug.vim'))
		silent !curl -fLo $HOME/config/nvim/autoload/plug.vim --create-dirs
			\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
" }

" Plugin Includes {
	call plug#begin()
		Plug 'gruvbox-community/gruvbox'		" Gruvbox colour scheme
		Plug 'folke/lsp-colors.nvim'			" Fills missing LSP hl groups
		Plug 'hoob3rt/lualine.nvim'				" A replacement status bar
		Plug 'vimwiki/vimwiki'					" Wiki for vim
		Plug 'easymotion/vim-easymotion'		" Motions
		Plug 'sheerun/vim-polyglot'				" Language pack
		Plug 'mattn/calendar-vim'				" Calendar command, integrates with vimwiki
		Plug '$HOME/.config/nvim/plugged/securemodelines'	" Stops malicious modelines
		Plug 'majutsushi/tagbar', {'on':['TagbarToggle', 'TagbarOpenAutoClose']}	" Tag browsing & Overview
		Plug 'preservim/nerdtree'				" Filesystem explorer for vim
		Plug 'powerman/vim-plugin-AnsiEsc'		" Makes ANSI escape sequences work nice
		Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }	" fzf integration for fuzzy searching
		Plug 'junegunn/fzf.vim'					" Some useful mappings for fzf
		Plug 'neovim/nvim-lspconfig'			" Helps config the LSP functionality
		Plug 'junegunn/limelight.vim'			" Focus-highlighting
		Plug 'mhinz/vim-startify'				" Customisable vim startpage
		Plug 'tpope/vim-commentary'				" Easier commenting
		Plug 'wellle/targets.vim'				" Additional text object targets
		Plug 'tpope/vim-surround'				" Mappings for operating on surrounds
		Plug 'tpope/vim-repeat'					" Makes . work with more actions
		Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' } " Previews for colour values
		Plug 'lukas-reineke/indent-blankline.nvim', {'branch': 'lua'} " Nicer indent lines
		Plug 'ryanoasis/vim-devicons'			" Icons
		Plug 'nvim-treesitter/nvim-treesitter'	" Syntax Highlighting
		Plug 'hrsh7th/nvim-compe'				" Completion
		Plug 'folke/which-key.nvim'				" key popup
	call plug#end()
" }

" Gruvbox {
	let g:gruvbox_contrast_dark = 'hard'
	if hostname == 'faffPC'
		let g:gruvbox_colors = { 'dark0_hard': '#0c0c0c'}
	else
		let g:gruvbox_colors = { 'dark0_hard': '#1c1c1c'}
	endif
	colorscheme gruvbox
	if hostname == 'faffPC'
		highlight VertSplit guifg=#1D2021 guibg=#1D2021
	else
		highlight VertSplit guifg=#282828 guibg=#282828
	endif
	highlight FoldColumn guifg=bg guibg=bg
" }

" Startify {
	let g:startify_bookmarks = [ 
		\ '~/.config/nvim/init.vim',
		\ '~/.config/nvim/configs/plugins.vim',
		\ '~/.config/nvim/configs/mappings.vim',
		\ '~/.config/nvim/configs/colours.vim'
	\]
" }

" lspconfig {
lua << EOF
	require'lspconfig'.rust_analyzer.setup{}
	require'lspconfig'.bashls.setup{}
	require'lspconfig'.html.setup{}
	require'lspconfig'.vimls.setup{}
	require'lspconfig'.tsserver.setup{}
EOF
" }

" Hexokinase {
	let g:Hexokinase_highlighters = [ 'virtual' ]
" }

" VimWiki {
	let wiki = {}
	let wiki.path = '~/vimwiki/'
	let wiki.nested_syntaxes = {'c++': 'cpp', 'python' : 'python'}
	let wiki.auto_toc = 1
	let wiki.auto_diary_index = 1
	let wiki.auto_tags = 1
	let g:vimwiki_list = [wiki]
	let g:vimwiki_folding = 'syntax'
	let g:vimwiki_use_mouse=1
	let g:vimwiki_use_calendar=1
	let g:vimwiki_listsyms = ' ⡀⣀⣄⣤⣦⣶⣷⣿✓'
	let g:vimwiki_listsym_rejected = '✗'

	function! VimwikiLinkHandler(link)
		" execute the command following an exec: prefix in sh, eg:
		" [[exec:!echo hi uwu here r ur files; ls]]
		if a:link =~ "exec:"
			let exec_cmd = a:link[5:]
			execute exec_cmd
			return 1
		else
			return 0
		endif
	endfunction

	function! VimwikiDiaryRegenerate()
		:VimwikiDiaryGenerateLinks
		:VimwikiTOC
	endfunction
" }

" Tagbar {
	let g:tagbar_type_vimwiki = {
		\   'ctagstype':'vimwiki'
		\ , 'kinds':['h:header']
		\ , 'sro':'&&&'
		\ , 'kind2scope':{'h':'header'}
		\ , 'sort':0
		\ , 'ctagsbin':'$HOME/.config/nvim/bin/vwtags.py'
		\ , 'ctagsargs': 'default'
		\ }
	let g:tagbar_autofocus = 0
	let g:tagbar_autoclose = 0
	let g:tagbar_map_openfold = ['+', '=', '<kPlus>', 'zo']
	let g:tagbar_map_closeallfolds = ['zM']
	let g:tagbar_map_showproto = []
	let g:tagbar_map_nexttag = ['<C-N>', '<Tab>']
	let g:tagbar_map_prevtag = ['<C-P>', '<S-Tab>']
	let g:tagbar_position = 'leftabove vertical'
" }

" NERDTree {
	let NERDTreeQuitOnOpen = 1
	let NERDTreeWinPos = "right"
" }

" Limelight {
	let g:limelight_conceal_guifg = '#3C3836' " '#504945'
	let g:limelight_paragraph_span = 0
	let g:limelight_priority = -1
" }

" Secure Modelines {
	let g:secure_modelines_allowed_items = ['textwidth', 'tw', 'softtabstop', 'sts', 'tabstop', 'ts', 'shiftwidth', 'sw', 'expandtab', 'et', 'noexpandtab', 'noet', 'filetype', 'ft', 'foldmethod', 'fdm', 'readonly', 'ro', 'noreadonly', 'noro', 'rightleft', 'rl', 'norightleft', 'norl', 'cindent', 'cin', 'nocindent', 'nocin', 'smartindent', 'si', 'nosmartindent', 'nosi', 'autoindent', 'ai', 'noautoindent', 'noai', 'spell', 'nospell', 'spelllang', 'foldmarker']
" }

" indentLine / indentblankline {
	let g:indentLine_char = '╵'
	let g:indent_blankline_use_treesitter = 1
	let g:indent_blankline_show_first_indent_level = v:false
" }

" TreeSitter {
lua <<EOF
	require'nvim-treesitter.configs'.setup {
		ensure_installed = "maintained",
		highlight = {
			enable = true,
			disable = { },
		},
		incremental_selection = {
			enable = false,
		},
		indent = {
			enable = true,
		},
	}
EOF
  set foldexpr=nvim_treesitter#foldexpr()
" }

" Lualine {
	function! GetTime()
		return strftime("%I:%M%p")
	endfunction

lua <<EOF
	require('lualine').setup{
		options = {
		  theme = 'gruvbox',
		  section_separators = { '', '' },
		  component_separators = { '', '' },
		  icons_enabled = true,
		},
		sections = {
			lualine_a = { {'mode', upper = true, color = {gui = 'none'}, } },
			lualine_b = { 
				{'branch', icon = ''},
				{'diff', colored = false,
					symbols = {
						added = '+',
						modified = '~',
						removed = '-',
					},
				}, 
			},
			lualine_c = {
				{ 'filename', file_status = true, path = 1 },
				{ 'diagnostics', sources = {'nvim_lsp'} }
			},
			lualine_x = { 'filetype' },
			lualine_y = { 'encoding', 'fileformat' },
			lualine_z = {
				{ 'location', color = {gui = 'none'}},
				{ 'GetTime', color = {gui = 'none'},},
			},
		},
		inactive_sections = {
		  lualine_a = {  },
		  lualine_b = { 
			{'diff', colored = false,
				symbols = {
					added = '+',
					modified = '~',
					removed = '-',
				},
			},
			'filename',
		 },
		  lualine_c = {  },
		  lualine_x = { 'location' },
		  lualine_y = {  },
		  lualine_z = {   }
		},
	  }
EOF
" }

" Compe {
lua <<EOF
	require'compe'.setup {
		enabled = true;
		autocomplete = true;
		debug = false;
		min_length = 2;
		preselect = 'enable';
		documentation = true;

		source = {
			path = true;
			buffer = true;
			calc = true;
			nvim_lsp = true;
			nvim_lua = true;
		};
	}
EOF
" }
