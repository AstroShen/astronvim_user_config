-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    [";"] = { ":", desc = "enter command mode" },
    ["qw"] = { "<C-w>q", desc = "close window" },
    ["<leader>w"] = { ":update<cr>", desc = "update file" },
    ["]c"] = { ":cnext<cr>", desc = "next quickfix item" },
    ["[c"] = { ":cprevious<cr>", desc = "previous quickfix item" },
    ["L"] = { ":bn<cr>", desc = "next buffer" },
    ["H"] = { ":bp<cr>", desc = "previous buffer" },
    ["<leader>s"] = { ":ClangdSwitchSourceHeader<cr>", desc = "siwtch source and header file" },
    ["leader>m"] = { ":AsyncRun -program=make<cr>", desc = "Run make program async" },
    ["<leader>M"] = { ":AsyncRun -program=make && %:p:r<cr>", desc = "Run make program and execute async" },
    ["gh"] = { ":help <c-r><c-w><cr>", desc = "help word under cursor" },
    ["<leader><leader>c"] = { ":lua generate_source_file()<cr>", desc = "create source file in cpp" },
  },

  i = {
    ["<c-e>"] = { "<end>", desc = "move to last of the line in insert mode" },
    ["<c-l>"] = { "<right>", desc = "move to next position in insert mode" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
