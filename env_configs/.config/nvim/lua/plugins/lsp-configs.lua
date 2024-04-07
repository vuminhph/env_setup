return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ensure_installed = {
          "isort",
          "black",
          "isort",
          "mypy",
          "ruff",
          "ruff_lsp",
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
    },
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.pyright.setup({})
      lspconfig.lua_ls.setup({})
      -- lspconfig.ruff_lsp.setup({})

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
      vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})

      -- local ctx = { filename = vim.api.nvim_buf_get_name(0) }
      -- local client = vim.lsp.get_client_by_id(ctx.client_id)
      -- local client = vim.lsp.get_active_clients()
      -- local buffer = vim.api.nvim_get_current_buf()
      -- require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
      --
      -- if client.server_capabilities.documentHighlightProvider then
      --   vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
      --   vim.api.nvim_clear_autocmds({ buffer = buffer, group = "lsp_document_highlight" })
      --   vim.api.nvim_create_autocmd("CursorHold", {
      --     callback = vim.lsp.buf.document_highlight,
      --     buffer = buffer,
      --     group = "lsp_document_highlight",
      --     desc = "Document Highlight",
      --   })
      --   vim.api.nvim_create_autocmd("CursorMoved", {
      --     callback = vim.lsp.buf.clear_references,
      --     buffer = buffer,
      --     group = "lsp_document_highlight",
      --     desc = "Clear All the References",
      --   })
      -- end
    end,
  },
}
