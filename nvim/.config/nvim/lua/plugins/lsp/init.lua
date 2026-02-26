local function set_lsp_map(bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vs", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)

    vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, opts)

    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    -- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end
return {
    -- lspconfig
    {
        "neovim/nvim-lspconfig",
        event        = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "lukas-reineke/lsp-format.nvim",
            { 'VonHeikemen/lsp-zero.nvim',  branch = 'v3.x', },
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/nvim-cmp',
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            { 'saadparwaiz1/cmp_luasnip' },
            { "jay-babu/mason-null-ls.nvim" },


            'L3MON4D3/LuaSnip',
            "ray-x/lsp_signature.nvim",
        },
        config       =
            function()
                local lsp = require("lsp-zero")
                local luasnip = require 'luasnip'


                lsp.preset("recommended")

                -- lsp.ensure_installed({
                --     'tsserver',
                --     'rust_analyzer',

                -- })


                require('mason').setup({})
                require('mason-lspconfig').setup({
                    -- Replace the language servers listed here
                    -- with the ones you want to install
                    ensure_installed = { 'tsserver', 'ruff', 'pyright' },
                    handlers = {
                        function(server_name)
                            if server_name ~= "rust_analyzer" then
                                require('lspconfig')[server_name].setup({})
                            end
                        end,


                        pyright = function()
                            require('lspconfig').pyright.setup({
                                settings = {
                                    pyright = {
                                        -- Using Ruff's import organizer
                                        disableOrganizeImports = true,
                                    },
                                    python = {
                                        pythonPath = vim.fn.exepath("python"),
                                        analysis = {
                                            -- Ignore all files for analysis to exclusively use Ruff for linting
                                            -- ignore = { '*' },
                                            -- analysis = {
                                            autoSearchPaths = true,
                                            diagnosticMode = "openFilesOnly",
                                            -- useLibraryCodeForTypes = true,
                                            -- typeCheckingMode = "basic",
                                        },
                                    }
                                },
                            })
                        end,

                        ruff = function()
                            require('lspconfig').ruff.setup({
                                settings = {
                                    ruff = {
                                        configurationPreference = "filesystemFirst"
                                    },
                                },
                            })
                        end,
                        basedpyright = function()
                            require('lspconfig').pyright.setup({
                                settings = {
                                    python = {
                                        pythonPath = vim.fn.exepath("python3"),
                                    },
                                },
                            })
                        end,

                    }
                })



                local cmp = require('cmp')
                -- local cmp_select = {behavior = cmp.SelectBehavior.Select}


                vim.api.nvim_set_keymap('i', '<S-Tab>', 'copilot#Accept("\\<CR>")',
                    { silent = true, script = true, expr = true })




                -- require("lsp-format").setup {}


                lsp.set_preferences({
                    suggest_lsp_servers = true,
                    sign_icons = {
                        error = 'E',
                        warn = 'W',
                        hint = 'H',
                        info = 'I'
                    }
                })

                lsp.on_attach(function(client, bufnr)
                    local opts = { buffer = bufnr, remap = false }
                    if vim.api.nvim_buf_get_name(bufnr):match "^%a+://" then
                        return
                    end

                    if client.name == 'ruff' then
                        -- Disable hover in favor of Pyright
                        client.server_capabilities.hoverProvider = false
                    end

                    -- require("lsp-format").on_attach(client, bufnr)
                    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
                    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set("n", "<leader>vs", function() vim.lsp.buf.signature_help() end, opts)
                    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)

                    vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, opts)

                    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                    -- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                end)


                lsp.setup()

                vim.diagnostic.config({
                    virtual_text = true
                })

                cmp.setup({
                    sources = {
                        { name = 'nvim_lsp', priority = 8 },
                        { name = "buffer",   priority = 7 }, -- first for locality sorting?
                        { name = 'luasnip',  priority = 6 },
                        {
                            name = 'spell',
                            option = {
                                keep_all_entries = false,
                                enable_in_context = function()
                                    return true
                                end,
                                preselect_correct_word = true,
                            },
                        }
                    },

                    sorting = {
                        comparators = {
                            -- compare.score_offset, -- not good at all
                            cmp.config.compare.locality,
                            cmp.config.compare.recently_used,
                            cmp.config.compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
                            cmp.config.compare.offset,
                            cmp.config.compare.order,
                            -- compare.scopes, -- what?
                            -- compare.sort_text,
                            -- compare.exact,
                            -- compare.kind,
                            -- compare.length, -- useless
                        }
                    },
                    behavior = cmp.ConfirmBehavior.Replace,
                    mapping = {
                        ['<CR>'] = cmp.mapping.confirm({ select = false }),
                        ['<C-n>'] = cmp.mapping.select_next_item(),
                        ['<C-p>'] = cmp.mapping.select_prev_item(),
                        ['<C-e>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-f>'] = cmp.mapping.scroll_docs(4),
                        ['<C-Space>'] = cmp.mapping.complete {},

                        ['<Tab>'] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            elseif luasnip.expand_or_locally_jumpable() then
                                luasnip.expand_or_jump()
                            else
                                fallback()
                            end
                        end, { 'i', 's' }),
                    },

                    window = {
                        completion = cmp.config.window.bordered(),
                        documentation = cmp.config.window.bordered(),
                        hover = cmp.config.window.bordered(),

                    },
                    snippet = {
                        expand = function(args)
                            require('luasnip').lsp_expand(args.body)
                        end
                    }
                })

                vim.cmd(':set winhighlight=' .. cmp.config.window.bordered().winhighlight)
            end,
    },

    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        lazy = false,   -- This plugin is already lazy

    }


}
