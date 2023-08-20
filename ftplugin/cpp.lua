function _G.generate_source_file()
  local bufnr = vim.api.nvim_get_current_buf()
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, line_count, false)
  local namespace_name = nil
  for _, line in ipairs(lines) do
    local match = string.match(line, "^namespace (.*) {")
    if match then
      namespace_name = match
      break
    end
  end

  local file_dir = vim.fn.expand('%:p:h:t')

  local source_path = nil
  if file_dir == "include" then
    source_path = vim.fn.expand('%:p:h:h') .. "/src/"
  elseif file_dir == "interface" then
    source_path = vim.fn.expand('%:p:h:h') .. "/private/"
  else
    source_path = vim.fn.expand('%:p:h') .. "/"
  end

  if vim.fn.isdirectory(source_path) == 0 then
    vim.fn.mkdir(source_path)
  end

  local source_file_path = source_path .. vim.fn.expand('%:t:r') .. ".cpp"

  if vim.fn.filereadable(source_file_path) == 1 then
    print(source_file_path .. " already exists, nothing happens.")
  else
    local source_file, err, code = io.open(source_file_path, "w")
    if source_file then
      source_file:write("#include \"" .. vim.fn.expand('%:t') .. "\"\n")
      if namespace_name then
        source_file:write("\nusing namespace " .. namespace_name .. ";")
      end
      source_file:close()
      print(source_file_path .. " created.")
    else
      print(err)
    end
  end
end
