return {
    "sainnhe/gruvbox-material",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, --
    config = function()
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
    end,

}
