" Plugins {{{
call plug#begin('~/.vim/plugged')

" Language
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'sodapopcan/vim-twiggy'
Plug 'rbong/vim-flog'

" Search etc.
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'do' : { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Colors
Plug 'tomasiser/vim-code-dark'

" Statusbar
Plug 'itchyny/lightline.vim'

call plug#end()

" coc extensions
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-tsserver',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-yaml',
    \ 'coc-java',
    \ 'coc-eslint',
    \ 'coc-emoji',
    \ 'coc-svg',
    \ 'coc-sh',
    \ 'coc-vimlsp',
    \ 'coc-git',
    \ 'coc-xml',
    \ 'coc-yank',
    \ 'coc-highlight',
    \ 'coc-snippets',
    \ 'coc-sourcekit',
    \ 'coc-clangd'
    \ ]

" Update plugins if necessary
augroup plug_install_if_necessary
    autocmd!
    autocmd VimEnter *
        \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
        \|   PlugInstall --sync | q
        \| endif
augroup END

" Use The Silver Searcher for Ack
if executable('ag')
    let g:ackprg = 'ag --hidden --ignore .git --vimgrep'

    let g:ag_prg = 'ag --hidden --ignore .git --vimgrep'

    " Hack to get ag to show hidden files (except .git/)
    let s:ag_options = ' --hidden --ignore .git'
    command! -bang -nargs=* Ag 
        \ call fzf#vim#ag(
        \ <q-args>, 
        \ s:ag_options,
        \ <bang>0 ? fzf#vim#with_preview('up:60%')
        \   : fzf#vim#with_preview('right:50%:hidden', '?'),
        \ <bang>0
        \ )

    nnoremap <leader>F :Ag<cr>
    vnoremap <leader>F :<c-u>Ag<cr>
endif
" }}}

syntax on
set termguicolors
set background=dark
set t_Co=256
set t_ut=
colorscheme codedark
highlight Folded guifg=Grey
highlight Comment cterm=italic term=italic gui=italic

" color overrides {{{
highlight Search guibg=peru guifg=wheat
" }}}

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set number
set relativenumber

set showcmd
set showmatch

set ignorecase
set smartcase
set incsearch
set hlsearch

set splitbelow
set splitright

set inccommand=nosplit

" Vimscript file settings {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

let mapleader = "\<Space>"
let localleader = "\\"

" Tab stuff {{{
" Easily create a new tab.
noremap <Leader>tN :tabnew<CR>
" Easily close a tab.
noremap <Leader>tc :tabclose<CR>
" Easily move a tab.
noremap <Leader>tm :tabmove<CR>
" Easily go to next tab.
noremap <Leader>tn :tabnext<CR>
" Easily go to previous tab.
noremap <Leader>tp :tabprevious<CR>

" Switch between tabs
noremap <Leader>1 1gt
noremap <Leader>2 2gt
noremap <Leader>3 3gt
noremap <Leader>4 4gt
noremap <Leader>5 5gt
noremap <Leader>6 6gt
noremap <Leader>7 7gt
noremap <Leader>8 8gt
noremap <Leader>9 9gt
" }}}

" Window navigation {{{
tnoremap <M-h> <c-\><c-n><c-w>h
tnoremap ˙ <c-\><c-n><c-w>h
tnoremap <M-j> <c-\><c-n><c-w>j
tnoremap ∆ <c-\><c-n><c-w>j
tnoremap <M-k> <c-\><c-n><c-w>k
tnoremap ˚ <c-\><c-n><c-w>k
tnoremap <M-l> <c-\><c-n><c-w>l
tnoremap ¬ <c-\><c-n><c-w>l

inoremap <M-h> <Esc><c-w>h
inoremap ˙ <Esc><c-w>h
inoremap <M-j> <Esc><c-w>j
inoremap ∆ <Esc><c-w>j
inoremap <M-k> <Esc><c-w>k
inoremap ˚ <Esc><c-w>k
inoremap <M-l> <Esc><c-w>l
inoremap ¬ <Esc><c-w>l

vnoremap <M-h> <Esc><c-w>h
vnoremap ˙ <Esc><c-w>h
vnoremap <M-j> <Esc><c-w>j
vnoremap ∆ <Esc><c-w>j
vnoremap <M-k> <Esc><c-w>k
vnoremap ˚ <Esc><c-w>k
vnoremap <M-l> <Esc><c-w>l
vnoremap ¬ <Esc><c-w>l

nnoremap <M-h> <c-w>h
nnoremap ˙ <c-w>h
nnoremap <M-j> <c-w>j
nnoremap ∆ <c-w>j
nnoremap <M-k> <c-w>k
nnoremap ˚ <c-w>k
nnoremap <M-l> <c-w>l
nnoremap ¬ <c-w>l
" }}}

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" .vimrc editing
nnoremap <leader>ev :vsplit ~/.dotfiles/.vimrc<cr>
nnoremap <leader>sv :source ~/.dotfiles/.vimrc<cr>

" Vertical split
nnoremap <leader>vs :vsplit<cr>

" Quickfix window
nnoremap <leader>co :copen<cr>
nnoremap <leader>cl :cclose<cr>
nnoremap <leader>cn :cnext<cr>
nnoremap <leader>cp :cprevious<cr>

" Show error on trailing whitespace
nnoremap <silent> <leader>w :match Error /\v\s+$/<cr>

" Remove trailing whitespace
nnoremap <leader>rw :%s/\v\s+$//g<cr>

" Stop highlighting search
noremap <leader>sh :nohlsearch<cr>

nnoremap H 0
vnoremap H 0
nnoremap L $
vnoremap L $

" wrap quotes around visual selecion
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>

" Terminal mappings
tnoremap <Esc> <C-\><C-n>
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
" 'Verbatim' escape
tnoremap <C-v><Esc> <Esc>

" Fzf mappings
if isdirectory(".git")
    " if in a git project, use :GFiles
    nnoremap <silent> <leader>O :GitFiles --cached --others --exclude-standard<cr>
else
    "otherwise, use :FZF
    nnoremap <silent> <leader>O :FZF<cr>
endif

" Vsplit netrw and move swap positions (so it's on left)
nnoremap <leader>l :Lexplore<cr>
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 20
let g:netrw_special_syntax = 1

function! ProjectDrawer()
   if argc() == 1 && isdirectory(argv(0))
       echom 'running with directory'
       Lexplore | wincmd p | enew | wincmd p
   else 
       Lexplore | wincmd p
   endif
endfunction
   
augroup ProgjectDrawer
   autocmd!
   autocmd VimEnter * call ProjectDrawer()
augroup End

" find in source from selection {{{
nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[y`]
    else
        return
    endif

    silent execute "Ack! " . shellescape(@@, 1)
    copen

    let @@ = saved_unnamed_register
endfunction
" }}}

" Unmap Arrows {{{
" disable arrow keys in input mode to force you to learn normal
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <down> <nop>
inoremap <up> <nop>

" disable arrow keys in normal mode to force you to stop using it
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <down> <nop>
nnoremap <up> <nop>
" }}}

" coc recommended {{{

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

augroup coc_highlight
    autocmd!
    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" }}}

" Yank/delete to selection register on Windows Ubuntu (WSL) {{{
" Note that this may make things really slow in large files.
" Disable with ':set eventignore=TextYankPost' and enable with ':set eventignore&'.
let s:clip = '/mnt/c/Windows/System32/clip.exe'

function! s:IsWSL()
    if has("unix") && executable(s:clip)
        let lines = readfile("/proc/version")
        if lines[0] =~ "Microsoft"
            return 1
        endif
    endif
    return 0
endfunction

function! s:ClipIfSelectionReg(event)
    if index(['*', '+'], a:event.regname) < 0
        return
    endif

    call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
endfunction

if <SID>IsWSL()
    if executable(s:clip)
        augroup WSLYank
            autocmd!
            autocmd TextYankPost * call <SID>ClipIfSelectionReg(v:event)
        augroup END
    end
endif
" }}}
