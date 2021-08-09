filetype plugin indent on
syntax on

set guicursor=  
set hlsearch hidden noerrorbells expandtab smartindent nowrap
set ignorecase smarttab smartcase noswapfile nobackup undofile incsearch noshowmode
set tabstop=4 softtabstop=4 shiftwidth=4 scrolloff=8 scl=yes guicursor=
set undodir=~/.vim/undodir
set cot=menuone,noinsert,noselect
set encoding=utf-8
set background=dark

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
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

" Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Neovim Tree Sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'szw/vim-maximizer'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'lifepillar/vim-gruvbox8'
Plug 'tweekmonster/startuptime.vim'
Plug 'romainl/vim-cool'
Plug 'prettier/vim-prettier'
Plug 'hoob3rt/lualine.nvim'
Plug 'tpope/vim-commentary'
" Plug 'ThePrimeagen/git-worktree.nvim'
" Plug 'rstacruz/vim-closer'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

call plug#end()

lua require('myLuaSetup')
lua require('lualine').setup()

" lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }
lua require('telescope').setup({defaults = {file_sorter = require('telescope.sorters').get_fzy_sorter}})


let g:gruvbox_italicize_strings = 1
let g:gruvbox_plugin_hi_groups = 1

fun! ColorMyPencils()
   color gruvbox8_hard
   if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
    let g:gruvbox_invert_selection='0'

  highlight ColorColumn ctermbg=0 guibg=grey
  highlight Normal guibg=none
  highlight LineNr guifg=#5eacd3
  highlight netrwDir guifg=#5eacd3
  highlight qfFileName guifg=#aed75f
endfun
call ColorMyPencils()

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

" use this bin file on prettier format
let g:prettier#exec_cmd_path = '~/.vim/bundle/vim-prettier/node_modules/.bin/prettier'
let g:prettier#autoformat = 0
let g:prettier#config#tab_width = 2

let laoded_matchparen = 1
let mapleader = " "

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_localrmdir='rm -r'

let g:lualine= {
    \ 'options' : {
    \ 'theme' :  'gruvbox',
    \ }
    \}


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
nnoremap <leader>vsd :lua vim.lsp.show_line_diagnostics(); vim.lsp.show_line_diagnostics()<CR>
nnoremap <leader>vf :lua vim.lsp.buf.formatting()<CR>

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
nnoremap <leader>gcn :Git commit --no-verify<CR>
nnoremap <leader>gb :Git branches<CR>
nnoremap <leader>ga :Git fetch --all<CR>
nnoremap <leader>grum :Git rebase upstream/master<CR>
nnoremap <leader>grom :Git rebase origin/master<CR>
nnoremap <leader>grs :Git reset --soft HEAD~1<CR>
nnoremap <leader>grh :Git reset --hard HEAD~1<CR>
nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>

" telescope-nvim
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>

nnoremap <leader>bs /<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :Sex!<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>f :lua vim.lsp.buf.formatting()<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
nnoremap <Leader>ee oif err != nil {<CR>log.Fatalf("%+v\n", err)<CR>}<CR><esc>kkI<esc>
nnoremap <Leader>cpu a%" PRIu64 "<esc>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <Leader>s :up<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>cpf :let @" = expand("%")<CR>

" greatest remap ever
vnoremap <leader>p "_dP
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>V v$
" go to next occurence and center the cursor
nnoremap n nzzzv
nnoremap N nzzzv
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

nnoremap <Leader>ww ofunction wait(ms: number): Promise<void> {<CR>return new Promise(res => setTimeout(res, ms));<CR>}<esc>k=i{<CR>

"A react native component boilerplate with StyleSheet object - wow
nnoremap <leader>rnc iimport * as React from 'react';<CR>import {View, Text, StyleSheet} from 'react-native';<CR><CR>export interface FooProps {}<CR><CR>export const foo = ({}: FooProps) => {<CR><Tab>return (<CR><View style={styles.container}><CR><Tab><Text>Hello World</Text><CR><BS></View><CR>)<CR><BS><BS>}<CR><CR>const styles = StyleSheet.create({<CR>container: { flex: 1}<CR>});<esc>

" Vim with me
nnoremap <leader>vwm :call ColorMyPencils()<CR>

inoremap <C-c> <esc>e

"for escaping from the terminal and going one buffer back
tnoremap <leader>q <C-\><C-n> <C-o>

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

augroup highlight_yank
    autocmd!
    autocmd TextYankPost = silent! lua require'vim.highlight'.on_yank({timeout = 40)}
augroup END

augroup completion_nvim
    autocmd!
    autocmd BufEnter * lua require'completion'.on_attach()
augroup END

augroup start_up
    autocmd!
    autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END

augroup no_numbers
    autocmd!
    autocmd BufEnter, FocusGained, InsertLeave * set nu!
    autocmd BufLeave, FocusLost, InsertEnter * set nu!
    autocmd QuickFixCmdPost make nested copen
augroup END
