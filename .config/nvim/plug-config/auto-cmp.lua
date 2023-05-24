-- https://smarttech101.com/nvim-lsp-autocompletion-mapping-snippets-fuzzy-search/

vim.cmd [[
let g:UltiSnipsJumpForwardTrigger='<S-Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'
]]

-- local kind_icons = {
--   Class = "ﴯ",
--   Color = "",
--   Constant = "",
--   Constructor = "",
--   Enum = "",
--   EnumMember = "",
--   Event = "",
--   Field = "",
--   File = "",
--   Folder = "",
--   Function = "",
--   Interface = "",
--   Keyword = "",
--   Method = "",
--   Module = "",
--   Operator = "",
--   Property = "ﰠ",
--   Reference = "",
--   Snippet = "",
--   Struct = "",
--   Text = "",
--   TypeParameter = "",
--   Unit = "",
--   Value = "",
--   Variable = "",
-- }

local cmp = require 'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  -- formatting = {
  -- format = function(entry, vim_item)
  --     -- Kind icons
  --     vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) --Concatonate the icons with name of the item-kind
  --     vim_item.menu = ({
  --       nvim_lsp = "[LSP]",
  --       spell = "[Spellings]",
  --       zsh = "[Zsh]",
  --       buffer = "[Buffer]",
  --       ultisnips = "[Snip]",
  --       treesitter = "[Treesitter]",
  --       calc = "[Calculator]",
  --       nvim_lua = "[Lua]",
  --       path = "[Path]",
  --       nvim_lsp_signature_help = "[Signature]",
  --       cmdline = "[Vim Command]"
  --     })[entry.source.name]
  --     return vim_item
  --   end,
  -- },
  mapping = {
      ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-M-k>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-M-j>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  },
  -- completion = {
  -- COMPLETION_RELATED_CONFIGURATION_GOES_HERE
  -- },
  matching = {
   disallow_fuzzy_matching = false,
  },
  sources = cmp.config.sources(
    {
    { name = 'nvim_lsp' },
    -- For ultisnips users
    { name = 'ultisnips' },
    -- For vsnip users, uncomment the following.
    -- { name = 'vsnip' },
    -- For luasnip users, uncomment the following.
    -- { name = 'luasnip' },
    -- For snippy users, uncomment the following.
    -- { name = 'snippy' },
  }, {
    { name = 'buffer' },
  }, {
    { name = 'nvim_lsp_signature_help' },
  }, {
    { name = 'path' },
  }
  )
})
require("cmp").setup({
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
        or require("cmp_dap").is_dap_buffer()
  end
})

require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
  sources = {
    { name = "dap" },
  },
})



cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })


-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--     { name = 'path' },
--     { name = 'cmdline' },
--   })
})
