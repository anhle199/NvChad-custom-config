vim.diagnostic.config {
  underline = false,
  update_in_insert = false,
  virtual_text = false,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
  },
}
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

local capabilities = require("plugins.configs.lspconfig").capabilities
local on_attach = function(client, bufnr)
  require("plugins.configs.lspconfig").on_attach()

  if vim.fn.has "nvim-0.10" == 0 and client.name == "yamlls" then
    client.server_capabilities.documentFormattingProvider = true
  end

  -- workaround for gopls not supporting semanticTokensProvider
  -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
  if client.name == "gopls" then
    if not client.server_capabilities.semanticTokensProvider then
      local semantic = client.config.capabilities.textDocument.semanticTokens
      client.server_capabilities.semanticTokensProvider = {
        full = true,
        legend = {
          tokenTypes = semantic.tokenTypes,
          tokenModifiers = semantic.tokenModifiers,
        },
        range = true,
      }
    end
  end
  -- end workaround
end

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = {
  "lua_ls",
  "tsserver",
  "jsonls",
  "yamlls",
  "gopls",
  "ansiblels",
  "pyright",
  "dockerls",
  "docker_compose_language_service",
  "html",
  "cssls",
}

local default_config = {
  on_attach = on_attach,
  capabilities = capabilities,
}
local custom_configs = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
            [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
            [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  },
  tsserver = {
    keys = {
      {
        "<leader>co",
        function()
          vim.lsp.buf.code_action {
            apply = true,
            context = {
              only = { "source.organizeImports.ts" },
              diagnostics = {},
            },
          }
        end,
        desc = "Organize Imports",
      },
    },
    ---@diagnostic disable-next-line: missing-fields
    settings = {
      completions = {
        completeFunctionCalls = true,
      },
    },
  },
  jsonls = {
    -- lazy-load schemastore when needed
    on_new_config = function(new_config)
      new_config.settings.json.schemas = new_config.settings.json.schemas or {}
      vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
    end,
    settings = {
      json = {
        format = {
          enable = true,
        },
        validate = { enable = true },
      },
    },
  },
  yamlls = {
    -- Have to add this for yamlls to understand that we support line folding
    capabilities = {
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      },
    },
    -- lazy-load schemastore when needed
    on_new_config = function(new_config)
      new_config.settings.yaml.schemas =
          vim.tbl_deep_extend("force", new_config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
    end,
    settings = {
      redhat = { telemetry = { enabled = false } },
      yaml = {
        keyOrdering = false,
        format = {
          enable = true,
        },
        validate = true,
        schemaStore = {
          -- Must disable built-in schemaStore support to use
          -- schemas from SchemaStore.nvim plugin
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
          url = "",
        },
      },
    },
  },
  gopls = {
    settings = {
      gopls = {
        gofumpt = true,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          fieldalignment = true,
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
        semanticTokens = true,
      },
    },
  },
  ansiblels = {
    filetypes = { "yaml", "yml", "ansible" },
    root_dir = lspconfig.util.root_pattern("roles", "playbooks", "tasks", "handlers"),
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "off",
          diagnosticMode = "openFilesOnly",
          diagnosticSeverityOverrides = {
            reportImportCycles = "error",
            reportUnusedImport = "warning",
            reportUnusedClass = "warning",
            reportUnusedFunction = "warning",
            reportUnusedVariable = "warning",
            reportDuplicateImport = "error",
            reportUnnecessaryCast = "warning",
            reportUnnecessaryComparison = "warning",
            reportUnnecessaryContains = "warning",
          },
        },
      },
    },
  },
}

for _, server_name in ipairs(servers) do
  if custom_configs[server_name] then
    lspconfig[server_name].setup(vim.tbl_deep_extend("force", default_config, custom_configs[server_name]))
  else
    lspconfig[server_name].setup(default_config)
  end
end
