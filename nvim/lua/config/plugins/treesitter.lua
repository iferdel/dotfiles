return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- diagnostics = { disable = {'ignore_fields' } },
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = {
          "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",                                                                                -- default
          "python", "go", "asm", "bash", "bicep", "css", "dockerfile", "groovy", "helm", "html", "json", "nginx", "sql", "terraform", "toml", "yaml", "html", -- custom
        },
        sync_install = false,
        auto_install = false,
        highlight = {
          enable = true,
          -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      enable = true,
      max_lines = 3,            -- cap sticky context at 3 rows
      min_window_height = 20,   -- skip it in short splits
      line_numbers = true,      -- show source line numbers on the sticky rows
      multiwindow = false,
      mode = "cursor",          -- context follows the cursor
      trim_scope = "outer",     -- when over max_lines, drop the outermost scope
      separator = "─",          -- thin underline below the context block
    },
  },
}
