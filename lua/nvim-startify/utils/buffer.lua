local _2afile_2a = "fnl/nvim-startify/utils/buffer.fnl"
local _2amodule_name_2a = "nvim-startify.utils.buffer"
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
local extmark, file = autoload("nvim-startify.utils.extmark"), autoload("nvim-startify.utils.file")
do end (_2amodule_locals_2a)["extmark"] = extmark
_2amodule_locals_2a["file"] = file
local function open(...)
  return print("BUFFERS OPENED")
end
_2amodule_2a["open"] = open
local function empty_3f(buffer)
  local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
  local len = #lines
  if (len >= 1) then
    if ((len == 1) and (lines[1] == "")) then
      return true
    else
      return false
    end
  else
    return true
  end
end
_2amodule_2a["empty?"] = empty_3f
local function modifiable_3f(buffer)
  if vim.api.nvim_buf_get_option(buffer, "modifiable") then
    return true
  else
    return false
  end
end
_2amodule_2a["modifiable?"] = modifiable_3f
local function visible_modified_3f(buffer)
  if (vim.api.nvim_buf_get_option(buffer, "modified") and not vim.api.nvim_buf_get_option(buffer, "hidden")) then
    vim.notify("Save your changes first.")
    return true
  else
    return false
  end
end
_2amodule_2a["visible-modified?"] = visible_modified_3f
local function new_entry(buffer, name, contents, hl_group, line_num, key, entry_type, command, language, path)
  if file["get-value"](buffer, "entries") then
    file.startify[buffer]["entries"] = {}
  else
  end
  return table.insert(file["get-value"](buffer, "entries"), {["line-num"] = line_num, contents = contents, key = key, ["entry-type"] = entry_type, command = command, language = language, path = path, extmark = extmark.add(buffer, {contents}, {["start-line"] = line_num, ["end-line"] = line_num, ["start-col"] = 1, ["end-col"] = #contents}, hl_group, true)})
end
_2amodule_2a["new-entry"] = new_entry
return _2amodule_2a