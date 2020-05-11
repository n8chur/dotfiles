" Plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'tomasiser/vim-code-dark'

call plug#end()

let g:coc_global_extensions = [
            \ 'coc-json', 'coc-tsserver', 'coc-html', 'coc-css', 'coc-yaml', 'coc-java', 'coc-eslint', 'coc-emoji',
            \ 'coc-svg', 'coc-sh', 'coc-vimlsp', 'coc-git', 'coc-xml', 'coc-yank', 'coc-highlight', 'coc-snippets',
            \ 'coc-sourcekit'
            \ ]

augroup plug_install_if_necessary
    autocmd!
    autocmd VimEnter *
                \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                \|   PlugInstall --sync | q
                \| endif
augroup END
" }}}

syntax on
set termguicolors
set background=dark
set t_Co=256
set t_ut=
colorscheme codedark

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
nnoremap <leader>w :match Error /\v\s+ $/<cr>

" Remove trailing whitespace
nnoremap <leader>rw :%s/\v\s+ $//g<cr>

" Stop highlighting search
noremap <leader>sh :nohlsearch<cr>

nnoremap H 0
vnoremap H 0
nnoremap L $
vnoremap L $

" wrap quotes around visual selecion
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>

" grep from selection {{{
nnoremap <leader>g :set operatorfunc=GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call GrepOperator(visualmode())<cr>

function! GrepOperator(type)
    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    silent execute "grep! -R " . shellescape(@@) . " ."
    copen
endfunctio
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

" statusline (from Marc) {{{
"
" %< means truncate on the left if too long
" %F is full path to the file we are editing
set statusline=%<%F
" %m shows [+] if the file is modified but not saved
set statusline+=%m
" %r shows [RO] if a file is read-only
set statusline+=%r
" %h shows [Help] if we are in a help buffer
set statusline+=%h
" %w shows [Preview] if we are in a preview window
set statusline+=%w
" separation point between the left and right items
set statusline+=%=
" prints the fileformat; that is, the kind of newline (one of unix, dos or
" mac)
" (If you type `:set fileformat?`, vim will tell you the current file
" format)
set statusline+=%{&fileformat}
" a literal forward slash
set statusline+=/
" %Y shows the filetype, such as VIM or HTML or GO
set statusline+=%Y
" %l shows the line number, and %8l uses 8 left-padded spaces to do so
set statusline+=%8l
" a literal comma
set statusline+=,
" %v shows the virtual column number;
" instead of counting a tab as one char, it counts it as the number
" of spaces it uses in the display
" %-8v leaves 8 spaces to the right to do so
set statusline+=%-8v
" syntastic
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"
" }}}

let g:netrw_liststyle=3

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
