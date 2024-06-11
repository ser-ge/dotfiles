local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fa',
    "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>",
    {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>fm', builtin.marks, {})

-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
--
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)


function SearchGitHistory()
    local file = vim.fn.expand('%')
    if file == '' or file == nil then
        print('No file found')
        return
    end

    local command = "Telescope git_files cwd=" ..
        vim.fn.FugitiveGitDir() .. " prompt_prefix=🔍\\ History\\ for\\ " .. file:gsub(" ", "\\ ") .. ":\\ "
    vim.cmd(command)
end

-- vim.api.nvim_set_keymap('n', '<leader>gh', ':lua SearchGitHistory()<CR>', { noremap = true, silent = true })


vim.keymap.set('n', '<leader>gh', ':lua SearchGitHistory()<CR>', { noremap = true, silent = true })


-- builtin.load_extension("git_worktree")
require("telescope").load_extension("git_worktree")
vim.keymap.set("n", "<leader>gl", function() require("telescope").extensions.git_worktree.git_worktrees() end)
vim.keymap.set("n", "<leader>gn", function() require("telescope").extensions.git_worktree.create_git_worktree() end)
