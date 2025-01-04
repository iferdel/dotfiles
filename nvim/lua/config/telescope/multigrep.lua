local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local conf = require "telescope.config".values
local md = require "config.os.detection"

local M = {}

local live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local pieces = vim.split(prompt, "  ")
      local args = { 'rg' } -- uses ripgrep
      if pieces[1] then     -- first piece is what we are looking for (content)
        table.insert(args, "-e")
        table.insert(args, pieces[1])
      end

      if pieces[2] then -- second piece is the file match and is the one after the double space in vim.split(prompt, "  ")
        table.insert(args, "-g")
        table.insert(args, pieces[2])
      end

      ---@diagnostic disable-next-line: deprecated -- automated with 'gra' shortcut in normal mode (lsp)
      return vim.tbl_flatten {
        args,
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
        opts.ignore_obsidian_files,
      }
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  pickers.new(opts, {
    debounce = 100, -- gives time to avoid instant search
    prompt_title = "Multi Grep",
    finder = finder,
    previewer = conf.grep_previewer(opts),
    sorter = require("telescope.sorters").empty(), -- do not sort it since it'll be sorted by rg
  }):find()
end

M.setup = function()
  vim.keymap.set("n", "<space>fg", live_multigrep)
  vim.keymap.set("n", "<space>fo", function() -- obsidian vault
    local vault_path
    if md.is_mac() then
      vault_path = "~/Documents/ifd/iferdel/" -- dependant, maybe a better way to setup
    elseif md.is_wsl() then
      vault_path = "/mnt/c/Obsidian/iferdel/" -- dependant, maybe a better way to setup
    end
    live_multigrep({
      cwd = vault_path,
      ignore_obsidian_files = { "--glob=!excalidraw" }, -- no need to search for excalidraw files
    })
  end
  )
end

return M
