local set = vim.opt_local

vim.opt.wrap = true

set.shiftwidth = 2
set.tabstop = 2
set.number = true
set.relativenumber = true

local md = require("config.os.detection")

vim.keymap.set("n", "<leader>co", function()
  local file_path = vim.fn.expand("%:p") -- Full path of current buffer
  if file_path == "" then
    vim.notify("No file recognized!", vim.log.levels.ERROR)
    return
  end

  -- Use only the filename
  local obsidian_url = "obsidian://open?vault=iferdel&file="
      .. vim.fn.fnamemodify(file_path, ":t")

  if md.is_mac() then
    -- macOS can open obsidian:// directly
    vim.ui.open(obsidian_url)
  elseif md.is_wsl() then
    -- Under WSL, call powershell.exe to bypass the browser
    vim.fn.system({
      "powershell.exe",
      "-NoProfile",
      "-ExecutionPolicy", "Bypass",
      "-Command", "Start-Process '" .. obsidian_url .. "'"
    })
  elseif md.is_win() then
    -- On normal Windows, cmd /C start ...
    vim.fn.system("cmd.exe /C start " .. obsidian_url)
  else
    -- Some other OS fallback
    vim.notify("OS not supported or could not be detected.", vim.log.levels.ERROR)
  end
end, { desc = "Open in Obsidian", noremap = true, silent = true })

return M
