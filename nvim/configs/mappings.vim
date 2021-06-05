" Integrations {
	" Yank things into the system clipboard selection register
	map <Leader>y "+y
	map <Leader>d "+d
	map <Leader>p "+p
" }

" Split & Buffer Management {
	noremap <A-k> <CMD>wincmd k<CR>
	noremap <A-j> <CMD>wincmd j<CR>
	noremap <A-h> <CMD>wincmd h<CR>
	noremap <A-l> <CMD>wincmd l<CR>
	noremap <A-Up> <CMD>wincmd k<CR>
	noremap <A-Down> <CMD>wincmd j<CR>
	noremap <A-Left> <CMD>wincmd h<CR>
	noremap <A-Right> <CMD>wincmd l<CR>
	noremap <A-c> <CMD>wincmd c<CR>
	noremap <A-s> <CMD>wincmd s<CR>
	noremap <A-v> <CMD>wincmd v<CR>
	noremap <A-o> <CMD>wincmd o<CR>

	nnoremap <A-L> <CMD>bnext<CR>
	nnoremap <A-S-Right> <CMD>bnext<CR>
	nnoremap <A-H> <CMD>bprevious<CR>
	nnoremap <A-S-Left> <CMD>bprevious<CR>
" }

" Text Navigation {
	nmap <Space> <Plug>(easymotion-prefix)
	nmap <Space>j <Plug>(easymotion-j)
	nmap <Space>k <Plug>(easymotion-k)
	nmap <Space><Down> <Plug>(easymotion-j)
	nmap <Space><Up> <Plug>(easymotion-k)

	tnoremap <Esc> <C-\><C-n>	" Exit terminal mode with Esc

	noremap <S-Up> 5k
	noremap <S-k> 5k
	noremap <S-Down> 5j
	noremap <S-j> 5j
" }

" Searches {
	noremap <silent><space>/ :call fzf#vim#buffer_lines()<cr>
	noremap <silent><space><Tab> :call fzf#vim#buffers()<cr>
	noremap <silent><space>' :call fzf#vim#marks()<cr>
	noremap <silent><space>t :BTags<cr>
	noremap <space>T <CMD>Tags<cr>
	nnoremap <Space>p <CMD>call fzf#vim#buffers(@")<CR>/<C-r>
	nnoremap <Space>" :registers<CR>/<C-r>
	" Search for visual selection
	vnoremap / y/<C-r>"<CR>
	vnoremap <Space>/ y:BLines <C-r>"<CR>
	" Clear search with \/
	nnoremap // <CMD>noh<CR>
	" Search files
	nnoremap <Leader>e <CMD>GFiles<CR>
	nnoremap <Leader>E <CMD>Files<CR>
	" Search wiki files by filename
	nnoremap <Leader>we <CMD>Files ~/vimwiki/<CR>
	nnoremap <Leader>w<Tab> <CMD>Files ~/vimwiki/<CR>
	" Search wiki contents entirely with rg
    function! VimwikiRGFZF(query, fullscreen)
      let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s ~/vimwiki/ || true'
      let initial_command = printf(command_fmt, shellescape(a:query))
      let reload_command = printf(command_fmt, '{q}')
      let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction
    command! -nargs=* -bang RgWiki call VimwikiRGFZF(<q-args>, <bang>0)
	nnoremap <Leader>w/ <CMD>RgWiki<CR>
	vnoremap <Leader>w/ y:RgWiki <C-r>"<CR>
" }

" Menus & Popups {
	nnoremap <silent><Leader>t :TagbarToggle<CR>
	nnoremap <silent><Leader>T :NERDTree<CR>

	autocmd FileType fzf tnoremap <Tab> <Down>
	autocmd FileType fzf tnoremap <S-Tab> <Up>

	inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"		" Tab to cycle completions forwards
	inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"	" S-Tab to cycle completions back
	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"	" Enter to select completions
	
	inoremap <Leader><Tab> <Tab>
	" make Esc kill the fzf buffer
	tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
	
	inoremap <silent><expr> <C-Space> compe#complete()	" Start completion with Ctrl+Space
" }

" Queries {
	nnoremap ?? <CMD>call fzf#vim#helptags()<CR>
	noremap <silent>?c :call fzf#vim#commands()<cr>
	noremap <silent>?n :call fzf#vim#maps("n")<cr>
	noremap <silent>?i :call fzf#vim#maps("i")<cr>
	noremap <silent>?v :call fzf#vim#maps("v")<cr>
	nnoremap ?" <CMD>registers<CR>
	nnoremap ?q <CMD>lua vim.lsp.buf.hover()<CR>
	nnoremap <Leader>q <CMD>lua vim.lsp.buf.hover()<CR>
	inoremap <Leader>q <CMD>lua vim.lsp.buf.hover()<CR>
	nnoremap ?s <CMD>call CocAction('showSignatureHelp')<CR>
	inoremap <Leader>s <CMD>call CocAction('showSignatureHelp')<CR>
	nnoremap <Leader>s <CMD>call CocAction('showSignatureHelp')<CR>
" }

" Code editing {
	nnoremap <silent><Leader>/ <cmd>Commentary<cr> " Comment things out with ctrl + /
	vmap <silent><Leader>/ gc
	nnoremap <Leader>a <CMD>lua vim.lsp.buf.code_action()<CR>
" }

" Line numbers & Reading Assistance {
	function! InvNumberFoldColumn()
		if &number
			setlocal foldcolumn=2
			setlocal nonumber
			setlocal norelativenumber
		else
			setlocal foldcolumn=0
			setlocal number
		endif
	endfunction
	function! InvRelativeNumberFoldColumn()
		if &relativenumber
			setlocal foldcolumn=0
			setlocal number
			setlocal norelativenumber
		else 
			setlocal foldcolumn=0
			setlocal number
			setlocal relativenumber
		endif
	endfunction

	nnoremap <Leader>n <CMD>call InvNumberFoldColumn()<CR>
	nnoremap <Leader>N <CMD>call InvRelativeNumberFoldColumn()<CR>
	nnoremap <Leader><C-n> <CMD>set cursorline!<CR>

	" Toggle limelight with (h)ighlight
	nmap <silent><Leader>h :Limelight!!<cr>
	nmap <silent><Leader>H :Limelight!! 0.975<cr>
" }

" Vimwiki {
	" Make ctrl-x set a todo list item to won't-do
	autocmd FileType vimwiki nnoremap <C-x> :VimwikiToggleRejectedListItem<cr>
	" Navigate between tag sections 
	autocmd FileType vimwiki nmap <A-]> ]]
	autocmd FileType vimwiki nmap <A-[> [[
	autocmd FileType vimwiki nnoremap <Leader>w<Leader>h <CMD>0r !~/vimwiki/bin/diaryheader.sh '%'<cr>
	autocmd FileType vimwiki nnoremap <Leader>wd <CMD>0r !~/vimwiki/bin/diaryheader.sh '%'<cr>

	autocmd FileType vimwiki nnoremap <silent><Leader>wt :r !date '+\%I:\%M\%p'<CR>I*<esc>A*<space>

	" Make leader-w-leader-t open tomorrow's diary page
	nnoremap <silent><Leader>w<Leader>t :VimwikiMakeTomorrowDiaryNote<cr>
" }
