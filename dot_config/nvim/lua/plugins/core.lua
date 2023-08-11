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
                "gopls",
            },
        },
    },
}
