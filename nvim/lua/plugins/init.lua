return {

  -- { 'nvim-telescope/telescope.nvim', tag = '0.1.6', dependencies = { 'nvim-lua/plenary.nvim' } },
	{ 'ibhagwan/fzf-lua',
	  -- optional for icon support
	  dependencies = { 'nvim-tree/nvim-web-devicons' }
	},

  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Color Schemes
	'navarasu/onedark.nvim',
  { "catppuccin/nvim", as = "catppuccin" },
  { "EdenEast/nightfox.nvim" },

	{
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {'JoosepAlviste/nvim-ts-context-commentstring'},
  },
	'nvim-treesitter/playground',
	'windwp/nvim-ts-autotag',

  'norcalli/nvim-colorizer.lua',

  -- Eventually may try to switch for native lua
	'machakann/vim-sandwich',
  -- {
  --   "kylechui/nvim-surround",
  --   tag = "*", -- Use for stability; omit to use `main` branch for the latest features
  --   config = function()
  --       require("nvim-surround").setup({
  --           -- Configuration here, or leave empty to use defaults
  --       })
  --   end
  -- },

	'mbbill/undotree',
	'tpope/vim-fugitive',

	'Galooshi/vim-import-js',
  'terrortylor/nvim-comment',
	'airblade/vim-gitgutter',

	{
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	},

  -- LSP Support (lsp-zero no longer required)
  {'neovim/nvim-lspconfig'},
  -- Autocompletion
  {'hrsh7th/nvim-cmp'},     -- Required
  {'hrsh7th/cmp-nvim-lsp'}, -- Required
  {'hrsh7th/cmp-nvim-lua'}, -- Required
  -- {'L3MON4D3/LuaSnip'}, -- I think this now can be replaced with vim.snippet (v0.10+)
  -- LSP Management
  { 'williamboman/mason.nvim' },
  {'williamboman/mason-lspconfig.nvim'},


  {'nvim-pack/nvim-spectre', dependencies = { {'nvim-lua/plenary.nvim'} } },

  -- 'github/copilot.vim',
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({
  --       -- panel = {
  --         -- enabled = true,
  --         -- auto_refresh = false,
  --         -- keymap = {
  --         --   jump_prev = "[[",
  --         --   jump_next = "]]",
  --         --   accept = "<CR>",
  --         --   refresh = "gr",
  --         --   open = "<M-CR>"
  --         -- },
  --         -- layout = {
  --         --   position = "bottom", -- | top | left | right
  --         --   ratio = 0.4
  --         -- },
  --       -- },
  --       suggestion = {
  --         enabled = true,
  --         auto_trigger = true,
  --         debounce = 75,
  --         keymap = {
  --           accept = "<M-y>",
  --           accept_word = false,
  --           accept_line = false,
  --           next = "<M-n>",
  --           prev = "<M-p>",
  --           dismiss = "<C-]>",
  --         },
  --       },
  --       -- filetypes = {
  --         -- yaml = false,
  --         -- markdown = false,
  --         -- help = false,
  --         -- gitcommit = false,
  --         -- gitrebase = false,
  --         -- hgcommit = false,
  --         -- svn = false,
  --         -- cvs = false,
  --         -- ["."] = false,
  --       -- },
  --       -- copilot_node_command = 'node', -- Node.js version must be > 16.x
  --       -- server_opts_overrides = {},
  --     })
  --   end,
  -- },
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<M-y>",
          clear_suggestion = "<M-c>",
          accept_word = "<M-j>",
        }
      })
    end,
  },

  -- Completions/docs for vim/nvim lua functions
  { "folke/neodev.nvim", opts = {} },
  {
    "3rd/image.nvim",
    build = false,
    opts = {
      processor = "magick_cli",
    }
  },
}
