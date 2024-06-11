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
    ensure_installed = { 'tsserver', 'rust_analyzer' },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,

        pyright = function()
            require('lspconfig').pyright.setup({
                settings = {
                    python = {
                        pythonPath = vim.fn.exepath("python"),
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

-- Fix Undefined global 'vim'
lsp.nvim_workspace()


local cmp = require('cmp')
-- local cmp_select = {behavior = cmp.SelectBehavior.Select}


vim.api.nvim_set_keymap('i', '<S-Tab>', 'copilot#Accept("\\<CR>")', { silent = true, script = true, expr = true })




require("lsp-format").setup {}


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

    require("lsp-format").on_attach(client, bufnr)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vs", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)

    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)

    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    -- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.skip_server_setup({ 'rust_analyzer' })

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

cmp.setup({
    sources = {
        { name = 'nvim_lsp', priority = 8 },
        { name = "buffer",   priority = 7 }, -- first for locality sorting?
        { name = 'luasnip',  priority = 6 },
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


local cfg = {
    debug = false,                                              -- set to true to enable debug logging
    log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
    -- default is  ~/.cache/nvim/lsp_signature.log
    verbose = false,                                            -- show debug line number

    bind = true,                                                -- This is mandatory, otherwise border config won't get registered.
    -- If you want to hook lspsaga or other signature handler, pls set to false
    doc_lines = 0,                                              -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
    -- set to 0 if you DO NOT want any API comments be shown
    -- This setting only take effect in insert mode, it does not affect signature help in normal
    -- mode, 10 by default

    max_height = 12,                       -- max height of signature floating_window
    max_width = 80,                        -- max_width of signature floating_window, line will be wrapped if exceed max_width
    -- the value need >= 40
    wrap = true,                           -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
    floating_window = false,               -- show hint in a floating window, set to false for virtual text only mode

    floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
    -- will set to true when fully tested, set to false will use whichever side has more space
    -- this setting will be helpful if you do not want the PUM and floating win overlap

    -- floating_window_off_x = 1, -- adjust float windows x position.
    -- -- can be either a number or function
    -- floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
    -- -- can be either number or function, see examples

    floating_window_off_x = 5,                           -- adjust float windows x position.
    floating_window_off_y = function()                   -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
        local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
        local pumheight = vim.o.pumheight
        local winline = vim.fn.winline()                 -- line number in the window
        local winheight = vim.fn.winheight(0)

        -- window top
        if winline - 1 < pumheight then
            return pumheight
        end

        -- window bottom
        if winheight - winline < pumheight then
            return -pumheight
        end
        return 0
    end,
    close_timeout = 4000,                      -- close floating window after ms when laster parameter is entered
    fix_pos = false,                           -- set to true, the floating window will not auto-close until finish all parameters
    hint_enable = true,                        -- virtual hint enable
    hint_prefix = ":",                         -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
    hint_scheme = "String",
    hint_inline = function() return false end, -- should the hint be inline(nvim 0.10 only)?  default false
    -- return true | 'inline' to show hint inline, return 'eol' to show hint at end of line, return false to disable
    -- return 'right_align' to display hint right aligned in the current line
    hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
    handler_opts = {
        border = "none"                           -- double, rounded, single, shadow, none, or a table of borders

    },

    always_trigger = false,                   -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

    auto_close_after = nil,                   -- autoclose signature float win after x sec, disabled if nil.
    extra_trigger_chars = {},                 -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
    zindex = 200,                             -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

    padding = '',                             -- character to pad on left and right of signature can be ' ', or '|'  etc

    transparency = nil,                       -- disabled by default, allow floating win transparent value 1~100
    shadow_blend = 36,                        -- if you using shadow as border use this set the opacity
    shadow_guibg = 'Black',                   -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
    timer_interval = 200,                     -- default timer check interval set to lower value if you want to reduce latency
    toggle_key = nil,                         -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
    toggle_key_flip_floatwin_setting = false, -- true: toggle floating_windows: true|false setting after toggle key pressed
    -- false: floating_windows setup will not change, toggle_key will pop up signature helper, but signature
    -- may not popup when typing depends on floating_window setting

    select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
    move_cursor_key = nil,      -- imap, use nvim_set_current_win to move cursor between current win and floating
}

-- recommended:
require 'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key

-- You can also do this inside lsp on_attach
-- note: on_attach deprecated
-- require 'lsp_signature'.on_attach(cfg) -- no need to specify bufnr if you don't use toggle_key
