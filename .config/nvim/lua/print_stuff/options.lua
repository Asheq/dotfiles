local M = {}

local function extract_optname(line)
  line = vim.trim(line or "")
  if line == "" then
    return ""
  end

  if line:find("=") then
    return line:match("^[^=]*") or ""
  end

  if vim.fn.exists("&" .. line) == 1 then
    return line
  end

  if line:sub(1, 2) == "no" and vim.fn.exists("&" .. line:sub(3)) == 1 then
    return line:sub(3)
  end

  if line:sub(1, 3) == "inv" and vim.fn.exists("&" .. line:sub(4)) == 1 then
    return line:sub(4)
  end

  return ""
end

local function nondefault_option_set()
  local lines = vim.split(vim.fn.execute("silent set!"), "\n")
  local nondefault = {}

  for _, line in ipairs(lines) do
    local optname = extract_optname(line)
    if optname ~= "" then
      nondefault[optname] = true
    end
  end

  return nondefault
end

local function last_set(option)
  local full_value = vim.fn.execute("silent verbose set " .. option .. "?")
  local start_idx = full_value:find("Last set from ", 1, true)

  if not start_idx then
    return ""
  end

  local file = full_value:sub(start_idx + #"Last set from ")
  file = file:gsub("line %d+$", "")
  return vim.trim(file)
end

local function echo_line(chunks)
  vim.api.nvim_echo(chunks, true, {})
end

local function print_option_groups(groups)
  local nondefault = nondefault_option_set()

  local all_opt_names = {}
  for _, group in ipairs(groups) do
    for _, name in ipairs(group.options) do
      table.insert(all_opt_names, name)
    end
  end

  local max_opt_name_len = 0
  for _, name in ipairs(all_opt_names) do
    if #name > max_opt_name_len then
      max_opt_name_len = #name
    end
  end

  for _, group in ipairs(groups) do
    if group.title and group.title ~= "" then
      echo_line({ { group.title, "Underlined" } })
    end

    for _, optname in ipairs(group.options) do
      local label = optname
      local value = vim.api.nvim_get_option_value(optname, {})
      local last = last_set(optname)
      local label_hi = nondefault[optname] and "DiagnosticError" or "Normal"

      local chunks = {
        { string.rep(" ", max_opt_name_len - #label + 4), "Normal" },
        { label .. ": ", label_hi },
        { tostring(value), "Normal" },
      }

      if last ~= "" then
        table.insert(chunks, { " -> ", "NonText" })

        local runtime_path = vim.env.VIMRUNTIME or ""
        local config_path_abs = vim.fn.stdpath("config")
        local config_path_short = vim.fn.fnamemodify(config_path_abs, ":~")

        if runtime_path ~= "" and last:sub(1, #runtime_path) == runtime_path then
          local tail = last:gsub(vim.pesc(runtime_path) .. "/", "", 1)
          table.insert(chunks, { "$VIMRUNTIME/", "Function" })
          table.insert(chunks, { tail, "NonText" })
        elseif last:sub(1, #config_path_abs) == config_path_abs then
          local tail = last:gsub(vim.pesc(config_path_abs) .. "/", "", 1)
          table.insert(chunks, { config_path_short .. "/", "String" })
          table.insert(chunks, { tail, "NonText" })
        elseif config_path_short ~= "" and last:sub(1, #config_path_short) == config_path_short then
          local tail = last:gsub(vim.pesc(config_path_short) .. "/", "", 1)
          table.insert(chunks, { config_path_short .. "/", "String" })
          table.insert(chunks, { tail, "NonText" })
        else
          table.insert(chunks, { last, "NonText" })
        end
      end

      echo_line(chunks)
    end
  end
end

function M.print_updated()
  local lines = vim.split(vim.fn.execute("silent set!"), "\n")
  local seen = {}
  local options = {}

  for _, line in ipairs(lines) do
    local optname = extract_optname(line)
    if optname ~= "" and not seen[optname] then
      seen[optname] = true
      table.insert(options, optname)
    end
  end

  table.sort(options)

  print_option_groups({
    {
      title = "Non-default options",
      options = options,
    },
  })
end

function M.print_general()
  print_option_groups({
    {
      title = "Filetype",
      options = {
        "filetype",
      },
    },
    {
      title = "Encoding and format",
      options = {
        "fileencoding",
        "fileformat",
      },
    },
    {
      title = "Comments",
      options = {
        "comments",
        "commentstring",
      },
    },
    {
      title = "UI",
      options = {
        "tabline",
        "statusline",
        "winbar",
      },
    },
  })
end

function M.print_formatting()
  print_option_groups({
    {
      title = "Formatting methods for gq/gw operator (ascending priority)",
      options = {
        "formatprg",
        "formatexpr",
      },
    },
    {
      title = "For internal formatting",
      options = {
        "textwidth",
        "formatoptions",
        "formatlistpat",
      },
    },
  })
end

function M.print_indenting()
  print_option_groups({
    {
      title = "Tabs",
      options = {
        "expandtab",
        "tabstop",
        "shiftwidth",
        "smarttab",
        "softtabstop",
        "copyindent",
        "preserveindent",
      },
    },
    {
      title = "Indenting methods (ascending priority)",
      options = {
        "autoindent",
        "smartindent",
        "cindent",
        "indentexpr",
      },
    },
    {
      title = "For cindent",
      options = {
        "cinoptions",
        "cinkeys",
        "cinwords",
      },
    },
    {
      title = "For indentexpr",
      options = {
        "indentkeys",
      },
    },
  })
end

function M.print_folding()
  print_option_groups({
    {
      title = "Basic",
      options = {
        "foldenable",
        "foldlevelstart",
        "foldlevel",
        "foldmethod",
        "foldexpr",
        "foldmarker",
      },
    },
    {
      title = "Other",
      options = {
        "foldtext",
        "foldopen",
        "foldclose",
        "foldcolumn",
        "foldignore",
        "foldminlines",
        "foldnestmax",
      },
    },
  })
end

return M
