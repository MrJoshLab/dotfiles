local remap = vim.api.nvim_set_keymap

-- Good maps
remap('v', '<', '<gv', {noremap = true})
remap('v', '>', '>gv', {noremap = true})
remap('n', '<C-l>', ':nohl<CR><C-l>', {noremap = true, silent = true})
remap('n', '<leader>pv', ':wincmd v<bar> :Ex <bar> :vertical resize 30<CR>', {noremap = true})
remap('n', '<leader>w', ':bd<CR>', {noremap = true})
remap('n', '<leader><space>', ':NERDTreeToggle<CR>', {noremap = true})

-- Best practice rempas
remap('', '<Up>', '<Nop>', {noremap = true})
remap('', '<Down>', '<Nop>', {noremap = true})
remap('', '<Right>', '<Nop>', {noremap = true})
remap('', '<Left>', '<Nop>', {noremap = true})

-- Good maps from ThePrimeagen
remap('v', 'J', ":m '>+1<CR>gv=gv", {noremap = true})
remap('v', 'K', ":m '>-2<CR>gv=gv", {noremap = true})

require('mrjosh.boundary').setup({
  boundary_addr = "http://localhost:9200",
  boundary_telescope_script_path = "/Users/josh/.bin/boundary_telescope_cmd.sh",
})

-- Telescope
remap('n', '<C-p>', ":lua require('mrjosh.telescope').search_files()<CR>", {noremap = true})
remap('n', '<leader>vrc', ":lua require('mrjosh.telescope').search_dotfiles()<CR>", {noremap = true})
remap('n', '<leader>ghg', ":lua require('mrjosh.gists').gists()<CR>", {noremap = true})
remap('n', '<leader>gc', ":lua require('telescope.builtin').git_commits()<CR>", {noremap = true})
remap('n', '<leader>pb', ":lua require('telescope.builtin').buffers()<CR>", {noremap = true})
remap('n', '<leader>ps', ":lua require('mrjosh.telescope').live_grep()<CR>", {noremap = true})
remap('n', '<leader>b', ":lua require('mrjosh.boundary').targets()<CR>", {noremap = true})

-- LSP
local opts = { noremap=true, silent=true }
remap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
remap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
remap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

--" Use K to show documentation in preview window.
--nnoremap <silent> K :call <SID>show_documentation()<CR>
remap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
remap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
remap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
remap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Auto completion
--remap('i', '<CR>','compe#confirm("<CR>")', {expr = true})

--remap('i', '(','()<left>', {noremap = true})
--remap('i', "'", "''<left>", {noremap = true})
--remap('i', '"','""<left>', {noremap = true})
--remap('i', '[','[]<left>', {noremap = true})

