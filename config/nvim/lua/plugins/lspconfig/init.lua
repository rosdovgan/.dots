local lhses     = require("mappings").lhses
local lspconfig = require("lspconfig")
local helpers   = require("helpers")

do
  local signs = require("icons").diagnostic
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true
})

local shared_config = {}

shared_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
shared_config.capabilities = vim.lsp.protocol.make_client_capabilities()
shared_config.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

shared_config.on_attach = function(client, bufnr)
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        source = "always",
        prefix = " ",
        scope = "line"
      }
      vim.diagnostic.open_float(nil, opts)
    end,
  })

  helpers.set_keymaps({ "n" }, {}, {
    [lhses.format] = function()
      vim.lsp.buf.format({
        async = true,
        filter = function() return client.name ~= "tsserver" end
      })
    end,
    [lhses.hover] = vim.lsp.buf.hover,
    [lhses.rename] = vim.lsp.buf.rename
  })
end

lspconfig.lua_ls.setup(helpers.merge_tables(shared_config, {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      telemetry = { enable = false }
    }
  }
}))

lspconfig.bashls.setup(shared_config)

lspconfig.nixd.setup(helpers.merge_tables(shared_config, {
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }"
      },
      formatting = {
        command = { "alejandra" }
      },
      options = {
        nixos = {
          expr =
          '(builtins.getFlake "/etc/.dots").nixosConfigurations.main.options'
        },
        home_manager = {
          expr =
          '(builtins.getFlake "/etc/.dots").homeConfigurations.main.options'
        },
        flake_parts = {
          expr = 'let flake = builtins.getFlake ("/etc/.dots"); in '
              .. 'flake.debug.options // flake.currentSystem.options'
        }
      }
    }
  }
}))

lspconfig.hls.setup(helpers.merge_tables(shared_config, {
  filetypes = { "haskell", "lhaskell", "cabal" },
  settings = {
    haskell = {
      cabalFormattingProvider = "cabalfmt",
      formattingProvider = "ormolu"
    }
  }
}))

lspconfig.dartls.setup(shared_config)

lspconfig.rust_analyzer.setup(helpers.merge_tables(shared_config, {
  settings = {
    ["rust-analyzer"] = {
      procMacro = { enable = true },
      cargo = { allFeatures = true },
      checkOnSave = {
        command = "clippy",
        extraArgs = { "--no-deps" }
      }
    }
  }
}))

lspconfig.tsserver.setup(shared_config)

-- lspconfig.eslint.setup({
--   codeAction = {
--     disableRuleComment = {
--       enable = true,
--       location = "separateLine"
--     },
--     showDocumentation = {
--       enable = true
--     }
--   },
--   codeActionOnSave = {
--     enable = false,
--     mode = "all"
--   },
--   experimental = {
--     useFlatConfig = false
--   },
--   format = false,
--   nodePath = "",
--   onIgnoredFiles = "off",
--   packageManager = "npm",
--   problems = {
--     shortenToSingleLine = false
--   },
--   quiet = false,
--   rulesCustomizations = {},
--   run = "onType",
--   useESLintClass = false,
--   validate = "on",
--   workingDirectory = {
--     mode = "location"
--   }
-- })
-- lspconfig.emmet_ls.setup({})
-- lspconfig.cssls.setup({
--   capabilities = lspCapabilities,
-- })
-- lspconfig.csharp_ls.setup({})
