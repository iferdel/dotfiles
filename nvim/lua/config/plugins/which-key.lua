return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    enabled = true,
    config = function()
      local wk = require("which-key")

      wk.setup({
        preset = "modern",
        delay = 1500, -- delay before showing which-key popup (ms)
        icons = {
          mappings = true,
        },
        win = {
          border = "rounded",
        },
      })

      -- Optional: Add manual trigger to show all keymaps
      vim.keymap.set("n", "<space>?", function()
        require("which-key").show({ global = false })
      end, { desc = "Show all keymaps" })
    end,
  },
}
