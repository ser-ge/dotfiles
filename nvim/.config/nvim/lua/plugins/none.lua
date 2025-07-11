return {
    "nvimtools/none-ls.nvim",

    config = function(_, opts)
        local null_ls = require("null-ls")
        local conf = {
            sources = {
                null_ls.builtins.diagnostics.mypy,
            }
        }
        null_ls.setup(conf)
    end




}
