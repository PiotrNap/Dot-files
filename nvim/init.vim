filetype plugin indent on
syntax on

set guicursor=  
set guifont=Hack
set hlsearch hidden noerrorbells expandtab smartindent nowrap
set ignorecase smarttab smartcase noswapfile nobackup undofile incsearch noshowmode
set tabstop=4 softtabstop=4 shiftwidth=4 scrolloff=8 scl=yes guicursor=
set undodir=~/.vim/undodir
set cot=menuone,noinsert,noselect
set encoding=utf-8

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=80

call plug#begin('~/.vim/plugged')

" Neovim lsp Plugins
Plug 'neovim/nvim-lspconfig'
"" Needed for auto-completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'szw/vim-maximizer'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'tweekmonster/startuptime.vim'
Plug 'romainl/vim-cool'
Plug 'prettier/vim-prettier'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'

" telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'BurntSushi/ripgrep'
Plug 'nvim-lua/plenary.nvim'

" color scheme
Plug 'Lokaltog/vim-monotone'

call plug#end()

lua require('myLuaSetup')

color monotone
" make background transparent
highlight Normal ctermbg=NONE guibg=NONE

" yank text into system (and host?) clipboard
fun! Yank(text) 
    let escape = system("term_copy",a:text)
    if v:shell_error
        echoerr escape
    else
        call writefile([escape], '/dev/tty', 'b')
    endif
endfun

if executable('rg')
    let g:rg_derive_root='true'
endif

if exists('g:started_by_firenvim') && g:started_by_firenvim
    " general options
    set laststatus=0 nonumber noruler noshowcmd

    augroup firenvim
        autocmd!
        autocmd BufEnter *.txt setlocal filetype=markdown.pandoc
    augroup END
endif

" use this bin file on prettier format
let g:prettier#exec_cmd_path = '~/.vim/bundle/vim-prettier/node_modules/.bin/prettier'
let g:prettier#autoformat = 0
let g:prettier#config#tab_width = 2
let g:prettier#config#semi = 'false'

let laoded_matchparen = 1
let mapleader = " "

" Initialize netrw with hidden dot files
" let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" Start with the type of nodes listing
let g:netrw_liststyle = 0
let g:netrw_browse_split = 0
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_localrmdir='mv ~/.local/share/Trash'

let g:UltiSnipsExpandTrigger='<C-S>'
let g:UltiSnipsJumpForwardTrigger='<C-K>'
let g:UltiSnipsJumpBackwardTrigger='<C-J>'
let g:UltiSnipsEdit='vertical'
let g:UltiSnipsSnippetDirectories=['UltiSnips','snips']

" For scrolling in autocompletion popup
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vf :lua vim.lsp.buf.formatting()<CR>

" diagnostic lsp commands
nnoremap <leader>el :lua vim.diagnostic.open_float()<CR>
nnoremap <leader>ep :lua vim.diagnostic.goto_prev()<CR>
nnoremap <leader>en :lua vim.diagnostic.goto_next()<CR>

nnoremap <leader>cP :lua require("contextprint").add_statement()<CR>
nnoremap <leader>cp :lua require("contextprint").add_statement(true)<CR>

fun! GotoWindow(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun

nnoremap <leader>m :MaximizerToggle!<CR>

nnoremap <leader>y y:call Yank(@0)

"vim-fugitive shortcuts
nnoremap <leader>gs :G<CR>
nnoremap <leader>gh :diffget //3<CR>
nnoremap <leader>gf :diffget //2<CR>

nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gl :Gclog<CR>
nnoremap <leader>gcn :Git commit --no-verify<CR>
nnoremap <leader>gb :Git branches<CR>
nnoremap <leader>ga :Git fetch --all<CR>
nnoremap <leader>grum :Git rebase upstream/master<CR>
nnoremap <leader>grom :Git rebase origin/master<CR>
nnoremap <leader>gfrum :Git fetch --all<CR> :Git rebase upstream --interactive master<CR>
nnoremap <leader>gfrom :Git fetch --all<CR> :Git rebase origin --interactive master<CR>
nnoremap <leader>grs :Git reset --soft HEAD~1<CR>
nnoremap <leader>grh :Git reset --hard HEAD~1<CR>
nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>

" telescope-nvim
nnoremap <Leader>ff :lua require('telescope.builtin').find_files()<CR>
nnoremap <Leader>fb :lua require('telescope.builtin').buffers()<CR>
nnoremap <Leader>fl :lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>fh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>fgc :lua require('telescope.builtin').git_commits()<CR>
nnoremap <leader>fgb :lua require('telescope.builtin').git_branches()<CR>
nnoremap <leader>fgs :lua require('telescope.builtin').git_status()<CR>

" telescope-project
" nnoremap <leader>fp :lua require('telescope').extensions.project.project{}<CR>

nnoremap <leader>bs /<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :Sex!<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
nnoremap <Leader>cpu a%" PRIu64 "<esc>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" nnoremap <Leader>s :up<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>cpf :let @" = expand("%")<CR>

" greatest remap ever
vnoremap <leader>p "_dP
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>V v$
" go to next occurence and center the cursor
nnoremap n nzzzv
nnoremap N Nzzzv
" join the line but remain position of the cursor
nnoremap J mzJ`z
" add breakpoints for undo command
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap [ [<c-g>u
" populate the jump line with 5 or more lines
nnoremap <expr>k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr>j (v:count > 5 ? "m'" . v:count : "") . 'j'


" rename current open file 
nnoremap <leader>rn :!mv % %:h/

" vim TODO
nmap <Leader>tu <Plug>BujoChecknormal
nmap <Leader>th <Plug>BujoAddnormal
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

nnoremap <Leader>wf ofunction wait(ms: number): Promise<void> {<CR>return new Promise(res => setTimeout(res, ms));<CR>}<esc>k=i{<CR>

"A react native component boilerplate with StyleSheet object - wow
nnoremap <leader>rnc iimport * as React from 'react';<CR>import {View, Text, StyleSheet} from 'react-native';<CR><CR>export interface Props {}<CR><CR>export const foo = ({}: Props) => {<CR><Tab>return (<CR><View style={styles.container}><CR><Tab><Text>Hello World</Text><CR><BS></View><CR>)<CR><BS><BS>}<CR><CR>const styles = StyleSheet.create({<CR>container: { flex: 1}<CR>});<esc>/foo<CR>

" after so many key strokes....
nnoremap <leader>cl iconsole.log('here')<ESC>i
nnoremap <leader>ce iconsole.error('error')<ESC>i

" Vim with me
nnoremap <leader>vwm :call ColorMyPencils()<CR>
nnoremap <leader>tbg :call SetTransparentBg()<CR>

inoremap <silent> <esc> <C-O>:stopinsert<CR>
inoremap <C-c> <esc>e
nnoremap <leader>s :w<CR>
nnoremap gb :buffers<CR>:buffer<Space>

"for escaping from the terminal
tnoremap <leader>q <C-\><C-n>

"for entering the terminal
nnoremap <leader>tr :terminal<CR> i

"type TAB to go the next matching pair item
nnoremap <Tab> %

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_matching_smart_case = 1
let g:completion_trigger_on_delete = 1
let g:diagnostic_enable_virtual_text = 1

fun! EmptyRegisters()
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
        call setreg(r, [])
    endfor
endfun

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

command! Format execute 'lua vim.lsp.buf.formatting()'

function! SetAllGroupsSetting()
    let groups = [
    \   'Normal', 'Comment', 'Constant', 'String', 'Character', 'Number', 'Boolean',
    \   'Float', 'Identifier', 'Function', 'Statement', 'Conditional', 'Repeat',
    \   'Label', 'Operator', 'Keyword', 'Exception', 'Type', 'StorageClass', 'Structure',
    \   'PreProc', 'Define', 'Include', 'Special', 'SpecialChar', 'Tag', 'Delimiter',
    \   'SpecialComment', 'Debug', 'Error', 'Todo'
    \ ]
    for group in groups
        execute 'highlight' group 'cterm=NONE gui=NONE'
    endfor
endfunction


augroup start_up
    autocmd!
    autocmd ColorScheme * call SetAllGroupsSetting()
    autocmd BufEnter * call SetAllGroupsSetting()
    autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
    autocmd BufWritePre *.hs :Format
    autocmd TextYankPost = silent! lua require'vim.highlight'.on_yank({timeout = 40)}
    " autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
    " autocmd BufEnter *.hs :Ghcid
    " autocmd BufLeave *.hs :GhcidKill
augroup END

augroup no_numbers
    autocmd!
    autocmd BufEnter, FocusGained, InsertLeave * set nu!
    autocmd BufLeave, FocusLost, InsertEnter * set nu!
    autocmd QuickFixCmdPost make nested copen
augroup END
