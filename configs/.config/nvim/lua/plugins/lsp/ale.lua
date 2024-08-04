return {
  "dense-analysis/ale",
  config = function()
    -- Configuration goes here.
    local g = vim.g

    g.ale_ruby_rubocop_auto_correct_all = 1
    g.ale_completion_enabled = 1

    g.ale_linters = {
      ruby = { "rubocop", "ruby" },
      lua = { "lua_language_server" },
      python = { "pyright" },
    }

    g.ale_fixers = {
      python = { "autoimport" },
    }
    g.ale_python_autoimport_executable = "autoimport"
    g.ale_fix_on_save = 0
  end,
}
