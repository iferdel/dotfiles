return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    enabled = true,

    config = function()
      require("harpoon").setup({})
      -- or pass your own config if needed, e.g.:
      -- require("harpoon").setup({
      --   menu = { width = 80 },
      -- })
    end,

    keys = {
      -- Add file
      {
        "<leader>a",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Add file to Harpoon"
      },

      -- Toggle the Harpoon quick menu
      {
        "<C-e>",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Harpoon quick menu"
      },

      -- Jump to file #1
      {
        "<C-1>",
        function()
          require("harpoon.ui").nav_file(1)
        end,
        desc = "Harpoon to file 1"
      },
      -- Jump to file #2
      {
        "<C-2>",
        function()
          require("harpoon.ui").nav_file(2)
        end,
        desc = "Harpoon to file 2"
      },
      {
        "<C-3>",
        function()
          require("harpoon.ui").nav_file(3)
        end,
        desc = "Harpoon to file 3"
      },
      {
        "<C-4>",
        function()
          require("harpoon.ui").nav_file(4)
        end,
        desc = "Harpoon to file 4"
      },
      {
        "<C-5>",
        function()
          require("harpoon.ui").nav_file(5)
        end,
        desc = "Harpoon to file 5"
      },
    },
  },
}
