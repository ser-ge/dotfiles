require("replacer").setup()

vim.api.nvim_set_keymap('n', '<leader>R', ':lua require("replacer").run()<cr>', { silent = true })
