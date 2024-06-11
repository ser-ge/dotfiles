return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        version = false, -- telescope did only one release, so use HEAD for now
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            {
                "<leader>,",
                "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
                desc = "Switch Buffer",
            },
            { "<leader>:",  "<cmd>Telescope command_history<cr>",                                                                                  desc = "Command History" },
            -- find
            { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",                                                         desc = "Buffers" },
            { "<leader>ff", "<cmd>Telescope find_files<cr>",                                                                                       desc = "Find Files (Root Dir)" },
            { "<leader>fa", "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", desc = "Find Files with Hidden(Root Dir)" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>",                                                                                        desc = "Grep string (live-grep)" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                                                                                         desc = "Recent" },
            -- git
            { "<leader>gc", "<cmd>Telescope git_commits<CR>",                                                                                      desc = "Commits" },
            -- search
            { '<leader>s"', "<cmd>Telescope registers<cr>",                                                                                        desc = "Registers" },
            { "<leader>sa", "<cmd>Telescope autocommands<cr>",                                                                                     desc = "Auto Commands" },
            { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>",                                                                        desc = "Buffer" },
            { "<leader>sc", "<cmd>Telescope command_history<cr>",                                                                                  desc = "Command History" },
            { "<leader>sC", "<cmd>Telescope commands<cr>",                                                                                         desc = "Commands" },
            { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>",                                                                              desc = "Document Diagnostics" },
            { "<leader>sD", "<cmd>Telescope diagnostics<cr>",                                                                                      desc = "Workspace Diagnostics" },
            { "<leader>sh", "<cmd>Telescope help_tags<cr>",                                                                                        desc = "Help Pages" },
            { "<leader>sH", "<cmd>Telescope highlights<cr>",                                                                                       desc = "Search Highlight Groups" },
            { "<leader>sj", "<cmd>Telescope jumplist<cr>",                                                                                         desc = "Jumplist" },
            { "<leader>sk", "<cmd>Telescope keymaps<cr>",                                                                                          desc = "Key Maps" },
            { "<leader>sl", "<cmd>Telescope loclist<cr>",                                                                                          desc = "Location List" },
            { "<leader>sM", "<cmd>Telescope man_pages<cr>",                                                                                        desc = "Man Pages" },
            { "<leader>sm", "<cmd>Telescope marks<cr>",                                                                                            desc = "Jump to Mark" },
            { "<leader>so", "<cmd>Telescope vim_options<cr>",                                                                                      desc = "Options" },
            { "<leader>sR", "<cmd>Telescope resume<cr>",                                                                                           desc = "Resume" },
            { "<leader>sq", "<cmd>Telescope quickfix<cr>",                                                                                         desc = "Quickfix List" },

            opts = function()
                local actions = require("telescope.actions")

                local open_with_trouble = function(...)
                    return require("trouble.sources.telescope").open(...)
                end
                local find_files_no_ignore = function()
                    local action_state = require("telescope.actions.state")
                    local line = action_state.get_current_line()
                    LazyVim.pick("find_files", { no_ignore = true, default_text = line })()
                end
                local find_files_with_hidden = function()
                    local action_state = require("telescope.actions.state")
                    local line = action_state.get_current_line()
                    LazyVim.pick("find_files", { hidden = true, default_text = line })()
                end

                return {
                    defaults = {
                        prompt_prefix = " ",
                        selection_caret = " ",
                        -- open files in the first window that is an actual file.
                        -- use the current window if no other window is available.
                        get_selection_window = function()
                            local wins = vim.api.nvim_list_wins()
                            table.insert(wins, 1, vim.api.nvim_get_current_win())
                            for _, win in ipairs(wins) do
                                local buf = vim.api.nvim_win_get_buf(win)
                                if vim.bo[buf].buftype == "" then
                                    return win
                                end
                            end
                            return 0
                        end,
                        mappings = {
                            i = {
                                ["<c-t>"] = open_with_trouble,
                                ["<a-t>"] = open_with_trouble,
                                ["<a-i>"] = find_files_no_ignore,
                                ["<a-h>"] = find_files_with_hidden,
                                ["<C-Down>"] = actions.cycle_history_next,
                                ["<C-Up>"] = actions.cycle_history_prev,
                                ["<C-f>"] = actions.preview_scrolling_down,
                                ["<C-b>"] = actions.preview_scrolling_up,
                            },
                            n = {
                                ["q"] = actions.close,
                            },
                        },
                    },
                }
            end,
        },
    },

    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        opts = { use_diagnostic_signs = true },
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
            { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",      desc = "Symbols (Trouble)" },
            {
                "<leader>cS",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP references/definitions/... (Trouble)",
            },
            { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
            { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",  desc = "Quickfix List (Trouble)" },
            {
                "[q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").prev({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cprev)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Previous Trouble/Quickfix Item",
            },
            {
                "]q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").next({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cnext)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Next Trouble/Quickfix Item",
            },
        },
    },

    -- Finds and lists all of the TODO, HACK, BUG, etc comment
    -- in your project and loads them into a browsable list.
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        opts = {},
        -- stylua: ignore
        keys = {
            { "]t",         function() require("todo-comments").jump_next() end,              desc = "Next Todo Comment" },
            { "[t",         function() require("todo-comments").jump_prev() end,              desc = "Previous Todo Comment" },
            { "<leader>xt", "<cmd>Trouble todo toggle<cr>",                                   desc = "Todo (Trouble)" },
            { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
            { "<leader>st", "<cmd>TodoTelescope<cr>",                                         desc = "Todo" },
            { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",                 desc = "Todo/Fix/Fixme" },
        },
    },
}
