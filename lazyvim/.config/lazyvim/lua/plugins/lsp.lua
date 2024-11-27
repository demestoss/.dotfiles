return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        biome = {
          offset_encoding = "utf-16",
        },
        vtsls = {
          keys = {
            {
              "<leader>cp",
              function()
                LazyVim.lsp.action["source.addMissingImports.ts"]()
                LazyVim.lsp.action["source.fixAll.ts"]()
                LazyVim.format({ force = true })
              end,
              desc = "Fix everything",
            },
          },
        },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<C-e>", "<leader>fb", desc = "Buffers", remap = true },
    },
  },
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   keys = {
  --     { "<C-e>", "<leader>fb", desc = "Buffers", remap = true },
  --   },
  --   opts = {
  --     defaults = {
  --       layout_config = { prompt_position = "top" },
  --       sorting_strategy = "ascending",
  --       winblend = 0,
  --     },
  --   },
  -- },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-q>"] = cmp.mapping.abort(),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        -- ["<Tab>"] = vim.schedule_wrap(function(fallback)
        --   local has_words_before = function()
        --     if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        --       return false
        --     end
        --     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        --     return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
        --   end
        --
        --   if cmp.visible() and has_words_before() then
        --     cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        --   else
        --     fallback()
        --   end
        -- end),
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function()
      require("conform").formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { "biome-check", "biome-check" },
        javascriptreact = { "biome-check" },
        typescript = { "biome-check" },
        vue = { "biome-check" },
        svelte = { "biome-check" },
        typescriptreact = { "biome-check" },
        css = { "biome-check" },
        html = { "prettierd" },
        json = { "biome-check" },
        markdown = { "prettierd" },
        yaml = { "yamlfix", "yamlfmt" },
        tsx = { "biome-check" },
        sh = { "beautysh" },
        rust = { "rustfmt" },
        ["*"] = { "codespell" },
        ["_"] = { "codespell" },
      }
    end,
  },
}
