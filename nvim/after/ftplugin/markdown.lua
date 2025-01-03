local set = vim.opt_local

set.number = true
set.relativenumber = true

vim.keymap.set("n", "<leader>co", function()
  local file_path = vim.fn.expand("%:p") -- Get the full file path of the current buffer
  if file_path and file_path ~= "" then
    local obsidian_url = "obsidian://open?vault=iferdel&file=" ..
        vim.fn.fnamemodify(file_path, ":t") -- Use the file name only
    vim.ui.open(obsidian_url)
  else
    vim.notify("No file is currently open or recognized!", vim.log.levels.ERROR)
  end
end, { desc = "Open in Obsidian", noremap = true, silent = true })
