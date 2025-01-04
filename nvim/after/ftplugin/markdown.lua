local function is_mac()
  -- Vim’s 'has("macunix")' is usually true for macOS
  return (vim.fn.has("macunix") == 1)
end

local function is_win()
  -- 'win32' or 'win64' typically both show up as true for 'has("win32")'
  return (vim.fn.has("win32") == 1)
end

local function is_wsl()
  local uname = vim.fn.systemlist("uname -r")[1] or ""
  return uname:find("WSL") ~= nil
end

vim.keymap.set("n", "<leader>co", function()
  local file_path = vim.fn.expand("%:p") -- Full path of current buffer
  if file_path == "" then
    vim.notify("No file recognized!", vim.log.levels.ERROR)
    return
  end

  -- Use only the filename
  local obsidian_url = "obsidian://open?vault=iferdel&file="
      .. vim.fn.fnamemodify(file_path, ":t")

  if is_mac() then
    -- macOS can open obsidian:// directly
    vim.ui.open(obsidian_url)
  elseif is_wsl() then
    -- Under WSL, call powershell.exe to bypass the browser
    vim.fn.system({
      "powershell.exe",
      "-NoProfile",
      "-ExecutionPolicy", "Bypass",
      "-Command", "Start-Process '" .. obsidian_url .. "'"
    })
  elseif is_win() then
    -- On normal Windows, cmd /C start ...
    vim.fn.system("cmd.exe /C start " .. obsidian_url)
  else
    -- Some other OS fallback
    vim.notify("OS not supported or could not be detected.", vim.log.levels.ERROR)
  end
end, { desc = "Open in Obsidian", noremap = true, silent = true })
