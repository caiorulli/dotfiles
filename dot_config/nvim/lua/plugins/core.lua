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
                "bash",
                "html",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "vim",
                "yaml",
                "go",
                "rust",
                "clojure",
                "haskell",
                "java",
                "python",
            },
        },
    },

    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "gopls",
                "delve",
            },
        },
    },
}
