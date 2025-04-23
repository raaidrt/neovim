return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- required by telescope
    "MunifTanjim/nui.nvim",

    -- optional
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    -- configuration goes here
  },
}
