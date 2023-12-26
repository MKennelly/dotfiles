-- TS context commentstring is a plugin that automatically sets the commentstring type based on context
require('ts_context_commentstring').setup { }
vim.g.skip_ts_context_commentstring_module = true

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "html", "css", "query", "javascript", "typescript", "tsx", "astro", "svelte" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  -- Plugins
  autotag = {
	  enable = true,
	  filetypes = {
		  'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript', 'astro',
		  'xml',
		  'php',
		  'markdown',
		  'glimmer','handlebars','hbs'
	  }
  },
}
