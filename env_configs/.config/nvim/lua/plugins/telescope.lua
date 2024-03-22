return {
  "nvim-telescope/telescope.nvim",
  keys = {
    "<leader>fg",
    function()
      require("telescope.builtin").live_grep({})
    end,
    desc = "Live Grep",
  },
}
