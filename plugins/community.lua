local utils = require "astronvim.utils"

return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.bash" },
  -- { import = "astrocommunity.pack.cpp", enabled = false },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.lua", enabled = false },
  { import = "astrocommunity.editing-support.zen-mode-nvim" },
  { import = "astrocommunity.bars-and-lines.lualine-nvim" },
  { import = "astrocommunity.code-runner.sniprun" },
}
