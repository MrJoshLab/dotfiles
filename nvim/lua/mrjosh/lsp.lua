local vim = vim

require('nvim-lsp-installer').setup({
  log_level = vim.log.levels.DEBUG,
  ui = {
    icons = {
      server_installed = '✓',
      server_pending = '➜',
      server_uninstalled = '✗',
    },
  },
})

local lspconfig = require("lspconfig")

local util = require 'lspconfig.util'

local capabilities = require('cmp_nvim_lsp').default_capabilities()

--local function on_attach(client, bufnr)
local function on_attach()
  --require'lsp_compl'.attach(client, bufnr, { server_side_fuzzy_completion = true })
end

lspconfig.pylsp.setup{
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391'},
          maxLineLength = 100
        }
      }
    }
  }
}

lspconfig.rust_analyzer.setup {
  cmd = {"/Users/josh/.local/share/nvim/lsp_servers/rust/rust-analyzer"},
  capabilities = capabilities,
}

--lspconfig.yamlls.setup{
  --capabilities = capabilities,
  --on_attach=on_attach,
  --cmd = {"/Users/josh/.local/share/nvim/lsp_servers/yamlls/node_modules/yaml-language-server/bin/yaml-language-server"},
--}

require'lspconfig'.html.setup {
  capabilities = capabilities,
  on_attach=on_attach,
}

require'lspconfig'.tsserver.setup{}

require'lspconfig'.cssls.setup {
  filetypes = { "css", "scss", "less" },
  capabilities = capabilities,
}

require'lspconfig'.cssmodules_ls.setup{
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  cmd = {"cssmodules-language-server"},
  capabilities = capabilities,
}

lspconfig.gopls.setup{
  on_attach=on_attach,
  filetypes = { "go", "gomod" },
  cmd = {"/Users/josh/.local/share/nvim/lsp_servers/go/gopls", "serve"},
  capabilities = capabilities,
}

lspconfig.terraformls.setup {
  cmd = { "/opt/homebrew/bin/terraform-ls", "serve" },
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "terraform", "terraform-vars" },
  root_dir = util.root_pattern(".terraform", ".git"),
}

lspconfig.tflint.setup {
  cmd = { "/Users/josh/.local/share/nvim/lsp_servers/tflint/tflint", "--langserver" },
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = util.root_pattern(".terraform", ".git", ".tflint.hcl"),
}

lspconfig.helm_ls.setup {
  settings = {
    ['helm-ls'] = {
      logLevel = "info",
      valuesFiles = {
        mainValuesFile = "values.yaml",
        lintOverlayValuesFile = "values.lint.yaml",
        additionalValuesFilesGlobPattern = "values*.yaml"
      },
      yamlls = {
        path = "/Users/josh/.local/share/nvim/lsp_servers/yamlls/node_modules/yaml-language-server/bin/yaml-language-server",
        enabled = true,
        diagnosticsLimit = 50,
        showDiagnosticsDirectly = false,
        config = {
          schemas = {
            kubernetes = "templates/**",
          },
          completion = true,
          hover = true,
          -- any other config from https://github.com/redhat-developer/yaml-language-server#language-server-settings
        }
      }
    }
  }
}

lspconfig.golangci_lint_ls.setup{
  on_attach=on_attach,
  filetypes = {"go", "gomod"},
  cmd = {
    "/Users/josh/.local/share/nvim/lsp_servers/golangci_lint_ls/golangci-lint",
  },
  capabilities = capabilities,
  init_options = {
    command = {
      'golangci-lint',
      'run',
      --'--enable-all',
      --'--disable',
      --'lll',
      '--skip-files', '.*.gen.go',
      '--skip-files', '.*_test.go',
      '--disable-all',
      '-E', 'structcheck',
      '-E', 'deadcode',
      '-E', 'gocyclo',
      '-E', 'ineffassign',
      '-E', 'revive',
      '-E', 'goimports',
      '-E', 'errcheck',
      '-E', 'varcheck',
      '-E', 'goconst',
      '-E', 'megacheck',
      '-E', 'misspell',
      '-E', 'unused',
      '-E', 'typecheck',
      '-E', 'staticcheck',
      '-E', 'govet',
      '--out-format', 'json',
    },
  },
  --root_dir = util.root_pattern('go.work') or util.root_pattern('go.mod', '.golangci.yaml', '.git'),
  root_dir = function(fname)
    return util.root_pattern 'go.work'(fname) or util.root_pattern('go.mod', '.git')(fname)
  end,
}

require'lspconfig'.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"/Users/josh/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server"};
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    update_in_insert = true,
  }
)

require 'mrjosh.lsp-compe'
