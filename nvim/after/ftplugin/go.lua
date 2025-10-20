local set = vim.opt_local

vim.opt.wrap = false

set.shiftwidth = 2
set.tabstop = 2
set.number = true
set.relativenumber = true

-- Highlight word under cursor after 5 seconds
set.updatetime = 5000

-- Create autocmd group for this buffer
local group = vim.api.nvim_create_augroup('GoDocumentHighlight', { clear = false })

-- Highlight references when cursor stops moving
vim.api.nvim_create_autocmd('CursorHold', {
  group = group,
  buffer = 0,
  callback = function()
    vim.lsp.buf.document_highlight()
  end,
})

-- Clear highlights when cursor moves
vim.api.nvim_create_autocmd('CursorMoved', {
  group = group,
  buffer = 0,
  callback = function()
    vim.lsp.buf.clear_references()
  end,
})
