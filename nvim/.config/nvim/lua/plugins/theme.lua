return {
  { 'freddiehaddad/feline.nvim' },
  { 
      "catppuccin/nvim", 
      name = "catppuccin", 
      priority = 1000, 
      config = function()
        require("catppuccin").setup {
            flavour = "macchiato",
            transparent_background = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false
            },
            custom_highlights = function(colors)
                return {
                    Comment = { fg = colors.flamingo },
                    TabLineSel = { bg = colors.pink },
                    CmpBorder = { fg = colors.surface2 },
                    Pmenu = { bg = colors.none },
                }
            end
        }

        local clrs = require("catppuccin.palettes").get_palette()
        local ctp_feline = require('catppuccin.groups.integrations.feline')
        local U = require "catppuccin.utils.colors"

        local mocha = require("catppuccin.palettes").get_palette "mocha"

        local sett = {
            text = U.vary_color({ mocha = mocha.base }, clrs.surface0),
            bkg = U.vary_color({ mocha = mocha.crust }, clrs.surface0),
            diffs = clrs.mauve,
            extras = clrs.overlay1,
            curr_file = clrs.maroon,
            curr_dir = clrs.flamingo,
            show_modified = true -- show if the file has been modified
        }

        local assets = {
            mode_icon = "",
            left_separator = "",
            right_separator = "",
            dir = "󰉖",
            file = "󰈙",
            lsp = {
                server = "󰅡",
                error = "",
                warning = "",
                info = "",
                hint = "",
            },
            git = {
                branch = "",
                added = "",
                changed = "",
                removed = "",
            },
        },


        ctp_feline.setup({
            assets = {
                mode_icon = "",
                left_separator = " ",
                right_separator = " ",
                dir = "󰉖",
                file = "󰈙",
                lsp = {
                    server = "󰅡",
                    error = "",
                    warning = "",
                    info = "",
                    hint = "",
                },
                git = {
                    branch = "",
                    added = "",
                    changed = "",
                    removed = "",
                },
            },
            mode_colors = {
                ["n"] = { "NORMAL", clrs.lavender },
                ["no"] = { "N-PENDING", clrs.lavender },
                ["i"] = { "INSERT", clrs.green },
                ["ic"] = { "INSERT", clrs.green },
                ["t"] = { "TERMINAL", clrs.green },
                ["v"] = { "VISUAL", clrs.flamingo },
                ["V"] = { "V-LINE", clrs.flamingo },
                ["�"] = { "V-BLOCK", clrs.flamingo },
                ["R"] = { "REPLACE", clrs.maroon },
                ["Rv"] = { "V-REPLACE", clrs.maroon },
                ["s"] = { "SELECT", clrs.maroon },
                ["S"] = { "S-LINE", clrs.maroon },
                ["�"] = { "S-BLOCK", clrs.maroon },
                ["c"] = { "COMMAND", clrs.peach },
                ["cv"] = { "COMMAND", clrs.peach },
                ["ce"] = { "COMMAND", clrs.peach },
                ["r"] = { "PROMPT", clrs.teal },
                ["rm"] = { "MORE", clrs.teal },
                ["r?"] = { "CONFIRM", clrs.mauve },
                ["!"] = { "SHELL", clrs.green },
            }
        })

        local components = ctp_feline.get()

        local function is_enabled(min_width)
            return vim.api.nvim_win_get_width(0) > min_width
        end

        components.active[3][3] = {
            provider = function()
                local filename = vim.fn.fnamemodify(vim.fn.expand('%'), ':p:~:.')
                local extension = vim.fn.expand "%:e"
                local present, icons = pcall(require, "nvim-web-devicons")
                local icon = present and icons.get_icon(filename, extension) or "󰈙"
                return (true and "%m" or "") .. " " .. icon .. " " .. filename .. " "
            end,
            enabled = is_enabled(70),
            hl = {
                fg = sett.text,
                bg = sett.curr_file,
            },
            left_sep = {
                str = assets.left_separator,
                hl = {
                    fg = sett.curr_file,
                    bg = sett.bkg,
                },
            },
        }

        require("feline").setup({
            components = components,
        })
          end
      },
}

