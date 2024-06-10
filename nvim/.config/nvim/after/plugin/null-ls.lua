-- local b = null_ls.builtins

-- local sources = {

--     -- webdev stuff
--     b.formatting.deno_fmt,
--     b.formatting.prettier,

--     -- Lua
--     b.formatting.stylua,

--     -- Shell
--     b.formatting.shfmt,
--     b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

--     -- Python
--     b.diagnostics.mypy
-- }

-- null_ls.setup {
--     debug = true,
--     sources = sources,
-- }




local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.mypy.with({
            extra_args = function()
                local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
                return { "--python-executable", virtual .. "/bin/python" }
            end,
        })
    },
})

-- null_ls.setup({
--     sources = {
--         null_ls.builtins.diagnostics.mypy
--     },
-- })
