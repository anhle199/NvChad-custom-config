local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {
  {
    "anhle199/NvChad-base46",
    branch = "v2.0",
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "anhle199/NvChad-ui",
    branch = "v2.0",
    lazy = false,
  },

  {
    "anhle199/NvChad-nvterm",
    init = function()
      require("core.utils").load_mappings "nvterm"
    end,
    config = function(_, opts)
      require "base46.term"
      require("nvterm").setup(opts)
    end,
  },

  {
    "anhle199/NvChad-nvim-colorizer.lua",
    event = "User FilePost",
    config = function(_, opts)
      require("colorizer").setup(opts)

      -- execute colorizer as soon as possible
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },

  { "nvim-treesitter/nvim-treesitter",     opts = overrides.treesitter },
  { "williamboman/mason.nvim",             opts = overrides.mason },
  { "lukas-reineke/indent-blankline.nvim", opts = overrides.blankline },

  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      return require "custom.configs.telescope"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require "custom.configs.cmp"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
    -- config = function(_, opts)
    --   dofile(vim.g.base46_cache .. "nvimtree")

    --   opts.on_attach = function(bufnr)
    --     require("nvim-tree.api").config.mappings.default_on_attach(bufnr)
    --     utils.load_mappings("nvimtree_on_attach", { buffer = bufnr })
    --   end

    --   require("nvim-tree").setup(opts)
    -- end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    -- event = "BufWritePre"
    config = function()
      require "custom.configs.conform"
    end,
  },

  {
    "mg979/vim-visual-multi",
    lazy = false,
    event = "BufRead",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",
        ["Find Subword Under"] = "<C-d>",
      }
    end,
  },

  {
    "b0o/SchemaStore.nvim",
    version = false, -- last release is way too old
  },

  { "NvChad/base46",             enabled = false },
  { "NvChad/ui",                 enabled = false },
  { "NvChad/nvterm",             enabled = false },
  { "NvChad/nvim-colorizer.lua", enabled = false },
  { "folke/which-key.nvim",      enabled = false },
}

return plugins
