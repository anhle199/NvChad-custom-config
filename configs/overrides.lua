local M = {}

M.treesitter = {
  ensure_installed = {
    "lua",
    "vim",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "markdown",
    "markdown_inline",
    "dockerfile",
    "json",
    "json5",
    "jsonc",
    "python",
    "rst",
    "toml",
    "yaml",
    "go",
    "gomod",
    "gowork",
    "gosum",
    "sql",
    "java",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    "lua-language-server",
    "stylua",
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "prettier",
    "pyright",
    "isort",
    "black",
    "json-lsp",
    "goimports",
    "gofumpt",
    "ansible-language-server",
    "ansible-lint",
    "yamllint",
    "yamlfmt",
  },
}

M.nvimtree = {
  git = {
    enable = true,
  },
  actions = {
    open_file = {
      window_picker = {
        chars = "1234567890",
      },
    },
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    highlight_modified = "all",
    icons = {
      show = {
        git = true,
      },
      glyphs = {
        folder = {
          default = "󰉋",
          open = "󰝰",
        },
      },
    },
  },
}

M.blankline = {
  show_current_context_start = false,
}

return M
