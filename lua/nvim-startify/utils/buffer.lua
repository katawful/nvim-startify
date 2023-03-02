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
local startify_opts = {bufhidden = "wipe", colorcolumn = "0", foldcolumn = "0", matchpairs = "", signcolumn = "no", swapfile = false, spell = false, buflisted = false, number = false, list = false, relativenumber = false, readonly = false, cursorcolumn = false, cursorline = false}
_2amodule_2a["startify-opts"] = startify_opts
local function set_options(buffer)
  for opt, val in pairs(startify_opts) do
    vim.opt_local[opt] = val
  end
  vim.api.nvim_buf_set_option(buffer, "synmaxcol", (vim.api.nvim_get_option_info("synmaxcol")).default)
  if not vim.api.nvim_win_get_option(0, "statusline") then
    vim.api.nvim_win_set_option(0, "statusline", "\\ startify")
  else
  end
  vim.bo[buffer]["filetype"] = "startify"
  return nil
end
_2amodule_2a["set-options"] = set_options
local function start(buffer)
  set_options(buffer)
  return file["insert-blankline"](buffer, 1000)
end
_2amodule_2a["start"] = start
local function unmodify(buffer)
  vim.api.nvim_buf_set_option(buffer, "modified", false)
  return vim.api.nvim_buf_set_option(buffer, "modifiable", false)
end
_2amodule_2a["unmodify"] = unmodify
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