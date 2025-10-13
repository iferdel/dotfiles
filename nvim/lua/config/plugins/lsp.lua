return {
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    dependencies = {
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files since lazydev is intended to be used only for lua to configure lsp for lua with vim
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Configure LSP servers using Neovim 0.11+ native API
      -- Set default capabilities for all servers
      vim.lsp.config['*'] = {
        capabilities = capabilities,
      }

      -- Lua Language Server
      vim.lsp.config.lua_ls = {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
        capabilities = capabilities,
      }

      -- Go Language Server
      vim.lsp.config.gopls = {
        cmd = { 'gopls' },
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_markers = { 'go.work', 'go.mod', '.git' },
        capabilities = capabilities,
      }

      -- Python Language Server
      vim.lsp.config.pylsp = {
        cmd = { 'pylsp' },
        filetypes = { 'python' },
        root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
        capabilities = capabilities,
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = {
                ignore = { "E203", "E501" },
                maxLineLength = 100,
              },
              pyflakes    = { enabled = false },
              mccabe      = { enabled = false },
            },
          },
        },
      }

      -- C/C++ Language Server
      vim.lsp.config.ccls = {
        cmd = { 'ccls' },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
        root_markers = { 'compile_commands.json', '.ccls', '.git' },
        capabilities = capabilities,
        init_options = {
          compilationDatabaseDirectory = "build",
        },
      }

      -- Docker Language Server
      vim.lsp.config.dockerls = {
        cmd = { "docker-langserver", "--stdio" },
        filetypes = { "dockerfile" },
        root_markers = { "Dockerfile", ".git" },
        capabilities = capabilities,
      }

      -- Enable LSP servers for matching filetypes
      vim.lsp.enable({ 'lua_ls', 'gopls', 'pylsp', 'ccls', 'dockerls' })

      vim.keymap.set("i", "<C-o>", vim.lsp.buf.signature_help)

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client:supports_method('textDocument/formatting') then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                vim.lsp.buf.code_action { context = { only = { 'source.organizeImports' } }, apply = true }
              end,
            })
          end
        end,
      })

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        severity_sort = true,
        update_in_insert = false,

        float = {
          show_header = true,
          border = "rounded",
          source = "always",
        },
      })
    end,
  }
}
