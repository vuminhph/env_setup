local homeDir = os.getenv("HOME")

-- example when using lazy.nvim
require("lazy").setup({
  { dir = string.format("%s/env_setup/cyberpunk_2077", homeDir) },
})

return {
  -- Configure LazyVim to load default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "cyberpunk_2077",
    },
  },
}
