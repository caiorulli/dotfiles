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
                "go",
                "java",
                "python",
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
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "gopls",
            },
        },
    },
}
