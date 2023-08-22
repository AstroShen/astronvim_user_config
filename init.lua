local config = {
  highlights = {
    init = {
      WinSeparator = { fg = "#6C6C6C" },
    },
  },
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = false,
    update_in_insert = false,
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
      "clangd",
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
  polish = function() require "user.autocmds" end,
}

return config
