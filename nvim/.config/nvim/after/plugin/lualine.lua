require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_c = { 'filename' },
        lualine_z = { 'location' }
    },
    -- inactive_sections = {
    --     lualine_a = {},
    --     lualine_b = {},
    --     lualine_c = { 'filename' },
    -- },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
-- -- Retrieve the current status line
-- local current_statusline = vim.opt.statusline:get()

-- -- Append a custom element to the status line
-- local new_statusline = current_statusline .. " %{FugitiveStatusline()}"

-- -- Prepend a custom element to the status line
-- new_statusline = "%{MyOtherCustomFunction()}" .. new_statusline
