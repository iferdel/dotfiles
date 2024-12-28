require("config.lazy")

vim.opt.shiftwidth = 4            -- indentation
vim.opt.clipboard = "unnamedplus" -- paste whatever is in the clipboard buffer globally
vim.opt.scrolloff = 8

-- workaround for https://github.com/neovim/neovim/issues/31675 Treesitter situation
vim.hl = vim.highlight

-- changes the higlight (color) of the function.builtin. Lookable at Inspect and treesitter queries for each language it could work with either global function.builtin or locally to lua (special case for nvim) function.builtin.lua
vim.cmd [[ hi @function.builtin.lua guifg=yellow ]]

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
vim.keymap.set("n", "<space>pv", vim.cmd.Ex)
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('hightlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
