function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- Modes
-- 	normal_mode = "n",
-- 	insert_mode = "i",
-- 	visual_mode = "v",
-- 	visual_block_mode = "x",
-- 	term_mode = "t",
-- 	command_mode = "c",

map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Clear highlighting
map("n", "<leader><space>", vim.cmd.nohl)

-- Save/Exit stuff
map("n", "<leader>q", vim.cmd.q)
map("n", "<leader>w", vim.cmd.w)
map("n", "<leader>x", vim.cmd.x)

-- Reload current file buffer
map("n", "<leader>re", vim.cmd.edit)

-- Movement
-- Center active search results
map("n", "n", "nzzzv", { silent = true })
map("n", "N", "Nzzzv", { silent = true })
-- Move vertically by visual line
map("n", "j", "gj")
map("n", "k", "gk")

-- Pane/tab management
map("n", "<leader>e", vim.cmd.Exp)
map("n", "<leader>t", function()
  vim.cmd.tabnew()
  vim.cmd.Exp()
end)
map("n", "<leader>v", function()
  vim.cmd.vsplit()
  vim.cmd.w()
  vim.cmd.Exp()
end)
map("n", "<leader>s", function()
  vim.cmd.split()
  vim.cmd.w()
  vim.cmd.Exp()
end)
map("n", "<leader>h", "<C-w>h")
map("n", "<leader>H", "<C-w>H")
map("n", "<leader>l", "<C-w>l")
map("n", "<leader>L", "<C-w>L")
map("n", "<leader>j", "<C-w>j")
map("n", "<leader>J", "<C-w>J")
map("n", "<leader>k", "<C-w>k")
map("n", "<leader>K", "<C-w>K")
map("n", "<leader>n", "<C-w>w")


-- Replace
map("n", "<leader>r", ":%s///g<left><left><left>", { noremap = true })

-- Spell checking
map("n", "<leader>zz", function() vim.opt.spell = true end)
map("n", "<leader>zn", function() vim.opt.spell = false end)

-- " Buffer management
map("n", "<right>", vim.cmd.bnext)
map("n", "<left>", vim.cmd.bprevious)
map("n", "<C-x>", vim.cmd.bdelete)
map("n", "<leader>bq", ":bp <bar> bd! #<cr>")
map("n", "<leader>ba", ":bufdo bd!<cr>")
-- Yank to clipboard
map("v", "<leader>y", '"+y')

-- Toggle listchars
map("n", "<leader><tab>", ":set list!<cr>")
