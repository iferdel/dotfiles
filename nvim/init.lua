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
vim.keymap.set("n", "-", "<cmd>Oil<CR>")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('hightlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('TermOpen',
  { -- customized terminal just like one would do with a file from certain language or extension
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
      vim.opt.number = false
      vim.opt.relativenumber = false
    end,
  })

local job_id = 0
vim.keymap.set("n", "<space>st", function() -- opens a new terminal at the botton (removable by simply <C-d>)
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 10)

  job_id = vim.b.terminal_job_id
end)

vim.keymap.set("n", "<space>gotest", function()
  vim.fn.chansend(job_id, { "go test ./...\r\n" })
end)
