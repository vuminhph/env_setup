-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Disable training hyphens when pressing space
vim.opt.list = false

vim.opt.clipboard = "unnamedplus"

-- blinking cursor
-- vim.opt.guicursor = "n:block-Cursor/lCursor-blinkwait700-blinkoff400-blinkon250"
vim.opt.guicursor = "n-v-c:block/lCursor-blinkwait500-blinkoff400-blinkon500,i-ci-ve:ver25,r-cr:hor20,o:hor50"
