vim.keymap.set("n", "<leader>gs", vim.cmd.Git);

-- Vim Fugitive 3-way diff stuff
-- Press dv in fugitive on file to vert split, then gh for taking left
-- gl for taking right
vim.keymap.set("n", "gl", "<cmd>diffget //3<CR>")
vim.keymap.set("n", "gh", "<cmd>diffget //2<CR>")
