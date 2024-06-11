vim.cmd("nmap <leader><leader> <Plug>SlimeSendCell")

vim.keymap.set("v","<leader><leader>",":SlimeSend<CR>")

vim.g.slime_target = "tmux"

vim.g.slime_dont_ask_default = 1
-- vim.g.slime_python_ipython = 1
vim.g.slime_bracketed_paste = 1
vim.g.slime_cell_delimiter = "# %%"
vim.g.ipython_cell_delimit_cells_by = 'tags'
vim.g.ipython_cell_tag = "# %%"


vim.cmd('let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": "{top-right}"}')

