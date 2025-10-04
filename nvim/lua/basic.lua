-- GENERAL {{{
-- *****************************************************************************

vim.cmd("autocmd!")

-- use ripgrep
vim.o.grepprg = "rg --vimgrep --smart-case --follow"

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true

vim.opt.title = true
vim.opt.cursorline = true
vim.opt.clipboard:append { 'unnamedplus' } -- always save to clipboard
vim.opt.swapfile = false -- Do not use a swap file
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.backup = false
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }
vim.opt.autoindent = true -- new lines inherit the indentation of previous lines

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 300
vim.opt.hlsearch = true -- highlight search results

vim.opt.incsearch = true -- show search results as you type
vim.opt.ignorecase = true -- ignore case in search
vim.opt.smartcase = true -- auto switch search to case-sensitive when search query contains uppercase letters
vim.opt.showcmd = true -- highlight commands used at -- INSERT -- line


vim.opt.cmdheight = 1 -- height of -- INSERT -- line
vim.opt.laststatus = 2 -- always show statusline
vim.opt.scrolloff = 10 -- keep cursor centered vertically on screen
vim.opt.shell = 'zsh'
vim.opt.inccommand = 'split' -- show `%s/this/that/` in commandline
vim.opt.lazyredraw = true -- do not readraw when executing macros (good performance config)
vim.opt.smarttab = true -- be smart when using tabs :p
vim.opt.ai = true -- auto indent
vim.opt.si = true -- smart indent

-- XXX Wrap lines (for small screens)
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.list = false
-- or
-- vim.opt.nowrap = true
-- vim.opt.backspace = { 'start', 'eol', 'indent' }

vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*' }

-- *****************************************************************************
-- }}}

-- AUTOCMD {{{
-- *****************************************************************************

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = '*',
  command = 'set nopaste'
})

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }

-- when using go use different indentation
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  command = 'setlocal shiftwidth=8 tabstop=8'
})

-- handle *.gohtml files like html
-- DOES NOT WORK
-- vim.api.nvim_create_autocmd('BufNewFile,BufRead', {
--   pattern = '*.gohtml',
--   command = 'set filetype=html'
-- })
-- use oldschool vimscript instead
vim.cmd([[
  autocmd BufNewFile,BufRead *.gohtml set filetype=html
]])

-- *****************************************************************************
-- }}}

-- vim: set foldmethod=marker foldlevel=0:
