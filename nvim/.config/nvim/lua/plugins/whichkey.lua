return {
    "folke/which-key.nvim",

    opts = {
        preset = "classic",
        delay = 200,
        plugins = {
            marks = true,
            registers = true,
            spelling = {
                enabled = true,
                suggestions = 20,
            },
            presets = {
                operators = true,
                motions = true,
                text_objects = true,
                windows = true,
                nav = true,
                z = true,
                g = true,
            },
        },
        icons = {
            breadcrumb = "»",
            separator = "➜",
            group = "+",
        },
        win = {
            border = "none",
            padding = { 1, 2 },
            zindex = 1000,
        },
        layout = {
            width = { min = 20, max = 50 },
            spacing = 3,
            align = "left",
        },
        show_help = true,
        show_keys = true,
        spec = {
            { "<leader>a", group = "AI/Claude Code" },
        },
    }
}
