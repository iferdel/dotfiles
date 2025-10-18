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
          require("harpoon"):list():add()
        end,
        desc = "Add file to Harpoon"
      },

      -- Toggle the Harpoon quick menu
      {
        "<C-e>",
        function()
          require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
        end,
        desc = "Harpoon quick menu"
      },

      -- Jump to file #1
      {
        "<C-1>",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "Harpoon to file 1"
      },
      -- Jump to file #2
      {
        "<C-2>",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "Harpoon to file 2"
      },
      {
        "<C-3>",
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "Harpoon to file 3"
      },
      {
        "<C-4>",
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "Harpoon to file 4"
      },
      {
        "<C-5>",
        function()
          require("harpoon"):list():select(5)
        end,
        desc = "Harpoon to file 5"
      },
    },
  },
}
