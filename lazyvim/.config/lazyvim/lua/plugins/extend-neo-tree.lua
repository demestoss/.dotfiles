return {
  {
    "antosha417/nvim-lsp-file-operations",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim",
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
      },
      close_if_last_window = true,
      window = {
        position = "right",
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            dir = LazyVim.root(),
            position = "current",
            reveal = true,
          })
        end,
        desc = "Explorer NeoTree Full (Root Dir)",
      },
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd(), position = "current", reveal = true })
        end,
        desc = "Explorer NeoTree Full (cwd)",
      },
    },
  },
}
