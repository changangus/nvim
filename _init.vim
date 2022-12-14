set scrolloff=8
set number
set relativenumber
set tabstop=2 softtabstop=2
set shiftwidth=2
set cmdheight=1
set expandtab
set smartindent
set splitbelow
set noequalalways
filetype on
filetype indent on
filetype plugin on
syntax on
set mouse=a

" enable folding
let g:markdown_folding = 1

let g:airline_theme='angr'

call plug#begin('~/.vim/plugged')
" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" colorscheme
Plug 'tomasiser/vim-code-dark'
" nerdtree
Plug 'preservim/nerdtree'
" git stuff
Plug 'airblade/vim-gitgutter'
" autosave
Plug 'Pocco81/auto-save.nvim'
" syntax higlighting
" javascript
Plug 'pangloss/vim-javascript'
" syntax highlight for .tsx
Plug 'ianks/vim-tsx', { 'for': 'typescript.tsx' }
" syntax highlight for .ts
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
" syntax hightlight for .jsx
Plug 'mxw/vim-jsx'
" syntax highlight for .sol
Plug 'tomlion/vim-solidity'
" syntax highlight for .md
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
" Intellisense for vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" startup screen
Plug 'mhinz/vim-startify'
" Autoclose pairs
Plug 'jiangmiao/auto-pairs'
" Emmet HTML
Plug 'mattn/emmet-vim'
" Code Snippets
" React
Plug 'SirVer/ultisnips'
Plug 'mlaursen/vim-react-snippets'
" Notes
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
" ESLint
Plug 'eslint/eslint'
" Github CoPilot
Plug 'github/copilot.vim'
" Icons
Plug 'ryanoasis/vim-devicons'
" Harpoon 
Plug 'nvim-lua/plenary.nvim' " don't forget to add this one if you don't have it yet!
Plug 'ThePrimeagen/harpoon'
" Airline
Plug 'airblade/vim-rooter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Git Blame
Plug 'zivyangll/git-blame.vim'
" prisma sytnax higlighting 
Plug 'pantharshit00/vim-prisma'
" vimspector debugging 
Plug 'puremourning/vimspector'
call plug#end()

let NERDTreeStatusline="%{matchstr(getline('.'), '\\s\\zs\\w\\(.*\\)')}"

set termguicolors     " enable true colors support
let ayucolor="dark"   " for dark version of theme
colorscheme codedark

hi Normal guibg=NONE ctermbg=NONE
hi StatusLine guibg=NONE ctermbg=NONE
hi StatusLineNC guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE 
hi LineNr guibg=NONE ctermbg=NONE
hi CursorLineNr guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE 
hi WinSeparator guibg=NONE ctermbg=NONE 
hi Directory guibg=NONE ctermbg=NONE 

let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.9, 'height': 0.9,'yoffset':0.5,'xoffset': 1, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_COMMAND="rg --files --hidden --follow --no-ignore-vcs"

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline', '-e']}), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

"Get Files
command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <nowait> <leader>e :q<CR>
" remove highlights from search 
nnoremap <leader>nh :noh<CR>
" nerdtree remaps
nnoremap <leader>ft :NERDTreeToggle<CR>
" fzr remaps
nnoremap <s-f> :GFiles<CR>
nnoremap <leader>rg :Rg<CR>
" unmap <esc> binding for fzf buffer if binding exists or suppress unmap error
au filetype fzf silent! tunmap <esc>
" quickfixlist remaps
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprev<CR>
" gitgutter remaps
nnoremap <leader>gd :GitGutterDiffOrig<CR>
" Emmet remap 
let g:user_emmet_leader_key=','
" window controls remaps
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
" Notes remaps 
nnoremap <leader>nn :Note<CR>
" Copy relative path to clipboard
nnoremap <leader>rp :let @+ = expand('%:')<CR>
" Coc Commands
nnoremap <leader>fl :CocCommand eslint.executeAutofix<CR>
nnoremap <leader>gb :CocCommand git.showBlameDoc<CR>
" copy to clipboard remap
xnoremap <leader>y "*y<CR>
" Harpoon remaps
nnoremap <leader>lv :lua require'harpoon.ui'.toggle_quick_menu()<CR>
nnoremap <leader>la :lua require'harpoon.mark'.add_file()<CR>
" gitblame 
nnoremap <leader>s :<C-u>call gitblame#echo()<CR>
" show docs for variables
nnoremap <silent> K :call <SID>show_documentation()<CR>
" puremourning/vimspector
let g:vimspector_sidebar_width = 60
let g:vimspector_code_minwidth = 90
let g:vimspector_terminal_maxwidth = 75
let g:vimspector_terminal_minwidth = 20
nnoremap <leader>da :call vimspector#Launch()<CR>
nnoremap <leader>dx :call vimspector#Reset()<CR>
nnoremap <F12> :call vimspector#StepOut()<CR>
nnoremap <F11> :call vimspector#StepInto()<CR>
nnoremap <F10> :call vimspector#StepOver()<CR>
nnoremap <leader>dre :call vimspector#Restart()<CR>
nnoremap <leader>dn :call vimspector#Continue()<CR>
nnoremap <leader>drc :call vimspectorRunToCursor()<CR>
nnoremap <leader>dh :call vimspector#ToggleBreakpoint()<CR>
nnoremap <leader>de :call vimspector#ToggleConditionalBreakpoint()<CR>
nnoremap <leader>dX :call vimspector#ClearBreakpoints()<CR>
source $HOME/.config/nvim/plug-config/coc.vim
