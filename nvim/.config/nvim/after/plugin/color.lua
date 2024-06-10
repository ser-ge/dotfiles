-- vim.cmd("colorscheme gruvbox")
--
-- require("gruvbox").setup({
--   undercurl = true,
--   underline = true,
--   bold = true,
--   italic = {
--     strings = true,
--     comments = true,
--     operators = false,
--     folds = true,
--   },
--   strikethrough = true,
--   invert_selection = false,
--   invert_signs = false,
--   invert_tabline = false,
--   invert_intend_guides = false,
--   inverse = true, -- invert background for search, diffs, statuslines and errors
--   contrast = "soft", -- can be "hard", "soft" or empty string
--   palette_overrides = {},
--   overrides = {},
--   dim_inactive = false,
--   transparent_mode = false,
-- })
-- vim.cmd("colorscheme gruvbox")
--

require('bamboo').setup {
    -- Main options --
    style = 'vulgaris',                              -- Choose between 'vulgaris' (regular) and 'multiplex' (greener)
    toggle_style_key = nil,                          -- Keybind to toggle theme style. Leave it nil to disable it, or set it to a string, e.g. "<leader>ts"
    toggle_style_list = { 'vulgaris', 'multiplex' }, -- List of styles to toggle between (this option is essentially pointless now but will become useful if more style variations are added)
    transparent = false,                             -- Show/hide background
    term_colors = true,                              -- Change terminal color as per the selected theme style
    ending_tildes = false,                           -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false,                    -- reverse item kind highlights in cmp menu
    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        conditionals = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },

    -- Lualine options --
    lualine = {
        transparent = false, -- lualine center bar transparency
    },

    -- Custom Highlights --
    colors = {},     -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = false,    -- darker colors for diagnostic
        undercurl = true,  -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
    },
}
require('bamboo').load()


-- Example config in Lua
-- vim.g.gruvbox_baby_function_style = "NONE"
-- vim.g.gruvbox_baby_keyword_style = "italic"

-- -- Each highlight group must follow the structure:
-- -- ColorGroup = {fg = "foreground color", bg = "background_color", style = "some_style(:h attr-list)"}
-- -- See also :h highlight-guifg
-- -- Example:
-- vim.g.gruvbox_baby_highlights = {Normal = {fg = "#123123", bg = "NONE", style="underline"}}

-- -- Enable telescope theme
-- vim.g.gruvbox_baby_telescope_theme = 1

-- -- Enable transparent mode
-- vim.g.gruvbox_baby_transparent_mode = 0

-- -- Load the colorscheme
-- vim.cmd("colorscheme gruvbox-baby")


-- " Set contrast.
-- " This configuration option should be placed before `colorscheme gruvbox-material`.
-- " Available values: 'hard', 'medium'(default), 'soft'

vim.g.gruvbox_material_background = 'medium'

vim.g.gruvbox_material_better_performance = 1

-- The foreground color palette used in this color scheme.

-- - `material`: Carefully designed to have a soft contrast.
-- - `mix`: Color palette obtained by calculating the mean of the other two.
-- - `original`: The color palette used in the original gruvbox.

-- vim.g.gruvbox_material_foreground = "material"

vim.g.gruvbox_material_menu_selection_background = "orange"
vim.g.gruvbox_material_diagnostic_line_highlight = '1'
vim.g.gruvbox_material_diagnostic_virtual_text = "colored"



vim.g.gruvbox_material_transparent_background = 0
vim.g.gruvbox_material_dim_inactive_windows   = 0
vim.g.gruvbox_material_visual                 = "grey background"




vim.cmd("colorscheme gruvbox-material")


-- require'lualine'.setup {
--   options = {
--     theme = 'gruvbox-material'
--   }
-- }
