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
local function center_align()
  local win_width = vim.api.nvim_win_get_width(0)
  local content_width = config.opts.width
  return math.floor(((win_width - content_width) / 2))
end
_2amodule_2a["center-align"] = center_align
local function right_align()
  local win_width = vim.api.nvim_win_get_width(0)
  local content_width = config.opts.width
  return (win_width - content_width)
end
_2amodule_2a["right-align"] = right_align
local function align_value()
  local _11_ = config.opts.alignment
  if (_11_ == "center") then
    return center_align()
  elseif (_11_ == "left") then
    return config.opts["left-padding"]
  elseif (_11_ == "right") then
    return right_align()
  else
    return nil
  end
end
_2amodule_2a["align-value"] = align_value
local function header_align(buffer)
  local win_width = vim.api.nvim_win_get_width(0)
  local content_width = fortune["longest-line"](buffer)
  return math.floor(((win_width - content_width) / 2))
end
_2amodule_2a["header-align"] = header_align
local function padding(amount)
  local str = ""
  for i = 1, amount do
    str = (str .. " ")
  end
  return str
end
_2amodule_2a["padding"] = padding
local function pad_contents(buffer, contents, amount)
  local out = {}
  for _1, v in ipairs(get_value(buffer, "header", "contents")) do
    table.insert(out, (padding(amount) .. v))
  end
  return out
end
_2amodule_2a["pad-contents"] = pad_contents
return _2amodule_2a