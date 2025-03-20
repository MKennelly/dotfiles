-- Always leave signcolumn visible to avoid layout shifts
vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)
--
-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)

    local opts = { buffer = event.buf, remap = false }

    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>dws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>dw", function() vim.diagnostic.open_float() end, opts)

    vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set("n", "<leader>drr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', 'gs', function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)

    vim.keymap.set({'n', 'x'}, '<F3>', function() vim.lsp.buf.format({async = true}) end, opts)
    vim.keymap.set("n", "<leader>drn", function() vim.lsp.buf.rename() end, opts)
    --
    -- Normal/visual mode code actions
    vim.keymap.set({"n", "v"}, "<M-CR>", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>dca", function() vim.lsp.buf.code_action() end, opts)

    -- Next one requires telescope.nvim
    -- vim.keymap.set("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", opts)
    vim.keymap.set("n", "<leader>dd", require('fzf-lua').diagnostics_document, opts)
  end,
})

-- LSP Management Config
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'lua_ls',
    'ts_ls',
    'eslint',
    'svelte',
    'tailwindcss',
    'cssls',
    'stylelint_lsp',
    'rust_analyzer',
    'jsonls',
    'graphql',
    'elixirls',
  },
  handlers = {
    -- this first function is the "default handler"
    -- it applies to every language server without a "custom handler"
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
    -- can add custom handlers for specific servers below

    ["eslint"] = function()
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
    end,

    ["stylelint_lsp"] = function()
      require('lspconfig').stylelint_lsp.setup({
        filetypes = { 'css', 'scss', 'less', 'svelte' },
        settings = {
          stylelintplus = {
            autoFixOnSave = true,
            autoFixOnFormat = true,
          }
        },
      })
    end,

    ["tailwindcss"] = function()
      require('lspconfig').tailwindcss.setup({
        filetypes = {'aspnetcorerazor', 'astro', 'astro-markdown', 'blade', 'clojure', 'css', 'django-html', 'htmldjango', 'edge', 'eelixir', 'elixir', 'ejs', 'erb', 'eruby', 'gohtml', 'gohtmltmpl', 'haml', 'handlebars', 'hbs', 'html', 'html-eex', 'heex', 'jade', 'leaf', 'liquid', 'markdown', 'mdx', 'mustache', 'njk', 'nunjucks', 'php', 'razor', 'slim', 'twig', 'css', 'less', 'postcss', 'sass', 'scss', 'stylus', 'sugarss', 'javascript', 'javascriptreact', 'reason', 'rescript', 'typescript', 'typescriptreact', 'vue', 'svelte'}
      })
    end,

    ["ts_ls"] = function()
      -- don't truncate tsserver information
      require('lspconfig').ts_ls.setup({
        settings = {
          ts = {
            defaultMaximumTruncationLength = 1000
          }
        }
      })
    end,
  },
})

-- Completion config
local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
		['<C-Space>'] = cmp.mapping.complete(),
  }),
})
