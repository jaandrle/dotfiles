""" VIM config file | Jan Andrle | 2025-04-05 (VIM >=9.1 AppImage)
"" #region B – Base
	scriptencoding utf-8 | set encoding=utf-8
	set pythonthreedll=/lib/x86_64-linux-gnu/libpython3.12.so.1.0
	let $BASH_ENV = "~/.bashrc"
	set runtimepath^=~/.vim/bundle/*
	packadd! matchit
	packadd! cfilter
	let g:ft_man_folding_enable = 1
	runtime! ftplugin/man.vim
	" set hidden
	
	set title
	colorscheme codedark
	set updatetime=300 "TODO DEL lazyredraw
	set noerrorbells novisualbell
	set belloff=esc
	set confirm
	set guioptions-=T
	set shortmess-=i
	
	cabbrev <expr> %PWD%  execute('pwd')
	cabbrev <expr> %CD%   fnameescape(expand('%:p:h'))
	cabbrev <expr> %CS%   mini_enhancement#selectedText()
	cabbrev <expr> %CW%   expand('<cword>')
	
	let mapleader = "\\"
	" better for my keyboard, but maybe use `:help keymap`?
	nnoremap § @
	nnoremap §§ @@
	nnoremap ů ;
	nnoremap ; :
	nnoremap <leader>u U
	nnoremap U <c-r>
	nnoremap ž <c-]>
	nnoremap <c-up> <c-y>
	nnoremap <c-down> <c-e>
	" <c-bs>
	imap  <c-w>
	cmap  <c-w>
	
	if has("patch-8.1.0360")
		set diffopt+=algorithm:patience,indent-heuristic | endif
	set diffopt+=iwhite
	augroup vimrc_help
		autocmd!
		autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | vertical resize 90 | endif
	augroup END
	
	""" #region BB – Build-in plugins
	" https://github.com/rbtnn/vim-gloaded/blob/master/plugin/gloaded.vim
	let g:loaded_vimballPlugin = 1 " :h pi_vimball … for plugin creators
	let g:vifm_replace_netrw= 1 | let g:loaded_netrw= 1 | let g:loaded_netrwPlugin= 1  " this line needs to be commented to let vim dowmload spelllangs!!! … see http://jdem.cz/fgyw25
	""" #endregion BB
"" #endregion B
"" #region H – Helpers
	" TODO DEL
	command! -nargs=?  CLscratch 10split | enew | setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted | if <q-args>!='' | execute 'normal "'.<q-args>.'p' | endif | nnoremap <buffer> ;q :q<cr>
	
	cabbrev ALTR ALTredrawSyntax
	command! -nargs=0
		\ ALTredrawSyntax edit | exec 'normal `"' | exec 'set ft='.&ft
	
	let g:quickfix_len= 0
	function! QuickFixStatus() abort
		hi! link User1 StatusLine
		if !g:quickfix_len	| return 'Ø' | endif
		if g:quickfix_len>0 | return g:quickfix_len | endif
		let type= &termguicolors ? 'gui' : 'cterm'
		execute 'hi! User1 '.type.'bg='.synIDattr(synIDtrans(hlID('StatusLine')), 'bg').
			\' '.type.'fg='.synIDattr(synIDtrans(hlID('WarningMsg')), 'fg')
		return -g:quickfix_len
	endfunction
	function! s:QuickFixCmdPost() abort
		let q_len= len(getqflist())
		let g:quickfix_len= q_len ? -q_len : len(getloclist(0))
	endfunction
	augroup quickfix
		autocmd!
		autocmd QuickFixCmdPost * call <sid>QuickFixCmdPost()
	augroup END
"" #endregion H
"" #region SLH – Status Line + Command Line + History (general) + Sessions + File Update, …
	set showcmd cmdheight=2 showmode
	set wildmenu wildoptions=pum,fuzzy
	"" wildmode=list:longest,list:full									" Tab autocomplete in command mode

	cabbrev wbw w<bar>bw
	
	set sessionoptions-=options
	
	function! NumberOfBuffers()
		return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
	endfunction
	set laststatus=2																	 " Show status line on startup
	set statusline+=··≡·%{QuickFixStatus()}%*··»·%{user_tips#current()}%*··%=
	set statusline+=(%{NumberOfBuffers()})··%<%f%R\%M··▶·%{&fileformat}·%{&fileencoding?&fileencoding:&encoding}·%{&filetype}
	set statusline+=··
	" set statusline+=··∷·%{mini_sessions#name('–')}·· 
	
	set history=500													  " How many lines of (cmd) history has to remember
	set nobackup nowritebackup noswapfile		  " …there is issue #649 (for servers) and I’m using git/system backups
	try
		set undodir=~/.vim/undodir undofile | catch | endtry
	command! CLundotree UndotreeToggle | echo 'Use also :undolist :earlier :later' | UndotreeFocus
	command! SETundoClear let old_undolevels=&undolevels | set undolevels=-1 | exe "normal a \<BS>\<Esc>" | let &undolevels=old_undolevels | unlet old_undolevels | write
"" #endregion SLH
"" #region LLW – Left Column + Line + Wrap + Scrolling
	set signcolumn=yes
	set cursorline cursorcolumn															" Always show current position
	set number foldcolumn=2								  " enable line numbers and add a bit extra margin to the left
	set colorcolumn=+1																				  " …marker visual
	" TODO DEL
	command -nargs=? SETtextwidth if <q-args> | let &textwidth=<q-args> | let &colorcolumn='<args>,120,240' | else | let &textwidth=250 | let &colorcolumn='120,240' | endif
	SETtextwidth																	" wraping lines and show two lines
	set nowrap											" Don't wrap long lines by default
	set breakindent breakindentopt=shift:2 showbreak=↳ 
	
	set scrolloff=5 sidescrolloff=10										" offset for lines/columns when scrolling
"" #endregion LLW
"" #region CN – Clipboard + Navigation throught Buffers + Windows + … (CtrlP)
	set pastetoggle=<F2> | nnoremap <F2> :set invpaste paste?<CR>
	function! JaaCopyRegister()
		echo "Copy content of the register: "
		let sourceReg = nr2char(getchar())
		if sourceReg !~# '\v^[a-z0-9"*+]'
			echon sourceReg." – invalid register"
			return
		endif
		echon sourceReg."\ninto the register: "
		let destinationReg = nr2char(getchar())
		if destinationReg !~# '\v^[a-z0-9"*+]'
			echon destinationReg." – invalid register"
			return
		endif
		call setreg(destinationReg, getreg(sourceReg, 1))
		echon destinationReg
	endfunction
	nnoremap <silent> <leader>" :call JaaCopyRegister()<cr>
	
	" CtrlP previously
	nmap <expr> š buffer_number("#")==-1 ? ":CocList --normal buffers\<cr>" : "\<c-^>"
	nmap ě :CocList 
	nmap <leader>3 :buffers<cr>:b<space>
	nmap <leader>š :CocList buffers<cr> | :syntax on<cr>
	nmap č <leader>š
"" #endregion CN
"" #region FOS – File(s) + Openning + Saving
	set autowrite autoread | autocmd FocusGained,BufEnter *.* checktime
	set modeline
	function! JaaAppendModeline(additional= 0)
		let l:modeline= printf(" vim: set tabstop=%d shiftwidth=%d textwidth=%d %sexpandtab :",
			\ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
		let l:modeline= substitute(&commentstring, "%s", l:modeline, "")
		call append(line("$"), l:modeline)
		
		if !a:additional | return 0 | endif
		if &foldmethod=="marker"
			let l:modeline= printf(" vim>60: set foldmethod=marker foldmarker=%s :",
				\ &foldmarker)
		elseif &foldmethod=="indent"
			let l:modeline= printf(" vim>60: set foldmethod=indent foldlevel=%d foldnestmax=%d:",
				\ &foldlevel, &foldnestmax)
		else
			return 0
		endif
		let l:modeline= substitute(&commentstring, "%s", l:modeline, "")
		call append(line("$"), l:modeline)
	endfunction

	set path+=src/**,app/**,build/**														" File matching for `:find`
	for ignore in [ '.git', '.npm', 'node_modules' ]
		exec ':set wildignore+=**'.ignore.'**'
		exec ':set wildignore+=**/'.ignore.'/**'
	endfor
	set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
	set wildignore+=*.pdf,*.psd

	nmap <leader>e :Vifm<cr>
	nnoremap gx :silent exec "!xdg-open '".shellescape(substitute(expand('<cfile>'), '?', '\\?', ''), 1)."'" \| redraw!<cr>
	vnoremap gx :silent exec "!xdg-open '".shellescape(substitute(mini_enhancement#selectedText(), '?', '\\?', ''), 1)."'" \| redraw!<cr>
"" #endregion FOS
"" #region EN – Editor navigation + search
	set grepprg=LC_ALL=C\ grep\ -HRIns
	set hlsearch incsearch														  " highlight search, start when typing
	if maparg('<C-L>', 'n') ==# ''
		nnoremap <silent> <c-l> :nohlsearch<c-r>=has('diff')?'<bar>diffupdate':''<cr><cr><c-l> | endif " TODO? <bar>syntax sync fromstart
	
	let g:markbar_persist_mark_names = v:false
	let g:markbar_cache_with_hidden_buffers = v:false							" last buffers are reopened as hidden https://github.com/Yilin-Yang/vim-markbar/blob/9f5a948d44652074bf2b90d3da6a400d8a369ba5/doc/vim-markbar.txt#L136
	nmap <Leader>m <Plug>ToggleMarkbar
"" #endregion EN
"" #region EA – Editing adjustment + Syntax + White chars + Folds
	" use <c-v>§ for §
	inoremap § <esc>
	set nrformats-=octal

	let g:htl_css_templates=1
	let g:markdown_fenced_languages= [ 'javascript', 'js=javascript', 'json', 'html', 'php', 'bash', 'vim', 'vimscript=javascript', 'sass' ]
	augroup conceal
		autocmd!
		au FileType markdown
			\  syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal
			\| syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends
		au FileType markdown,json 
			\ setlocal conceallevel=2
	augroup END
	augroup convenient
		autocmd FileType markdown,text setlocal keywordprg=dict
		autocmd FileType git,gitcommit setlocal foldmethod=syntax foldlevel=1
	augroup END
	" PARENTHESES plugin junegunn/rainbow_parentheses.vim
	let g:rainbow#pairs= [['(', ')'], ['[', ']'], [ '{', '}' ]]
	let g:rainbow#blacklist = [203,9]
	autocmd VimEnter * try
		\| call rainbow_parentheses#toggle() | catch | endtry
	" HIGHLIGHT&YANK plugins (buildin) hlyank & cwordhi.vim
	packadd hlyank
	let g:hlyank_duration= 250
	let g:cwordhi#autoload= 1
	set showmatch												" Quick highlight oppening bracket/… for currently writted
	set timeoutlen=1000 ttimeoutlen=0												   " Remove timeout when hitting escape TAB
	if v:version > 703 || v:version == 703 && has("patch541")
		set formatoptions+=j | endif							" Delete comment character when joining commented lines
	set smarttab
	" TODO DEL
	command! -nargs=1 SETtab let &shiftwidth=<q-args> | let &tabstop=<q-args> | let &softtabstop=<q-args>
	SETtab 4
	set backspace=indent,eol,start					" Allow cursor keys in insert mode:  http://vi.stackexchange.com/a/2163
	set shiftround autoindent	" round diff shifts to the base of n*shiftwidth,  https://stackoverflow.com/a/18415867
	filetype plugin indent on
	" SYNTAX&COLORS
	if ($TERM =~ '256' && has("termguicolors"))
		set termguicolors | endif
	if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
		syntax enable | endif
	set list listchars=tab:»·,trail:·,extends:#,nbsp:~,space:·		" Highlight spec. chars / Display extra whitespace
	set redrawtime=10000
	augroup syntax_sync_min_lines
		autocmd!
		autocmd BufEnter * syntax sync fromstart "TODO DEL syn sync minlines=2000
	augroup END
	let g:vim_vue_plugin_config = { 'foldexpr': 1, 'attribute': 1, 'keyword': 1 }
	" SPELL
	if !has("gui_running")
		hi clear SpellBad | hi SpellBad cterm=underline,italic | endif
	command! -nargs=? SETspell if <q-args>==&spelllang || <q-args>=='' | set spell! | else | set spell | set spelllang=<args> | endif | if &spell | set spelllang | endif
	" EDIT HEPERS
	nnoremap <leader>o o<space><bs><esc>
	nnoremap <leader>O O<space><bs><esc>
	nnoremap <s-k> a<cr><esc>
	for l in [ 'y', 'p', 'P', 'd' ] | for m in [ 'n', 'v' ]
		execute m.'map <leader>'.l.' "+'.l | endfor | endfor " no noremap ⇐ https://github.com/jasonccox/vim-wayland-clipboard?tab=readme-ov-file#non-recursive-mappings
	" TODO DEL: FOLDS
	" TODO DEL: command! -nargs=0 SETFOLDregions set foldmethod=marker
	" TODO DEL: command! -nargs=1 SETFOLDindent set foldmethod=indent | let &foldlevel=<q-args> | let &foldnestmax=<q-args>+1
	" TODO DEL: command! -nargs=* SETFOLDindents set foldmethod=indent | let &foldlevel=split(<q-args>, ' ')[0] | let &foldnestmax=split(<q-args>, ' ')[1]
	set foldmarker=#region,#endregion
	" SAVE VIEW
	set viewoptions=cursor,folds
	augroup remember__view
		autocmd!
		autocmd BufWinLeave *.* if &buflisted | mkview | endif
		autocmd BufWinEnter *.* silent! loadview
	augroup END
"" #endregion EA
"" #region AI
let g:codeium_disable_bindings = 1
imap <script><silent><nowait><expr> <f3><f3> codeium#Accept()
imap <script><silent><nowait><expr> <f3><w> codeium#AcceptNextWord()
imap <script><silent><nowait><expr> <f3><j> codeium#AcceptLine()
imap <f3>n   <Cmd>call codeium#CycleCompletions(1)<CR>
imap <f3>N   <Cmd>call codeium#CycleCompletions(-1)<CR>
imap <f3>d   <Cmd>call codeium#Clear()<CR>
imap <f3>!   <Cmd>call codeium#Complete()<CR>
"" #endregion AI
"" #region COC – COC and so on, compilers, code/commands completions
	let g:coc_global_extensions= ['coc-css', 'coc-docthis', 'coc-emmet', 'coc-emoji', 'coc-git', 'coc-pretty-ts-errors', 'coc-eslint', 'coc-gitmoji', 'coc-html', 'coc-json', 'coc-lists', 'coc-marketplace', 'coc-phpls', 'coc-sh', 'coc-snippets', 'coc-styled-components', 'coc-svg', 'coc-tsserver']
	" https://github.com/antonk52/cssmodules-language-server
	call coc#config('languageserver.cssmodules', {
	\ "command": "cssmodules-language-server",
	\ "initializationOptions": {"camelCase": "dashes"},
	\ "filetypes": ["javascript", "javascriptreact", "typescript", "typescriptreact"],
	\ "requireRootPattern": 0,
	\ "settings": {}
	\ })
	autocmd FileType scss setl iskeyword+=@-@
	function! CustomKeyWord(word)
		if(a:word=="gulp_place")
			highlight link gulp_place ErrorMsg
			syntax match gulp_place "gulp_place"
			augroup gulp_place
				autocmd!
				autocmd BufEnter *.{js,html} syntax match gulp_place "gulp_place"
			augroup END
			return 0
		endif
	endfunction

	set completeopt=menuone,longest,preview "longest vs ,noinsert,noselect
	inoremap <silent><expr> <F1> coc#pum#visible() ? coc#pum#confirm() : coc#refresh()
	set wildcharm=<f1>
	inoremap <silent><expr> <tab> coc#pum#visible() ? coc#pum#next(1) : <sid>check_back_space() ? "\<tab>" : coc#refresh()
	inoremap <silent><expr> <s-tab> coc#pum#visible() ? coc#pum#prev(1) : "\<c-h>"
	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	nmap <silent><nowait> gd <Plug>(coc-definition)
	command! -nargs=* -complete=customlist,<sid>SCommandCocActionComplete CocAction call CocActionAsync(<f-args>)
	function s:SCommandCocActionComplete(argLead, cmdLine, cursorPos)
		return readfile(expand('~/.vim/pack/coc/start/coc.nvim/doc/tags'), 'r')
			\->filter('v:val =~ ''^CocAction''')
			\->map({ k, v -> strpart(v, 11, stridx(v, ')')-12) })
			\->filter({ k, v -> v =~ a:argLead && !v->empty() })
	endfunction
					" navigate diagnostics, use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
	nnoremap <silent> gh :call <sid>show_documentation(expand("<cword>"))<cr>
	vnoremap <silent> gh :<c-u>call <sid>show_documentation(mini_enhancement#selectedText())<cr>
	nnoremap <leader>gf :CocList --interactive --normal --input='<c-r>=expand("<cword>")<cr>' files<cr>
	vnoremap <leader>gf :<c-u>CocList --interactive --normal --input='<c-r>=mini_enhancement#selectedText()<cr>' files<cr>
	""" #region COCP – Coc popups scroll (Remap <C-f> and <C-b> for scroll float windows/popups.)
	if has('nvim-0.4.0') || has('patch-8.2.0750')
		nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
		nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
		inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
		inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
		vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
		vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	endif
	""" #endregion COCP

	command! -nargs=?  CLhelpMy if <q-args>!='' | exec 'map '.<q-args> | else | call popup_notification([
		\ 'Custom mappings starting: '.mapleader.',§, ů, ;, U, ž',
		\ 'Custom commands starting: CL, SET, ALT, Vifm, Coc',
		\ 'Helpful commands: CocAction, CocCommand, CocList',
		\], #{ line: &lines-3, pos: 'botleft', moved: 'any', close: 'button', time: 6000 }) | endif
	nnoremap <c-g> :CLwhereami<cr>
	command! CLwhereami			   :call popup_notification([
										\expand('%:t').( coc#status() != "" ? '/'.CocAction("getCurrentFunctionSymbol")."\t…\t".coc#status() : '' ),
										\"– – –",
										\"Line:\t".line('.').' / '.line('$'),
										\"Column:\t".col('.').' / '.col('$'),
										\"Path:\t".expand('%:p:h')
										\], #{ line: &lines-3, pos: 'botleft', moved: 'any', close: 'button', time: 6000 })
	command! CLhelpCocPlug		   call feedkeys(':<c-u>help <Plug>(coc ', 'tn')
	command! CLhelpCocAction	   call feedkeys(':<c-u>help CocAction(''	', 'tn')
	command! -nargs=? -bang
		   \ CLreplace			   call feedkeys(':<c-u>'.(<q-args>==''?'.':<q-args>).'s/'.("<bang>"=='!'?mini_enhancement#selectedText():expand('<cword>')).'//cgODODOD', 'tn')
	command! CLrepeatLastChange    call feedkeys('/\V<C-r>"<CR>cgn<C-a><Esc>', 'tn')
	command! CLjshintGlobal		   normal yiwmm?\/\* global<cr><c-l>f*hi, p`m
	
	function! AIcodeFn(range, ...) range abort
		let l:instruction = 'Hi, can you help me with ' . &filetype . 'code? Thanks in advance. I would like to: '
		if a:0
			let l:instruction = l:instruction .  a:1
		endif
		if a:range
			'<,'>call vim_ai#AIRun(a:range, {}, l:instruction)
		else
			call vim_ai#AIRun(a:range, {}, l:instruction)
		endif
	endfunction
	command! -range -nargs=? AIcode <line1>,<line2>call AIcodeFn(<range>, <f-args>)
	vnoremap <f1> :AI<f1>
	nnoremap <f1> :AI<f1>
	command! -nargs=?
		   \ CLcheat call cheat_copilot#open(<q-args>==''?&filetype:<q-args>)
	
	function! s:show_documentation(word)
		if (!CocAction('hasProvider', 'hover'))
			if &filetype=='man' | call dist#man#PreGetPage(0) | return 0 | endif
			return feedkeys('K', 'in')
		endif
		if &filetype=='html' && coc#source#custom_elements#hover(a:word)!=0
			return 0
		endif
		
		return CocActionAsync('doHover')
	endfunction
"" #endregion COC

" vim: set textwidth=250 :
" vim>60: set foldmethod=marker foldmarker=#region,#endregion :
