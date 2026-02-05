local function get_section_level(section_node)
  for child in section_node:iter_children() do
    if child:type() == "atx_heading" then
      for marker in child:iter_children() do
        local mtype = marker:type()
        local level = mtype:match("^atx_h(%d)_marker$")
        if level then
          return tonumber(level)
        end
      end
      -- Fallback: count # characters in the marker text
      local text = vim.treesitter.get_node_text(child, 0)
      local hashes = text:match("^(#+)")
      if hashes then
        return #hashes
      end
    end
  end
end

local function find_section_node(target_level)
  local node = vim.treesitter.get_node()
  while node do
    if node:type() == "section" then
      if target_level == nil then
        return node
      end
      local level = get_section_level(node)
      if level == target_level then
        return node
      end
    end
    node = node:parent()
  end
end

local function select_range(start_row, start_col, end_row, end_col)
  local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  vim.api.nvim_feedkeys(esc, "nx", false)

  vim.api.nvim_buf_set_mark(0, "<", start_row, start_col, {})
  vim.api.nvim_buf_set_mark(0, ">", end_row, end_col, {})
  vim.cmd("normal! gv")
end

local function select_section(mode, target_level)
  local section = find_section_node(target_level)
  if not section then
    return
  end

  local sr, sc, er, ec = section:range()

  if mode == "a" then
    local end_row, end_col
    if ec > 0 then
      end_row = er + 1
      end_col = ec - 1
    else
      end_row = er
      local line = vim.api.nvim_buf_get_lines(0, er - 1, er, false)[1] or ""
      end_col = math.max(0, #line - 1)
    end
    select_range(sr + 1, sc, end_row, end_col)
  elseif mode == "i" then
    -- Find the heading child to skip past it
    local heading_end_row = sr
    local heading_end_col = 0
    for child in section:iter_children() do
      if child:type() == "atx_heading" then
        local _, _, her, hec = child:range()
        heading_end_row = her
        heading_end_col = hec
        break
      end
    end

    -- Start on the line after the heading
    -- node:range() end is exclusive: if hec == 0, the heading ends on the previous line
    local first_line
    if heading_end_col == 0 then
      first_line = heading_end_row + 1 -- heading_end_row is already past the heading; convert to 1-indexed
    else
      first_line = heading_end_row + 2 -- heading_end_row is the last line of heading (0-indexed); +1 next line, +1 for 1-indexed
    end

    -- Skip leading blank lines after the heading
    local line_count = vim.api.nvim_buf_line_count(0)
    while first_line <= line_count do
      local line = vim.api.nvim_buf_get_lines(0, first_line - 1, first_line, false)[1] or ""
      if line:match("%S") then
        break
      end
      first_line = first_line + 1
    end

    -- Compute last line of section
    local end_row
    if ec > 0 then
      end_row = er + 1
    else
      end_row = er
    end

    if first_line > end_row then
      -- Empty section (heading only or only blank lines after heading)
      return
    end

    local last_line_text = vim.api.nvim_buf_get_lines(0, end_row - 1, end_row, false)[1] or ""
    select_range(first_line, 0, end_row, math.max(0, #last_line_text - 1))
  end
end

-- Generic section textobjects
vim.keymap.set({ "x", "o" }, "as", function()
  select_section("a", nil)
end, { buffer = true, desc = "Around section" })

vim.keymap.set({ "x", "o" }, "is", function()
  select_section("i", nil)
end, { buffer = true, desc = "Inside section" })

-- Level-specific section textobjects (a1s-a6s, i1s-i6s)
for level = 1, 6 do
  vim.keymap.set({ "x", "o" }, "a" .. level .. "s", function()
    select_section("a", level)
  end, { buffer = true, desc = "Around h" .. level .. " section" })

  vim.keymap.set({ "x", "o" }, "i" .. level .. "s", function()
    select_section("i", level)
  end, { buffer = true, desc = "Inside h" .. level .. " section" })
end
