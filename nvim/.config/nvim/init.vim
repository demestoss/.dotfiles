lua require('config')

set scrolloff=16

set noshowmode
set smartindent
colorscheme catppuccin-mocha

nnoremap <leader>e :Neotree toggle reveal<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>
nnoremap <C-E> :copen<CR>

vnoremap <leader>p "_dP
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <leader>/ :nohls<CR>

nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>x :!chmod +x %<CR>

nnoremap <silent> <C-t> :silent !tmux neww tt<CR>
