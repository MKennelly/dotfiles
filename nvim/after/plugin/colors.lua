-- local onedark = require('onedark')
--
-- onedark.setup {
-- 	code_style = {
-- 		comments = 'bold',
-- 	}
-- }
--
-- onedark.load()

local darken = require("catppuccin.utils.colors").darken
require("catppuccin").setup {
    custom_highlights = function(colors)
        return {
          DiffAdd = { bg = darken(colors.green, 0.4, colors.base) },
          DiffChange = { bg = darken(colors.blue, 0.3, colors.base) },
          DiffDelete = { bg = darken(colors.red, 0.4, colors.base) },
        }
    end
}

vim.cmd.colorscheme "catppuccin-frappe"
