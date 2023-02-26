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
local a, config, fortune, _, _0 = autoload("nvim-startify.aniseed.core"), autoload("nvim-startify.utils.config"), autoload("nvim-startify.fortune.init"), nil, nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["config"] = config
_2amodule_locals_2a["fortune"] = fortune
_2amodule_locals_2a["_"] = _0
_2amodule_locals_2a["_"] = _0
local startify = {}
_2amodule_2a["startify"] = startify
local function get_value(buffer, ...)
  local vals = {...}
  local _1_ = #vals
  if (_1_ == 1) then
    return startify[buffer][vals[1]]
  elseif (_1_ == 2) then
    return (startify[buffer][vals[1]])[vals[2]]
  elseif (_1_ == 3) then
    return (startify[buffer][vals[1]])[vals[2]][vals[3]]
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
  local function _4_()
    local result_2_auto = vim.fn.exists("v:oldfiles")
    if (result_2_auto == 0) then
      return false
    else
      return true
    end
  end
  if ((vim.g.startify_locked == 0) or (vim.g.startify_locked == nil) or _4_()) then
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
local _7_
do
  local result_2_auto = vim.fn.has("win32")
  if (result_2_auto == 0) then
    _7_ = false
  else
    _7_ = true
  end
end
if _7_ then
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
local function center_align_window()
  local win_width = vim.api.nvim_win_get_width(0)
  local content_width = config.opts.width
  return math.floor(((win_width - content_width) / 2))
end
_2amodule_2a["center-align-window"] = center_align_window
local function right_align_window()
  local win_width = vim.api.nvim_win_get_width(0)
  local content_width = config.opts.width
  return (win_width - content_width)
end
_2amodule_2a["right-align-window"] = right_align_window
local function center_align_window0(content)
  local win_width = vim.api.nvim_win_get_width(0)
  local content_middle = math.floor((#content / 2))
  local win_middle = math.floor((win_width / 2))
  return (win_middle - content_middle)
end
_2amodule_2a["center-align-window"] = center_align_window0
local function right_align_window0(content, padding)
  local win_width = vim.api.nvim_win_get_width(0)
  local content_width = #content
  local function _11_()
    if padding then
      return padding
    else
      return 0
    end
  end
  return (win_width - content_width - _11_())
end
_2amodule_2a["right-align-window"] = right_align_window0
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
  local function _12_()
    if padding then
      return padding
    else
      return 0
    end
  end
  return (page_margin + (page_width - content_width - _12_()))
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
  local _13_ = align_type
  if (_13_ == "right-window") then
    return right_align_window0(content, padding)
  elseif (_13_ == "right-page") then
    return right_align_page(content, padding)
  elseif (_13_ == "left-window") then
    return left_align_window(content, padding)
  elseif (_13_ == "left-page") then
    return left_align_page(content, padding)
  elseif (_13_ == "center-window") then
    return center_align_window0(content)
  elseif (_13_ == "center-page") then
    return center_align_page(content)
  elseif true then
    local _1 = _13_
    vim.notify("Invalid alignment value", vim.log.levels.ERROR)
    return 0
  else
    return nil
  end
end
_2amodule_2a["alignment"] = alignment
local function padded_string(amount)
  local str = ""
  for i = 1, amount do
    str = (str .. " ")
  end
  return str
end
_2amodule_locals_2a["padded-string"] = padded_string
local function add_line(buffer, content, pos, format)
  local align
  if format.align then
    align = format.align
  else
    align = config.opts.format.align
  end
  local padding
  local function _16_()
    if format.padding then
      return format.padding
    else
      return config.opts.format.padding
    end
  end
  padding = alignment(align, content, _16_())
  local padded_content = string.format("%s%s", padded_string(padding), content)
  local pos0 = (pos - 1)
  return vim.api.nvim_buf_set_lines(buffer, pos0, pos0, false, {padded_content})
end
_2amodule_2a["add-line"] = add_line
return _2amodule_2a