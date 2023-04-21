local fzflua = require('fzf-lua')

-- vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
vim.keymap.set('n', '<C-p>', fzflua.files, {})
vim.keymap.set('n', '<C-g>', function() fzflua.grep({ search = "" }) end, {})
