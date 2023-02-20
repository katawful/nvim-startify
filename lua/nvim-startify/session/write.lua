local _2afile_2a = "fnl/nvim-startify/session/write.fnl"
local _2amodule_name_2a = "nvim-startify.session.write"
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
local function init(file)
  return print("SESSION WRITTEN")
end
_2amodule_2a["init"] = init
local function save(bang, files)
  return print("SESSION WRITTEN")
end
_2amodule_2a["save"] = save
return _2amodule_2a