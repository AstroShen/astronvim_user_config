local config = {
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally allow_filetypes = { -- enable format on save for specified filetypes only
      },
      ignore_filetypes = { -- disable format on save for specified filetypes
        -- "python",
      },
    },
    config = {
      clangd = {
        capabilities = {
          offsetEncoding = "utf-8",
        },
      },
    },
    disabled = { -- disable formatting capabilities for the listed language servers
      -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
      -- "lua_ls",
    },
    timeout_ms = 1000, -- default format timeout
    -- filter = function(client) -- fully override the default formatting function
    --   return true
    -- end
    -- enable servers that you already have installed without mason
    servers = {
      "clangd"
    },
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
    change_detection = {
      -- automatically check for config file changes and reload the ui
      enabled = true,
      notify = true, -- get a notification when changes are found
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
    --
    -- Set up autocommands
    local create_autocmd = vim.api.nvim_create_autocmd

    Au_group = {
      cpp = vim.api.nvim_create_augroup("cpp_group", { clear = true }),
      python = vim.api.nvim_create_augroup("python_group", { clear = true }),
      general = vim.api.nvim_create_augroup("general", { clear = true }),
      makePrg = vim.api.nvim_create_augroup("makePrg", { clear = true }),
    }

    local definitions = {
      {
        'BufEnter',
        {
          pattern = "*.cpp",
          command = "setlocal makeprg=g++\\ -std=c++20\\ -g\\ -Wall\\ %:p\\ -o\\ %:p:r",
          group = Au_group.makePrg,
          desc = "make cpp programs"
        }
      },
      {
        { "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" },
        {
          command = "if mode() != 'c' | checktime | endif",
          pattern = { "*" },
          desc = "make autoread take effect"
        }
      },
      {
        'BufEnter',
        {
          pattern = { "*.py", "*.sh", "*.csh", "*.pl", "*.lua" },
          command = "setlocal makeprg=%:p",
          group = Au_group.makePrg,
          desc = "run scripts programs"
        }
      },
      {
        "BufReadPost",
        {
          command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]],
          group = Au_group.general,
          desc = "Restore the cursor position when opening a file",
        }
      },
      {
        'QuickFixCmdPost',
        {
          pattern = "[^l]*",
          nested = true,
          command = "botright copen",
          group = Au_group.general,
          desc = "automatically open quickfix window",
        }
      },
      {
        'QuickFixCmdPost',
        {
          pattern = "l*",
          nested = true,
          command = "lwindow",
          group = Au_group.general,
          desc = "automatically open quickfix window",
        }
      },
      {
        'BufWritePost',
        {
          pattern = { "*.py", "*.pl", "*.csh", "*.tcsh", "*.sh" },
          callback = function()
            local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, true)[1]
            if string.match(first_line, "^#!") then
              vim.api.nvim_command("silent !chmod +x <afile>")
            end
          end,
          group = Au_group.general,
          desc = "add execution rights to script files such as *sh, *.py, etc after :w",
        }
      },
      {
        "Filetype",
        {
          pattern = { "c", "cpp" },
          command = "setlocal tabstop=2 shiftwidth=2",
          group = Au_group.cpp,
        }
      },
      {
        "Filetype",
        {
          pattern = "python",
          command = "setlocal tabstop=4 shiftwidth=4",
          group = Au_group.python,
        }
      },
      {
        'TextYankPost',
        {
          pattern = '*',
          callback = function() vim.highlight.on_yank { timeout = 500 } end,
          group = Au_group.general,
          desc = "highlight yanks",
        }
      },
      {
        'BufWritePre',
        {
          pattern = '*',
          command = 'call mkdir(expand("<afile>:p:h"), "p")',
          group = Au_group.general,
          desc = "create non-exist directory when saving files",
        }
      },
      {
        'User',
        {
          pattern = 'AsyncRunStop',
          command = 'bot copen',
          group = Au_group.general,
          desc = "create non-exist directory when saving files",
        }
      },
    }

    for _, entry in ipairs(definitions) do
      local event = entry[1]
      local opts = entry[2]
      if type(opts.group) == "string" and opts.group ~= "" then
        local exists, _ = pcall(vim.api.nvim_get_autocmds, { group = opts.group })
        if not exists then
          vim.api.nvim_create_augroup(opts.group, {})
        end
      end
      vim.api.nvim_create_autocmd(event, opts)
    end
  end
}

return config
