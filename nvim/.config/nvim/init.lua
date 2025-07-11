vim.g.mapleader = " "      -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "n" -- Same for `maplocalleader`


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

require("core")


vim.g.rustaceanvim = {
	-- LSP configuration
	server = {
		default_settings = {
			-- rust-analyzer language server configuration
			['rust-analyzer'] = {
				-- Other Settings ...
				procMacro = {
					ignored = {
						leptos_macro = {
							-- optional: --
							-- "component",
							"server",
						},
					},
				},
			},
		},
	}
}
