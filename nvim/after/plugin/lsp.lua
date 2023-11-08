local lsp = require('lsp-zero').preset({})

lsp.ensure_installed({
	'tsserver',
	'eslint',
})

-- Completion config
local cmp = require('cmp')
cmp.setup({
	mapping = {
		['<C-Space>'] = cmp.mapping.complete(),
	},
})

-- LSP Config

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})

  local opts = { buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>dws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>dw", function() vim.diagnostic.open_float() end, opts)
  -- Next one requires telescope.nvim
  -- vim.keymap.set("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", opts)
  vim.keymap.set("n", "<leader>dd", require('fzf-lua').diagnostics_document, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "<leader>dca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>drr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>drn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- Eslint auto format on save
require('lspconfig').eslint.setup({
	validate = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte' },
	on_attach = function(client, bufnr)
	 vim.api.nvim_create_autocmd("BufWritePre", {
	   buffer = bufnr,
	   command = "EslintFixAll",
	 })
	end,
})

lsp.setup()

-- NULL LS Stuff (mainly for prettier currently)

local null_ls = require('null-ls')
local null_format_group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre"
local async = event == "BufWritePost"

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })

      -- format on save
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = null_format_group })
      vim.api.nvim_create_autocmd(event, {
        buffer = bufnr,
        group = null_format_group,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
        desc = "[lsp] format on save",
      })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end,
})

local prettier = require("prettier")
prettier.setup({
  bin = 'prettier',
  filetypes = {
    "css", "graphql", "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "yaml", "svelte"
  }
})
