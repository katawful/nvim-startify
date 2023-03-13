local _2afile_2a = "fnl/nvim-startify/utils/file.fnl"
local _2amodule_name_2a = "nvim-startify.utils.file"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local autoload = (require("nvim-startify.aniseed.autoload")).autoload
local a, builtin, config, data, ext, fortune, _, _0 = autoload("nvim-startify.aniseed.core"), autoload("nvim-startify.render.builtins"), autoload("nvim-startify.utils.config"), autoload("nvim-startify.utils.data"), autoload("nvim-startify.utils.extmark"), autoload("nvim-startify.fortune.init"), nil, nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["builtin"] = builtin
_2amodule_locals_2a["config"] = config
_2amodule_locals_2a["data"] = data
_2amodule_locals_2a["ext"] = ext
_2amodule_locals_2a["fortune"] = fortune
_2amodule_locals_2a["_"] = _0
_2amodule_locals_2a["_"] = _0
local startify = {}
_2amodule_2a["startify"] = startify
local function get_value(buffer, ...)
  local vals = {...}
  local _1_ = #vals
  if (_1_ == 1) then
    local t_2_
    do
      local t_3_ = startify
      if (nil ~= t_3_) then
        t_3_ = (t_3_)[buffer]
      else
      end
      t_2_ = t_3_
    end
    if (nil ~= t_2_) then
      t_2_ = (t_2_)[vals[1]]
    else
    end
    return t_2_
  elseif (_1_ == 2) then
    local t_6_
    do
      local t_7_
      do
        local t_8_ = startify
        if (nil ~= t_8_) then
          t_8_ = (t_8_)[buffer]
        else
        end
        t_7_ = t_8_
      end
      if (nil ~= t_7_) then
        t_7_ = (t_7_)[vals[1]]
      else
      end
      t_6_ = t_7_
    end
    if (nil ~= t_6_) then
      t_6_ = (t_6_)[vals[2]]
    else
    end
    return t_6_
  elseif (_1_ == 3) then
    local t_12_
    do
      local t_13_
      do
        local t_14_ = startify
        if (nil ~= t_14_) then
          t_14_ = (t_14_)[buffer]
        else
        end
        t_13_ = t_14_
      end
      if (nil ~= t_13_) then
        t_13_ = (t_13_)[vals[1]]
      else
      end
      t_12_ = t_13_
    end
    if (nil ~= t_12_) then
      t_12_ = (t_12_)[vals[2]]
    else
    end
    if (nil ~= t_12_) then
      t_12_ = (t_12_)[vals[3]]
    else
    end
    return t_12_
  else
    return nil
  end
end
_2amodule_2a["get-value"] = get_value
local function set_start_values(buffer, opt)
  for k, v in pairs(opt) do
    startify[buffer][k] = v
  end
  return nil
end
_2amodule_2a["set-start-values"] = set_start_values
local function remove_from_seq_tbl(seq, key)
  local output = {}
  for _1, val in ipairs(seq) do
    if (key ~= val) then
      table.insert(output, val)
    else
    end
  end
  return output
end
_2amodule_locals_2a["remove-from-seq-tbl"] = remove_from_seq_tbl
local function update_oldfiles(file)
  local function _21_()
    local result_2_auto = vim.fn.exists("v:oldfiles")
    if (result_2_auto == 0) then
      return false
    else
      return true
    end
  end
  if ((vim.g.startify_locked == 0) or (vim.g.startify_locked == nil) or _21_()) then
    remove_from_seq_tbl(vim.v.oldfiles, file)
    return table.insert(vim.v.oldfiles, 0, file)
  else
    return nil
  end
end
_2amodule_2a["update-oldfiles"] = update_oldfiles
local function lastline(buffer)
  return #vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
end
_2amodule_2a["lastline"] = lastline
_G.startify_lastline = function(buffer)
  return lastline(buffer)
end
local separator
local _24_
do
  local result_2_auto = vim.fn.has("win32")
  if (result_2_auto == 0) then
    _24_ = false
  else
    _24_ = true
  end
end
if _24_ then
  separator = "\\"
else
  separator = "/"
end
_2amodule_2a["separator"] = separator
_G.startify_fn_separator = function()
  return separator
end
local function insert_blankline(buffer, amount)
  for i = 1, amount do
    vim.api.nvim_buf_set_lines(buffer, -1, -1, false, {""})
  end
  return nil
end
_2amodule_2a["insert-blankline"] = insert_blankline
local function center_align_window(content)
  local win_width = vim.api.nvim_win_get_width(0)
  local content_middle = math.floor((#content / 2))
  local win_middle = math.floor((win_width / 2))
  return (win_middle - content_middle)
end
_2amodule_2a["center-align-window"] = center_align_window
local function right_align_window(content, padding)
  local win_width = vim.api.nvim_win_get_width(0)
  local content_width = #content
  local function _28_()
    if padding then
      return padding
    else
      return 0
    end
  end
  return (win_width - content_width - _28_())
end
_2amodule_2a["right-align-window"] = right_align_window
local function left_align_window(content, padding)
  return padding
end
_2amodule_2a["left-align-window"] = left_align_window
local function center_align_page(content)
  local win_width = vim.api.nvim_win_get_width(0)
  local content_middle = math.floor((#content / 2))
  local page_width = config.opts.format["page-width"]
  local page_middle = math.floor((page_width / 2))
  local page_margin = math.floor(((win_width - page_width) / 2))
  local win_middle = math.floor((win_width / 2))
  return (page_margin + (page_middle - content_middle))
end
_2amodule_2a["center-align-page"] = center_align_page
local function right_align_page(content, padding)
  local win_width = vim.api.nvim_win_get_width(0)
  local content_width = #content
  local page_width = config.opts.format["page-width"]
  local page_margin = math.floor(((win_width - page_width) / 2))
  local function _29_()
    if padding then
      return padding
    else
      return 0
    end
  end
  return (page_margin + (page_width - content_width - _29_()))
end
_2amodule_2a["right-align-page"] = right_align_page
local function left_align_page(content, padding)
  local win_width = vim.api.nvim_win_get_width(0)
  local content_width = #content
  local page_width = config.opts.format["page-width"]
  local page_margin = math.floor(((win_width - page_width) / 2))
  return (page_margin + padding)
end
_2amodule_2a["left-align-page"] = left_align_page
local function alignment(align_type, content, padding)
  local _30_ = align_type
  if (_30_ == "right-window") then
    return right_align_window(content, padding)
  elseif (_30_ == "right-page") then
    return right_align_page(content, padding)
  elseif (_30_ == "left-window") then
    return left_align_window(content, padding)
  elseif (_30_ == "left-page") then
    return left_align_page(content, padding)
  elseif (_30_ == "center-window") then
    return center_align_window(content)
  elseif (_30_ == "center-page") then
    return center_align_page(content)
  elseif true then
    local _1 = _30_
    vim.notify("Invalid alignment value", vim.log.levels.ERROR)
    return 0
  else
    return nil
  end
end
_2amodule_2a["alignment"] = alignment
local function padded_string(amount)
  local amount0
  if amount then
    amount0 = amount
  else
    amount0 = 0
  end
  local str = ""
  for i = 1, amount0 do
    str = (str .. " ")
  end
  return str
end
_2amodule_2a["padded-string"] = padded_string
local function pad_key_string(keymap, content, format, typer, index)
  local key_string = builtin["key-string"]
  local padding = (format.padding or config.opts.format.padding)
  local align = (format.align or config.opts.format.align)
  local win_or_page
  if string.find(align, "window") then
    win_or_page = "win"
  else
    win_or_page = "page"
  end
  local page_padding
  if (win_or_page == "win") then
    page_padding = left_align_window(key_string, padding)
  else
    page_padding = left_align_page(key_string, padding)
  end
  local aligned_key_string = string.format("%s%s", padded_string(page_padding), key_string)
  local win_width = vim.api.nvim_win_get_width(0)
  local page_width = config.opts.format["page-width"]
  local page_margin
  if (win_or_page == "page") then
    page_margin = math.floor(((win_width - page_width) / 2))
  else
    page_margin = 0
  end
  local keymap_length = string.len(tostring(keymap))
  local content_padding = padded_string((alignment(align, content, padding) - keymap_length - page_margin - 2 - padding))
  local line = {startify["current-line"], startify["current-line"]}
  local content_col = {(page_padding + 2 + #tostring(keymap) + #content_padding + 1), (page_padding + 2 + #tostring(keymap) + #content_padding + #content)}
  local key_col = {(page_padding + 1 + 1), (page_padding + 1 + #tostring(keymap))}
  data["insert-entry"]({line = line, col = content_col, ext = ext.add(startify["working-buffer"], line, content_col, nil)})
  data["insert-key"]({line = {startify["current-line"], startify["current-line"]}, col = key_col, map = tostring(keymap), ext = ext.add(startify["working-buffer"], line, key_col, nil)}, index)
  data["set-ify-value"](startify["working-ify"], "type", typer)
  return string.format(aligned_key_string, keymap, content_padding, content)
end
_2amodule_2a["pad-key-string"] = pad_key_string
local function add_line(buffer, content, pos, format)
  local align
  if format.align then
    align = format.align
  else
    align = config.opts.format.align
  end
  local padding
  local function _37_()
    if format.padding then
      return format.padding
    else
      return config.opts.format.padding
    end
  end
  padding = alignment(align, content, _37_())
  local padded_content = string.format("%s%s", padded_string(padding), content)
  local pos0 = (pos - 1)
  local col = {(padding + 1), (#content + padding)}
  data["set-ify-value"](startify["working-ify"], "line", {(pos0 + 1), (pos0 + 1)})
  data["set-ify-value"](startify["working-ify"], "col", col)
  data["set-ify-value"](startify["working-ify"], "ext", ext.add(buffer, {pos0, pos0}, col, nil))
  return vim.api.nvim_buf_set_lines(buffer, pos0, pos0, false, {padded_content})
end
_2amodule_2a["add-line"] = add_line
local function add_entry_line(buffer, content, pos, format)
  local pos0 = (pos - 1)
  return vim.api.nvim_buf_set_lines(buffer, pos0, pos0, false, {content})
end
_2amodule_2a["add-entry-line"] = add_entry_line
local function add_string_line(buffer, content, pos, format, width)
  local align = (format.align or config.opts.format.align)
  local padding = alignment(align, padded_string(width), (format.padding or config.opts.format.padding))
  local padded_content = string.format("%s%s", padded_string(padding), content)
  local pos0 = (pos - 1)
  data["set-ify-value"](startify["working-ify"], "col", {(padding + 1), (width + padding)})
  return vim.api.nvim_buf_set_lines(buffer, pos0, pos0, false, {padded_content})
end
_2amodule_2a["add-string-line"] = add_string_line
local function recent_files(file_number)
  local output = {}
  local oldfiles = vim.v.oldfiles
  for i = 1, file_number do
    output[i] = oldfiles[i]
  end
  return output
end
_2amodule_2a["recent-files"] = recent_files
return _2amodule_2a