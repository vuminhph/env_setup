return {
  "rktjmp/lush.nvim",
  config = function()
    local homeDir = os.getenv("HOME")

    require("lazy").setup({
      { dir = string.format("%s/env_setup/cyberpunk_2077", homeDir) },
    })
  end,
}
