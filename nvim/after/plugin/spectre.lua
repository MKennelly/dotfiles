require('spectre').setup({
  highlight = {
      ui = "String",
      search = "DiffDelete",
      replace = "DiffAdd"
  },
  mapping = {
    ['send_to_qf'] = {
        map = "<leader>Q",
        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
        desc = "send all items to quickfix"
    },
    ['change_view_mode'] = {
        map = "<leader>V",
        cmd = "<cmd>lua require('spectre').change_view()<CR>",
        desc = "change result view mode"
    },
    ['resume_last_search'] = {
      map = "<leader>L",
      cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
      desc = "repeat last search"
    },
  }
})

vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})
vim.keymap.set('n', '<leader>rw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word"
})
vim.keymap.set('v', '<leader>rw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})
vim.keymap.set('n', '<leader>rif', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file"
})
