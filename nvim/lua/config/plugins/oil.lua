return {
  {
    'stevearc/oil.nvim',
    enabled = true,
    ---@module 'oil'
    ---@type oil.SetupOpts
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons

    config = function()
      require("oil").setup {
        view_options = {
          show_hidden = true,
        },

        keymaps = {
          ["<C-h>"] = false, -- deactivate C-h for splitting window with selected file in oil
          ["<M-h>"] = "actions.select_split",
        },
        -- Open parent directory in current window
        vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = 'Open parent directory' }),
        -- Open parent directory in floating window
        vim.keymap.set("n", "<space>-", require("oil").toggle_float),
      }
    end,

  },
}
