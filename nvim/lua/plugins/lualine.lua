return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
  config = {
    options = {
      theme = 'catppuccin-frappe'
    },
    sections = {
      lualine_c = {
        {
          'filename',
          path = 1
        }
      }
    },
    inactive_sections = {
      lualine_c = {
        {
          'filename',
          path = 1
        }
      }
    }
  }
}
