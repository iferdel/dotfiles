return {
  {
    "folke/noice.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "emsg",
            find = "E162",
          },
          opts = { skip = true },
        },
        -- Skip yank messages
        {
          filter = {
            event = "msg_show",
            find = "%d+ lines yanked",
          },
          opts = { skip = true },
        },
        -- Skip "more lines" and "fewer lines" messages
        {
          filter = {
            event = "msg_show",
            find = "%d+ more lines",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "msg_show",
            find = "%d+ fewer lines",
          },
          opts = { skip = true },
        },
        -- Skip "lines indented" messages
        {
          filter = {
            event = "msg_show",
            find = "%d+ lines indented",
          },
          opts = { skip = true },
        },
        -- Skip written messages
        {
          filter = {
            event = "msg_show",
            find = "written",
          },
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
}
