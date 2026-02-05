local function find_node_upwards(types)
  local node = vim.treesitter.get_node()
  while node do
    local t = node:type()
    for _, typ in ipairs(types) do
      if t == typ then
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

local function node_select_outer(node)
  local sr, sc, er, ec = node:range()
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
end

-- Function textobjects (af/if)

local function select_function(mode)
  local func_node = find_node_upwards({ "function_definition" })
  if not func_node then
    return
  end

  if mode == "af" then
    node_select_outer(func_node)
  elseif mode == "if" then
    local body = func_node:field("body")[1]
    if not body then
      return
    end
    local sr, _, er, _ = body:range()
    local first_line = sr + 2
    local last_line = er
    if first_line > last_line then
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

-- Expression statement textobjects (ae/ie)

local function select_expression_statement(mode)
  local stmt_node = find_node_upwards({ "expression_statement" })
  if not stmt_node then
    return
  end

  if mode == "ae" then
    node_select_outer(stmt_node)
  elseif mode == "ie" then
    -- Select the inner expression, excluding the trailing semicolon
    local child = stmt_node:child(0)
    if not child then
      return
    end
    node_select_outer(child)
  end
end

vim.keymap.set({ "x", "o" }, "ae", function()
  select_expression_statement("ae")
end, { buffer = true, desc = "Around expression statement" })

vim.keymap.set({ "x", "o" }, "ie", function()
  select_expression_statement("ie")
end, { buffer = true, desc = "Inside expression statement" })
