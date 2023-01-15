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
local function update_oldfiles(file)
  return print(file, "OLDFILES UPDATED")
end
_2amodule_2a["update-oldfiles"] = update_oldfiles
return _2amodule_2a