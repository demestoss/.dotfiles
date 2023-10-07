lua require('config')

au TextYankPost * silent! lua vim.highlight.on_yank()

set scrolloff=16
set number 
set relativenumber 
set expandtab
set shiftwidth=4
set tabstop=4 softtabstop=4

colorscheme catppuccin-mocha
set termguicolors
set noshowmode

let mapleader = " "

nnoremap <leader>pv :Vex<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>
nnoremap <C-E> :copen<CR>

nnoremap <leader>/ :nohls<CR>

nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>x :!chmod +x %<CR>

nnoremap <silent> <C-f> :silent !tmux neww tt<CR>
