require("config.lazy")

vim.opt.shiftwidth = 4            -- indentation
vim.opt.clipboard = "unnamedplus" -- paste whatever is in the clipboard buffer globally
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 5         -- not too much since it generates a strange feeling to the eye

-- workaround for https://github.com/neovim/neovim/issues/31675 Treesitter situation
vim.hl = vim.highlight

-- changes the higlight (color) of the function.builtin. Lookable at Inspect and treesitter queries for each language it could work with either global function.builtin or locally to lua (special case for nvim) function.builtin.lua
vim.cmd [[ hi @function.builtin.lua guifg=yellow ]]

-- adds a line to show separation between windows
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#ffffff' })

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>", { desc = "execute whole file" })
vim.keymap.set("n", "<space>x", ":.lua<CR>", { desc = "execute current line" })
vim.keymap.set("v", "<space>x", ":lua<CR>", { desc = "execute selected section" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down while maintaining the center of the screen" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up while maintaining the center of the screen" })
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>zz", { desc = "while in quickfix, move down to next item" })
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>zz", { desc = "while in quickfix, move up to next item" })
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "in terminal mode, move from insert to normal mode" })


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
end, { desc = "Open bottom terminal" })

-- Go utilities menu with which-key detection
local has_which_key = pcall(require, 'which-key')

if has_which_key then
  -- Use sub-keymaps that which-key will show as a menu
  vim.keymap.set("n", "<space>gos", function()
    local go_root = vim.fn.system("go env GOROOT"):gsub("\n", "")
    local opts = require('telescope.themes').get_ivy({
      cwd = go_root .. "/src",
      find_command = { "find", ".", "-name", "*.go", "-type", "f" },
      prompt_title = "Go Source Code",
    })
    require('telescope.builtin').find_files(opts)
  end, { desc = "Source code (stdlib)" })

  vim.keymap.set("n", "<space>gom", function()
    local go_path = vim.fn.system("go env GOPATH"):gsub("\n", "")
    local opts = require('telescope.themes').get_ivy({
      cwd = go_path .. "/pkg/mod",
      find_command = { "find", ".", "-name", "*.go", "-type", "f" },
      prompt_title = "Go Modules",
    })
    require('telescope.builtin').find_files(opts)
  end, { desc = "Modules (GOPATH)" })

  vim.keymap.set('n', '<space>goc', function()
    vim.fn.jobstart({ "xdg-open", "https://go-cookbook.com/snippets" })
  end, { desc = "Cookbook (browser)" })
else
  -- Fallback to vim.ui.select when which-key is not available
  vim.keymap.set("n", "<space>go", function()
    local go_actions = {
      { name = "Go Source Code (stdlib)",  action = "source" },
      { name = "Go Modules (GOPATH)",      action = "modules" },
      { name = "Go Cookbook (browser)",    action = "cookbook" },
    }

    vim.ui.select(go_actions, {
      prompt = "Go Utilities:",
      format_item = function(item)
        return item.name
      end,
    }, function(choice)
      if not choice then return end

      if choice.action == "source" then
        -- Go source code navigation
        local go_root = vim.fn.system("go env GOROOT"):gsub("\n", "")
        local opts = require('telescope.themes').get_ivy({
          cwd = go_root .. "/src",
          find_command = { "find", ".", "-name", "*.go", "-type", "f" },
          prompt_title = "Go Source Code",
        })
        require('telescope.builtin').find_files(opts)
      elseif choice.action == "modules" then
        -- Go modules navigation
        local go_path = vim.fn.system("go env GOPATH"):gsub("\n", "")
        local opts = require('telescope.themes').get_ivy({
          cwd = go_path .. "/pkg/mod",
          find_command = { "find", ".", "-name", "*.go", "-type", "f" },
          prompt_title = "Go Modules",
        })
        require('telescope.builtin').find_files(opts)
      elseif choice.action == "cookbook" then
        -- Go Cookbook
        vim.fn.jobstart({ "xdg-open", "https://go-cookbook.com/snippets" })
      end
    end)
  end, { desc = "Go utilities" })
end
