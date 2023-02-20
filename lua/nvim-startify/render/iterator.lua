local _2afile_2a = "fnl/nvim-startify/render/iterator.fnl"
local _2amodule_name_2a = "nvim-startify.render.iterator"
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
local file = autoload("nvim-startify.utils.file")
do end (_2amodule_locals_2a)["file"] = file
local function loop(buffer)
  local buf_length = #vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
  do end (file.startify)["current-line"] = 0
  local eof = false
  for i = 1, buf_length do
    if eof then break end
    print(i)
    eof = true
  end
  return nil
end
_2amodule_2a["loop"] = loop
local function skip_line_3f()
  return "Returns true if we can skip a line and continue looping"
end
_2amodule_2a["skip-line?"] = skip_line_3f
local function group_to_add()
  return "Finds and returns the group needed to be add when loop isn't skipped"
end
_2amodule_2a["group-to-add"] = group_to_add
local function group_loop()
  return "Loop through a group"
end
_2amodule_2a["group-loop"] = group_loop
return _2amodule_2a