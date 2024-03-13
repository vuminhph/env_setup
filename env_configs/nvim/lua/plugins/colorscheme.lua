-- lazy.colorscheme.register({
--   name = "cyberpunk_2077", -- Replace with your scheme name
--   file = "@colorscheme/cyberpunk_2077.lua", -- Path to your scheme file relative to LazyVim's colors directory
-- })

return {
  -- Configure LazyVim to load elflord
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "elflord",
    },
  },
}
