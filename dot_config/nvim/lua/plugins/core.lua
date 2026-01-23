-- Refer for examples here: https://www.lazyvim.org/configuration/examples

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "javascript",
        "lua",
        "bash",
        "html",
        "json",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "vim",
        "yaml",
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- TypeScript/JavaScript ecosystem
        "typescript-language-server",
        "eslint-lsp",
        "prettier",
        -- JSON/YAML for configs
        "json-lsp",
        "yaml-language-server",
        -- Web development
        "html-lsp",
        "css-lsp",
        "emmet-ls",
        -- Docker for your containerized services
        "docker-compose-language-service",
        "dockerfile-language-server",
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fu",
        function()
          require("telescope.builtin").lsp_references()
        end,
        desc = "Find usages",
      },
      {
        "<leader>bi",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Pick buffer",
      },
    },
  },
}
