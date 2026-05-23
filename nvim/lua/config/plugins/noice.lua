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
        signature = { enabled = false }, -- defer to blink.cmp's signature window
        hover = { enabled = true },
        progress = {
          enabled = true,
          view = "mini",                 -- gopls / pylsp indexing in bottom-right mini view
        },
      },
      messages = {
        enabled = true,
        view = "mini",                   -- routine messages: calm bottom-right strip
        view_error = "notify",           -- errors still pop as notifications
        view_warn = "notify",            -- warnings too
        view_history = "messages",
        view_search = "virtualtext",     -- search count next to cursor, not cmdline
      },
      routes = {
        -- One collapsed route for routine line/yank/write/E162 noise
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+ lines yanked" },
              { find = "%d+ more lines" },
              { find = "%d+ fewer lines" },
              { find = "%d+ lines indented" },
              { find = "written" },
              { kind = "emsg", find = "E162" },
            },
          },
          opts = { skip = true },
        },
      },
      views = {
        cmdline_popup = {
          position = { row = "50%", col = "50%" }, -- true vertical+horizontal center
          size = { width = 60, height = "auto" },
          border = { style = "rounded" },
        },
        popupmenu = {
          border = { style = "rounded" },
        },
        mini = {
          win_options = { winblend = 0 }, -- fully opaque mini view, readable text
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,           -- combined cmdline + popupmenu float
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
