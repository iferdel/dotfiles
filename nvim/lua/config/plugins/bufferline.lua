return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "echasnovski/mini.icons" },
    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup({
        options = {
          mode = "tabs", -- show tabs, not buffers
          separator_style = "slant",
          always_show_bufferline = false,
          name_formatter = function(buf)
            local name = buf.name or ""
            if name:match("^term://") then
              local cmd = name:match("([^/]+)$") or "term"
              return "term:" .. cmd
            end
            return name
          end,
          show_buffer_close_icons = false,
          show_close_icon = false,
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          offsets = {
            {
              filetype = "oil",
              text = "File Explorer",
              highlight = "Directory",
              separator = true,
            },
            {
              filetype = "dbee",
              text = "Database",
              highlight = "Directory",
              separator = true,
            },
          },
        },
      })
    end,
  },
}
