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
        "haskell",
        "rust",
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
        "nix",
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

  { 'junegunn/goyo.vim' },
  { 'junegunn/limelight.vim' },
  { 'preservim/vim-pencil' }
}
