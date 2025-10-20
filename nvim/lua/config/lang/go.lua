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
