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
local a, _, _0 = autoload("nvim-startify.aniseed.core"), nil, nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["_"] = _0
_2amodule_locals_2a["_"] = _0
local startify = {lastline = -1}
_2amodule_2a["startify"] = startify
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
  local function _2_()
    local result_2_auto = vim.fn.exists("v:oldfiles")
    if (result_2_auto == 0) then
      return false
    else
      return true
    end
  end
  if ((vim.g.startify_locked == 0) or (vim.g.startify_locked == nil) or _2_()) then
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
local _5_
do
  local result_2_auto = vim.fn.has("win32")
  if (result_2_auto == 0) then
    _5_ = false
  else
    _5_ = true
  end
end
if _5_ then
  separator = "\\"
else
  separator = "/"
end
_2amodule_2a["separator"] = separator
return _2amodule_2a