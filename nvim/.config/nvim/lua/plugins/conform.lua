local function root_file(files)
    -- copied form source code in conform, for some reason the import ws not resolving
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
            python = { 'ruff_lint_fix', 'ruff_format' },
        },
        formatters = {
            ruff_lint_fix = {
                command = 'ruff',
                args = {
                    'check',
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
            ruff_format = {
                command = 'ruff',
                args = {
                    'format',
                    '--stdin-filename',
                    '$FILENAME',
                    "-"
                },
                stdin = true,
                cwd = root_file({ 'pyproject.toml', 'ruff.toml', '.ruff.toml', }),
                require_cwd = true

            },
        },
    },
}
