local function root_file(files)
    return function(self, ctx)
        if vim.fn.has("nvim-0.10") == 1 then
            return vim.fs.root(ctx.dirname, files)
        end
        local found = vim.fs.find(files, { upward = true, path = ctx.dirname })[1]
        if found then
            return vim.fs.dirname(found)
        end
    end
end

return {
    'stevearc/conform.nvim',
    opts = {
        format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 500,
            lsp_fallback = true,
        },
        formatters_by_ft = {
            python = { 'ruff_organize_imports' },
        },
        formatters = {
            ruff_organize_imports = {
                command = 'ruff',
                args = {
                    'check',
                    -- '--force-exclude',
                    -- '--select=I001',
                    '--fix',
                    '--exit-zero',
                    '--stdin-filename',
                    '$FILENAME',
                    '-',
                },
                stdin = true,
                cwd = root_file({ 'pyproject.toml', 'ruff.toml', '.ruff.toml', }),
                require_cwd = true

            },
        },
    },
}
