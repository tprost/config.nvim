local function find_function_node()
  local node = vim.treesitter.get_node()
  while node do
    local t = node:type()
    if t == "function_declaration" or t == "method_declaration" or t == "func_literal" then
      return node
    end
    node = node:parent()
  end
end

local function select_range(start_row, start_col, end_row, end_col)
  -- Exit any existing visual mode first, then position marks and reselect
  local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  vim.api.nvim_feedkeys(esc, "nx", false)

  vim.api.nvim_buf_set_mark(0, "<", start_row, start_col, {})
  vim.api.nvim_buf_set_mark(0, ">", end_row, end_col, {})
  vim.cmd("normal! gv")
end

local function select_function(mode)
  local func_node = find_function_node()
  if not func_node then
    return
  end

  if mode == "af" then
    local sr, sc, er, ec = func_node:range()
    -- node:range() is 0-indexed with exclusive end
    -- Convert to 1-indexed inclusive for marks
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
  elseif mode == "if" then
    local body = func_node:field("body")[1]
    if not body then
      return
    end
    local sr, _, er, _ = body:range()
    -- Select inside the braces: line after opening { to line before closing }
    local first_line = sr + 2 -- 1-indexed, skip the { line
    local last_line = er      -- 0-indexed end row = 1-indexed last content line (line before })
    if first_line > last_line then
      -- Empty function body
      return
    end
    local last_line_text = vim.api.nvim_buf_get_lines(0, last_line - 1, last_line, false)[1] or ""
    select_range(first_line, 0, last_line, #last_line_text - 1)
  end
end

vim.keymap.set({ "x", "o" }, "af", function()
  select_function("af")
end, { buffer = true, desc = "Around function" })

vim.keymap.set({ "x", "o" }, "if", function()
  select_function("if")
end, { buffer = true, desc = "Inside function" })
