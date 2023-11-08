require('nvim_comment').setup({
  hook = function()
    if vim.api.nvim_buf_get_option(0, "filetype") == "svelte" then
      require("ts_context_commentstring.internal").update_commentstring()
    end
    if vim.api.nvim_buf_get_option(0, "filetype") == "typescriptreact" then
      require("ts_context_commentstring.internal").update_commentstring()
    end
  end
})
