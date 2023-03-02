vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fs", vim.cmd.write)
vim.keymap.set("n", "<leader>qq", vim.cmd.quitall)
vim.keymap.set("n", "<leader>bk", vim.cmd.quit)
vim.keymap.set("n", "<leader>.", vim.cmd.Ex)

vim.keymap.set("n", "[b", vim.cmd.bprevious)
vim.keymap.set("n", "]b", vim.cmd.bnext)
