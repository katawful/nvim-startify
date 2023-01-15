local _2afile_2a = "fnl/nvim-startify/main.fnl"
local _2amodule_name_2a = "nvim-startify.main"
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
local autocmd = autoload("nvim-startify.utils.autocmd")
do end (_2amodule_locals_2a)["autocmd"] = autocmd
local function init()
  print("HI")
  autocmd.init()
  return print("BYE")
end
_2amodule_2a["init"] = init
return _2amodule_2a