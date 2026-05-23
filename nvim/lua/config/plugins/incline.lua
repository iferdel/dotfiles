return {
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    config = function()
      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 1, vertical = 0 },
        },
        render = function(props)
          local bufname = vim.api.nvim_buf_get_name(props.buf)
          local filename = bufname == "" and "[No Name]" or vim.fn.fnamemodify(bufname, ":t")
          local icon, icon_hl = require("mini.icons").get("file", filename)
          local modified = vim.bo[props.buf].modified
          local result = {
            { icon .. " ", group = icon_hl },
            { filename,    gui = "bold" },
          }
          if modified then
            table.insert(result, { " ●", guifg = "#ff9e64" })
          end
          return result
        end,
      })
    end,
  },
}
