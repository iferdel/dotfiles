local set = vim.opt_local

vim.opt.wrap = false

set.shiftwidth = 2
set.tabstop = 2
set.number = true
set.relativenumber = true

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    vim.lsp.buf.format()
    vim.lsp.buf.code_action { context = { only = { 'source.organizeImports' } }, apply = true }
  end,
})
