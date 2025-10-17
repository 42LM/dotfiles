-- DIAGNOSTICS
vim.diagnostic.config({
  float = {
    source = true, -- Always show the diagnostic source
    -- border = 'single', -- Optional: adds a border to the window set in init.lua
  },
  jump = {
    on_jump = function(diagnostic, bufnr, lnum, col)
      -- Small delay to ensure we're at the new position before opening float
      vim.schedule(function()
        vim.diagnostic.open_float()
      end)
    end,
  },
})

-- ONLY NEEDED WHEN NOT USING BLINK {{{
-- Experimental setup using native neovim completion
-- this limits to only being able to use ONE source for the completion list
-- CTRL+n is for regular text and CTRL+space is for LSP
vim.cmd[[set completeopt+=menuone,noselect]]
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = true,
        convert = function(item)
          return {
            abbr = item.label:gsub('%b()', ''),
            menu = '', -- this deactivates displaying the function structure in the completion menu
        }
        end,
      })
    end

    -- Map Enter (<CR>) to select the completion item (like Ctrl-Y)
    -- This expression map checks if the completion menu is visible (pumvisible())
    -- and if so, sends <C-y> (select item), otherwise it sends a normal <CR> (new line).
    vim.cmd(
      'inoremap <buffer> <expr> <CR> pumvisible() ? "\\<C-y>" : "\\<CR>"'
    )

    -- Use CTRL-space to trigger LSP completion.
    vim.keymap.set('i', '<c-space>', function()
      vim.lsp.completion.get()
    end)

    -- Use TAB and SHIFT+TAB for moving in completion menu
    vim.keymap.set('i', '<Tab>', function()
      return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
    end, { expr = true, silent = true, desc = "Next Completion or Tab" })
    vim.keymap.set('i', '<S-Tab>', function()
      return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
    end, { expr = true, silent = true, desc = "Previous Completion or Shift-Tab" })

  end,
})

-- 🚨 HACKY
-- Set border for the additional info of a completion list item
vim.api.nvim_create_autocmd('CompleteChanged', {

  callback = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local config = vim.api.nvim_win_get_config(win)
      if config.relative ~= '' then
        local buf = vim.api.nvim_win_get_buf(win)
        local buf_name = vim.api.nvim_buf_get_name(buf)
        local buftype = vim.api.nvim_get_option_value('buftype', { buf = buf })

        -- Only apply border to completion info window
        if buf_name == '' and buftype == 'nofile' then
          pcall(vim.api.nvim_win_set_config, win, {
            relative = config.relative,
            win = config.win,
            anchor = config.anchor,
            width = config.width,
            height = config.height,
            row = config.row,
            col = config.col,
            border = vim.o.winborder, -- vim.o.winborder is set in init.lua
          })
        end
      end
    end
  end,
})
-- }}}

-- ensure trailing whitespace is removed on every save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("LspFormatRust", { clear = true }),
  pattern = "*", -- Apply this to all files, or use "*.rs" to limit it
  callback = function()
    -- :%s/\s\+$//e
    -- %: operate on all lines
    -- s: substitute
    -- \s\+: one or more whitespace characters (space or tab)
    -- $: at the end of the line
    -- //: replace with nothing
    -- e: suppress "Pattern not found" error if no trailing spaces exist
    vim.cmd [[%s/\s\+$//e]]
  end,
})

-- RUST
vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      check = {
          command = "clippy",
      },
    },
  },
})
vim.lsp.enable('rust_analyzer')

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    local clients = vim.lsp.get_clients({ bufnr = 0, name = "rust_analyzer" })
    if #clients > 0 then
      vim.lsp.buf.format({ async = false })
    end
  end
})

-- GO
-- TODO: Get staticcheck and gofumpt to work!!!
-- https://go.dev/gopls/editor/vim#neovim-config
vim.lsp.config('gopls', {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})
vim.lsp.enable('gopls')

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})
