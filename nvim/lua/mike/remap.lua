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
-- Move selected block up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
-- J to move line below up to join current, but keep cursor where it is rather than move to join point
map("n", "J", "mzJ`z")
-- Allow leader p to paste without overriding buffer to let you repeatedly paste same text
map("x", "<leader>p", "\"_dP")
-- Delete to void buffer with leader d
map("n", "<leader>d", "\"_d")
map("v", "<leader>d", "\"_d")

-- Pane/tab management
-- map("n", "<leader>e", vim.cmd.Exp)
map("n", "<leader>e", vim.cmd.Oil)
map("n", "<leader>t", function()
  vim.cmd.tabnew()
  vim.cmd.Oil()
end)
map("n", "<leader>v", vim.cmd.vsplit)
map("n", "<leader>s", vim.cmd.split)
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
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+Y')

-- Toggle listchars
map("n", "<leader><tab>", ":set list!<cr>")

-- Quickfix navigation
map("n", "]q", ":cnext<cr>")
map("n", "[q", ":cprev<cr>")
map("n", "]Q", ":clast<cr>")
map("n", "[Q", ":cfirst<cr>")
