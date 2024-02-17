---@type MappingsTable
local M = {}
local default_opts = { noremap = true, silent = true }

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>m"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },

    ["<leader>n"] = { "<cmd> enew <CR>", "New buffer" },
    ["<leader>w"] = { "<cmd> w <CR>" },
    ["<leader>q"] = { "<cmd> q <CR>" },
    ["<leader>l"] = { "<cmd> Lazy <CR>" },
  },
  i = {
    ["jk"] = { "<ESC>", opts = default_opts },
  },
  v = {
    ["J"] = { ":move '>+1<cr>gv=gv", opts = default_opts },
    ["K"] = { ":move '<-2<cr>gv=gv", opts = default_opts },
    ["<BS>"] = { '"_d', opts = default_opts },
  },
}

M.disabled = {
  n = {
    -- general
    ["<C-h>"] = "",
    ["<C-l>"] = "",
    ["<C-j>"] = "",
    ["<C-k>"] = "",
    ["<C-s>"] = "",
    ["<C-c>"] = "",
    ["<leader>n"] = "",
    ["<leader>rn"] = "",
    ["<leader>b"] = "",
    ["<leader>ch"] = "",

    -- tabufline
    ["<leader>x"] = "",

    -- lspconfig
    ["<leader>ls"] = "",
    ["<leader>D"] = "",
    ["<leader>ra"] = "",
    ["<leader>lf"] = "",
    ["<leader>q"] = "",
    ["<leader>wa"] = "",
    ["<leader>wr"] = "",
    ["<leader>wl"] = "",
    ["<leader>fm"] = "",

    -- nvimtree
    ["<leader>e"] = "",

    -- telescope
    ["<leader>fb"] = "",
    ["<leader>fh"] = "",
    ["<leader>fo"] = "",
    ["<leader>fz"] = "",
    ["<leader>cm"] = "",
    ["<leader>gt"] = "",
    ["<leader>pt"] = "",
    ["<leader>th"] = "",
    ["<leader>ma"] = "",

    -- nvterm
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
    ["<leader>h"] = "",
    ["<leader>v"] = "",

    -- whichkey
    ["<leader>wK"] = "",
    ["<leader>wk"] = "",

    -- gitsigns
    ["]c"] = "",
    ["[c"] = "",
    ["<leader>rh"] = "",
    ["<leader>ph"] = "",
    ["<leader>td"] = "",
  },
  i = {
    -- general
    ["<C-h>"] = "",
    ["<C-l>"] = "",
    ["<C-j>"] = "",
    ["<C-k>"] = "",
  },
  t = {
    -- nvterm
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
  },
}

M.tabufline = {
  plugin = true,

  n = {
    -- close buffer + hide terminal buffer
    ["<leader>b"] = {
      function()
        require("nvchad.tabufline").close_buffer()
      end,
      "Close buffer",
    },
  },
}

M.lspconfig = {
  plugin = true,

  n = {
    ["<leader>rn"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP rename",
    },
    ["<leader>df"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },
  },
}

M.telescope = {
  plugin = true,

  n = {
    ["<leader>fb"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },
  },
}

-- M.nvimtree_on_attach = {
--   plugin = true,

--   n = {
--     ["t"] = {
--       function()
--         require("nvim-tree.api").node.open.tab()
--       end,
--       opts = { noremap = true, silent = true, nowait = true },
--     },
--     ["v"] = {
--       function()
--         require("nvim-tree.api").node.open.vertical()
--       end,
--       opts = { noremap = true, silent = true, nowait = true },
--     },
--     ["x"] = {
--       function()
--         require("nvim-tree.api").node.open.horizontal()
--       end,
--       opts = { noremap = true, silent = true, nowait = true },
--     },
--   },
-- }

return M
