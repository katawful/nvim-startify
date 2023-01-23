local _2afile_2a = "fnl/nvim-startify/utils/map.fnl"
local _2amodule_name_2a = "nvim-startify.utils.map"
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
local buffer, _ = autoload("nvim-startify.utils.buffer"), nil
_2amodule_locals_2a["buffer"] = buffer
_2amodule_locals_2a["_"] = _
local function init()
  return vim.keymap.set("n", "<plug>(startify-open-buffers)", buffer.open)
end
_2amodule_2a["init"] = init
return _2amodule_2a