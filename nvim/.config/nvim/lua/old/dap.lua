--require('dap-python').setup()
--require("dapui").setup()

--require("nvim-dap-virtual-text").setup()

--local dap, dapui = require("dap"), require("dapui")

--dap.listeners.after.event_initialized["dapui_config"] = function()
--  dapui.open()
--end
--dap.listeners.before.event_terminated["dapui_config"] = function()
--  dapui.close()
--end
--dap.listeners.before.event_exited["dapui_config"] = function()
--  dapui.close()
--end

--dap.adapters.python = {
--  type = 'executable';
--  command = 'python';
--  args = { '-m', 'debugpy.adapter' };
--}

--vim.fn.sign_define('DapBreakpoint', {text='B', texthl='', linehl='', numhl=''})

--require('dap-python').test_runner = 'pytest'

--dap.configurations.python = {
--  {
--    -- The first three options are required by nvim-dap
--    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
--    request = 'launch';
--    name = "Launch file";

--    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
--    program = "${file}"; -- This configuration will launch the current file if used.
--      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
--      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
--  },
--}

---- :autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>
---- --convert the above vim command to lua config
---- local autocmd = vim.api.nvim_create_autocmd
---- autocmd('FileType', {pattern = 'dap-float', command = 'nnoremap <buffer><silent> q <cmd>close!<CR>'})

--      -- { "<leader>dn", ": lua ", desc = "debug over" },
--      -- { "<leader>di", ": lua require'dap'.step_into()<cr>", desc = "debug into" },

---- vim.keymap.set('n',
---- "<leader>db'. function require"dap". toggle_breakpoint () end)
---- 21 vim. keymap.set ('n',
---- "<leader>dB"
---- ":lua require'dap' .set_breakpoint (vim.fn. input ('Breakpoint condition: ')) ‹CR>")
---- 20 vim.keymap.set ('n',
---- "<S-k>', function) require"dap".step_out () end)
---- 19 vim. keymap.set('n'.
---- function() require"dap".step_into() end)
---- 18 vim. keymap.set ('n'
---- " <S-i>!
---- function () require"dap" .step_over () end)
---- 17 vim.keymap.set ('n'
---- "(S-h»', function () require"dap".continue () end)
---- 15 vim.keymap.set ('n'
---- '«leader>dt', function() require"dap".terminate() end)
---- 14 vim.keymap.set('n'
---- '‹leader>dB', function) require"dap".clear breakpoints) end)
---- 13 vim.kevmap.set("n".
---- "‹leader>dr", ": lua require'dap' .repl.open () <CR>")
----

