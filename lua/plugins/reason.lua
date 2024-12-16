return {
  -- Treesitter configuration with parser compilation
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Ensure these languages are installed
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ocaml" })
      end
    end,
    config = function(plugin, opts)
      -- Require treesitter configs
      require("nvim-treesitter.configs").setup(opts)

      -- Add custom parser for Reason
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.reason = {
        install_info = {
          url = "https://github.com/nkrkv/tree-sitter-reason",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "main",
        },
        filetype = "reason",
      }

      -- Set up filetype detection
      vim.filetype.add({
        extension = {
          re = "reason",
          rei = "reason",
        },
      })
    end,
  },

  -- LSP configuration for Reason
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ocamllsp = {
          filetypes = { "ocaml", "reason" },
          root_dir = require("lspconfig.util").root_pattern("bsconfig.json", "package.json", ".git"),
          settings = {
            codelens = { enable = true },
            extendedHover = { enable = true },
          },
        },
      },
    },
  },
}
