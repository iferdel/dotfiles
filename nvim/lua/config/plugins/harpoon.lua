return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    enabled = true,
    config = function()
      ---@diagnostic disable-next-line: missing-parameter
      require("harpoon"):setup()
    end,
    keys = {
      { "<leader>a", function() require("harpoon"):list():add() end,     desc = "harpoon file", },
      {
        "<C-e>",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "harpoon quick menu",
      },
      { "<C-1>",     function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
      { "<C-1>",     function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
      { "<C-1>",     function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
      { "<C-1>",     function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
      { "<C-1>",     function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5", },
    },
  },
}
