local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

vim.opt.termguicolors = true

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_set_option("clipboard","unnamedplus")

require("lazy").setup({
  {
    "aserowy/tmux.nvim",
    config = function() return require("tmux").setup() end
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { 'freddiehaddad/feline.nvim' },
  { 'xiyaowong/transparent.nvim' },
  { 'junegunn/fzf' },
  { 'junegunn/fzf.vim' },
  { 'ThePrimeagen/vim-be-good' },
})

require("catppuccin").setup {
    highlight_overrides = {
        all = function(colors)
            return {
                NvimTreeNormal = { fg = colors.none },
                CmpBorder = { fg = "#3e4145" },
            }
        end,
        latte = function(latte)
            return {
                Normal = { fg = latte.base },
            }
        end,
        frappe = function(frappe)
            return {
                ["@comment"] = { fg = frappe.surface2, style = { "italic" } },
            }
        end,
        macchiato = function(macchiato)
            return {
                LineNr = { fg = macchiato.overlay1 },
            }
        end,
        mocha = function(mocha)
            return {
                Comment = { fg = mocha.flamingo },
            }
        end,
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

