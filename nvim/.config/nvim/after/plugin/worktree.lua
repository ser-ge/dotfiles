-- let gw = require('telescope')

-- -- Creates a worktree.  Requires the path, branch name, and the upstream
-- -- Example:
-- :lua require("git-worktree").create_worktree("feat-69", "master", "origin")

-- -- switches to an existing worktree.  Requires the path name
-- -- Example:
-- :lua require("git-worktree").switch_worktree("feat-69")

-- -- deletes to an existing worktree.  Requires the path name
-- -- Example:
-- :lua require("git-worktree").delete_worktree("feat-69")

-- require("telescope").load_extension("git_worktree")
-- vim.keymap.set("n", "<leader>gl", require("telescope").extensions.git_worktree.git_worktrees())
-- vim.keymap.set("n", "<leader>gn", require("telescope").extensions.git_worktree.git_worktrees())

local Worktree = require("git-worktree")

-- op = Operations.Switch, Operations.Create, Operations.Delete
-- metadata = table of useful values (structure dependent on op)
--      Switch
--          path = path you switched to
--          prev_path = previous worktree path
--      Create
--          path = path where worktree created
--          branch = branch name
--          upstream = upstream remote name
--      Delete
--          path = path where worktree deleted
Worktree.on_tree_change(function(op, metadata)
  if op == Worktree.Operations.Switch then
    -- Store the new path in a variable
    local new_path = metadata.path

    -- Format the tmux command to change the working directory
    local tmux_change_dir_cmd = "cd " .. new_path .. "<CR>"

    -- Use Slime to send the command to tmux
    vim.fn["slime#send"](tmux_change_dir_cmd)
  end
end)

