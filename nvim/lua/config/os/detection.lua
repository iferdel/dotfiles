M = {}

function M.is_mac()
  -- Vim’s 'has("macunix")' is usually true for macOS
  return (vim.fn.has("macunix") == 1)
end

function M.is_win()
  -- 'win32' or 'win64' typically both show up as true for 'has("win32")'
  return (vim.fn.has("win32") == 1)
end

function M.is_wsl()
  local uname = vim.fn.systemlist("uname -r")[1] or ""
  return uname:find("WSL") ~= nil
end

function M.is_linux()
  -- Native Linux (not WSL, not macOS)
  return (vim.fn.has("unix") == 1 and vim.fn.has("macunix") == 0 and not M.is_wsl())
end

return M
