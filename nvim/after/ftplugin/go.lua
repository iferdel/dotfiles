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

-- -- Minimal syntax highlighting (https://tonsky.me/blog/syntax-highlighting/)
-- -- Principle: Only highlight strings, constants, numbers, top-level definitions, and comments
-- -- Don't highlight: keywords, variables, function calls
--
-- local function setup_minimal_highlighting()
--   -- Get current buffer
--   local buf = vim.api.nvim_get_current_buf()
--
--   -- UNHIGHLIGHT: Keywords (if, for, func, return, etc.)
--   vim.api.nvim_set_hl(0, '@keyword.go', { link = 'Normal' })
--   vim.api.nvim_set_hl(0, '@keyword.function.go', { link = 'Normal' })
--   vim.api.nvim_set_hl(0, '@keyword.return.go', { link = 'Normal' })
--   vim.api.nvim_set_hl(0, '@keyword.operator.go', { link = 'Normal' })
--   vim.api.nvim_set_hl(0, '@keyword.import.go', { link = 'Normal' })
--   vim.api.nvim_set_hl(0, '@keyword.type.go', { link = 'Normal' })
--   vim.api.nvim_set_hl(0, '@keyword.modifier.go', { link = 'Normal' })
--   vim.api.nvim_set_hl(0, '@keyword.repeat.go', { link = 'Normal' })
--   vim.api.nvim_set_hl(0, '@keyword.conditional.go', { link = 'Normal' })
--
--   -- UNHIGHLIGHT: Variables and parameters
--   vim.api.nvim_set_hl(0, '@variable.go', { link = 'Normal' })
--   vim.api.nvim_set_hl(0, '@variable.parameter.go', { link = 'Normal' })
--   vim.api.nvim_set_hl(0, '@variable.member.go', { link = 'Normal' })
--
--   -- UNHIGHLIGHT: Function calls
--   vim.api.nvim_set_hl(0, '@function.call.go', { link = 'Normal' })
--   vim.api.nvim_set_hl(0, '@function.method.call.go', { link = 'Normal' })
--
--   -- UNHIGHLIGHT: Types (they're just names)
--   vim.api.nvim_set_hl(0, '@type.go', { link = 'Normal' })
--   vim.api.nvim_set_hl(0, '@type.builtin.go', { link = 'Normal' })
--
--   -- UNHIGHLIGHT: Operators
--   vim.api.nvim_set_hl(0, '@operator.go', { link = 'Normal' })
--
--   -- KEEP HIGHLIGHTED: Strings (theme default)
--   -- @string.go - already highlighted by theme
--
--   -- KEEP HIGHLIGHTED: Constants (theme default)
--   -- @constant.go - already highlighted by theme
--   -- @constant.builtin.go - already highlighted by theme
--   -- @boolean.go - already highlighted by theme
--
--   -- KEEP HIGHLIGHTED: Numbers (theme default)
--   -- @number.go - already highlighted by theme
--
--   -- KEEP HIGHLIGHTED: Top-level function definitions (theme default)
--   -- @function.go - already highlighted by theme
--
--   -- KEEP HIGHLIGHTED: Comments - make them prominent (bold, visible color)
--   -- Instead of dim grey, comments should stand out
--   local comment_color = vim.api.nvim_get_hl(0, { name = 'Comment' })
--   if comment_color then
--     vim.api.nvim_set_hl(0, '@comment.go', {
--       fg = comment_color.fg or '#e0af68', -- fallback to yellow if not set
--       bold = true,
--       italic = false
--     })
--   end
--
--   -- OPTIONAL: Dim punctuation slightly (makes names stand out more)
--   vim.api.nvim_set_hl(0, '@punctuation.bracket.go', { fg = '#565f89' }) -- subtle dim
--   vim.api.nvim_set_hl(0, '@punctuation.delimiter.go', { fg = '#565f89' })
-- end
--
-- -- Apply minimal highlighting
-- setup_minimal_highlighting()
