return {
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = ";;",
        delete = ";d",
        find = ";f",
        find_left = ";F",
        highlight = ";h",
        replace = ";r",
        update_n_lines = ";n",
      },
    },
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          keys = { "f", "F", "t", "T" },
        },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    keys = {
      {
        "<leader><delete>",
        function()
          Snacks.bufdelete()
        end,
        desc = "Close current buffer",
      },
    },
  },
}
