return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ensure_installed = {
          "isort",
          "black",
          "isort",
          "debugpy",
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",
          "lua_ls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim", opts = {} },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "nvimtools/none-ls.nvim",
    },

    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.pyright.setup({})
      lspconfig.lua_ls.setup({})

      lspconfig.pylsp.setup({
        settings = {
          pylsp = {
            plugins = {
              -- formatter options
              black = { enabled = true },
              -- autopep8 = { enabled = false },
              -- yapf = { enabled = false },
              -- linter options
              pylint = { enabled = true, executable = "pylint" },
              -- pyflakes = { enabled = false },
              -- pycodestyle = { enabled = false },
              -- type checker
              -- pylsp_mypy = { enabled = true },
              -- auto-completion options
              jedi_completion = { fuzzy = true },
              -- import sorting
              pyls_isort = { enabled = false },
            },
          },
        },
        flags = {
          debounce_text_changes = 200,
        },
      })

      -- Keybinding for formatting
      vim.keymap.set("n", "<leader>F", function()
        vim.lsp.buf.format({ async = true })
      end, { desc = "Format" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
      vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
