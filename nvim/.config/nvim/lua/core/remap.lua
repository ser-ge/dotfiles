vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "jj", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")


vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");

-- vim.keymap.set("n", "<leader><leader>", function()
--     vim.cmd("so")
-- end)


vim.keymap.set("n", "<leader>h", ":wincmd h<CR>")
vim.keymap.set("n", "<leader>l", "<C-w><C-l>")
vim.keymap.set("n", "<leader>j", "<C-w><C-j>")
vim.keymap.set("n", "<leader>k", "<C-w><C-k>")
vim.keymap.set("n", "<leader>m", ":NeoTreeRevealToggle<CR>");
vim.keymap.set("i", "kkk", "# %%<CR>");
vim.keymap.set("i", "bbb", "breakpoint()<Esc>");

vim.keymap.set("i", "<C-g>", "<c-g>u<Esc>[s1z=`]a<c-g>u");

vim.keymap.set("n", "<leader>c", ":ChatGPTEditWithInstructions <CR>")


vim.keymap.set("n", "<leader>n", ":cnext <CR>")
vim.keymap.set("n", "<leader>b", ":cprev <CR>")

-- Some handy tmux functions

function TmuxRepeat()
    vim.cmd(':w')
    vim.fn.system('tmux select-pane -l && tmux send up enter && tmux select-pane -l')
    vim.cmd('redraw!')
end

vim.api.nvim_set_keymap('n', '<Leader>r', ':lua TmuxRepeat()<CR>', { noremap = true, silent = true })

local function find_test_name()
    local line = vim.api.nvim_win_get_cursor(0)[1] -- Get current line
    -- Iterate over the lines of the buffer from the end to the beginning
    for i = line, 1, -1 do
        local line_content = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]
        -- If the line starts with "def test_", extract the test function name
        if line_content:find("^def test_") then
            return line_content:match("^def (%b())"):gsub('[()]', '') -- removing ')'
        end
    end
    return nil -- If no test name found, return nil
end

function run_test_in_tmux()
    local test_name = find_test_name()
    if test_name then
        local file_path = vim.api.nvim_buf_get_name(0)
        vim.fn.system("tmux select-pane -l && tmux send-keys i 'pytest  " .. file_path .. "::" .. test_name .. "' ENTER")
    else
        print('Could not find a test')
    end
end

vim.api.nvim_set_keymap('n', '<Leader>tt', ':lua run_test_in_tmux()<CR>', { noremap = true, silent = true })

-- Define a Lua function to perform the substitutions on visual selection
function replace_newline_visual()
    -- Get the start and end lines of the visual selection

    vim.cmd([[silent %s/\(\S\)\n/\1\n]])
    vim.cmd([[silent %s/\n/&&]])
    vim.cmd([[silent %s/[\x0]/ /g]])

    -- -- Replace newlines with spaces and then strip out NULL characters
    -- vim.cmd(string.format("%d,%ds/\\(\\S\\)\\n/\\1 /g", start_line, end_line))
    -- vim.cmd(string.format("%d,%ds/\\n//g", start_line, end_line))

    -- vim.cmd(string.format("%d,%ds/\x00//g", start_line, end_line)) -- Remove NULL characters
end

-- Create a Vim mapping to call the Lua function
vim.api.nvim_set_keymap('n', '<Leader>gq', ':lua replace_newline_visual()<CR>', { noremap = true, silent = true })
