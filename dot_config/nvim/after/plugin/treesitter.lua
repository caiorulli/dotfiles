require'nvim-treesitter.configs'.setup {
    ensure_installed = { "go", "rust", "clojure", "c", "java", "javascript", "lua", "vim", "help" },
    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
