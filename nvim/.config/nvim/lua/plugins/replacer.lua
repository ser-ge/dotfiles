return {
    'gabrielpoca/replacer.nvim',
    opts = { rename_files = true },
    keys = {
        {
            '<leader>q',
            function() require('replacer').run() end,
            desc = "run replacer.nvim"
        }
    }
}
