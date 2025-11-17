local function is_hugo_project()
  local config_files = { "hugo.toml", "hugo.yaml", "hugo.json" }
  for _, file in ipairs(config_files) do
    if vim.fn.glob(file) ~= "" then
      return true
    end
  end
  return false
end

local function get_archetypes()
  local kinds = {}
  local archetype_paths = {
    "archetypes/",
    "themes/*/archetypes/"
  }

  for _, path in ipairs(archetype_paths) do
    local files = vim.fn.glob(path .. "*.md", false, true)
    for _, file in ipairs(files) do
      local kind = vim.fn.fnamemodify(file, ":t:r")
      table.insert(kinds, kind)
    end
  end
  return kinds
end

local function get_content_completions(lead)
  local search_path = lead:match("^content/") and lead or "content/" .. lead
  local matches = vim.fn.glob("content/**/*", false, true)

  local completions = {}
  for _, match in ipairs(matches) do
    local display = match:gsub("^content/", "")
    if match:match("^" .. vim.pesc(search_path)) then
      if vim.fn.isdirectory(match) == 1 then
        display = display .. "/"
      end
      table.insert(completions, display)
    end
  end

  return completions
end

local function run_hugo_command(args)
  local cmd = "hugo " .. table.concat(args, " ")
  vim.cmd("!" .. cmd)
end

local function hugo_complete_arglead(lead, cmd_line, _)
  cmd_line = cmd_line:gsub("%s+", " ")

  local parts = vim.split(cmd_line, " ")

  local basic_subcommands = {
    "server",
    "new",
    "help",
    "version",
    "config",
  }

  if #parts <= 2 then
    return vim.tbl_filter(function(sub)
      return sub:match("^" .. vim.pesc(lead or ""))
    end, basic_subcommands)
  end

  if parts[2] == "new" then
    if #parts == 3 then
      return {"content"}
    end

    if parts[3] == "content" then
      -- If the previous part is -k or --kind
      if parts[#parts-1] == "-k" or parts[#parts-1] == "--kind" then
        return get_archetypes()
      end

      return get_content_completions(lead)
    end
  end

  return {}
end

if is_hugo_project() then
  -- Run Hugo commands from command mode
  vim.api.nvim_create_user_command('Hugo', function(opts)
    run_hugo_command(opts.fargs)
  end, {
    nargs = '*',
    complete = hugo_complete_arglead,
  })

  -- open note with standard naming
  vim.api.nvim_create_user_command('NewNote', function(opts)
    local filename = os.time() .. ".md"
    vim.fn.system("hugo new content " .. filename )
    vim.cmd('edit content/' .. filename )
  end, { nargs = "*" })

end
