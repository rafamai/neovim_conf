vim.opt.mouse = 'a'
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.expandtab = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.showmode = false
-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

vim.api.nvim_exec ([[
    augroup markdownSpell
        autocmd!
        autocmd FileType markdown setlocal spell spelllang=es
        autocmd BufRead,BufNewFile *.md setlocal spell spelllang=es
    augroup END
  ]], false)
