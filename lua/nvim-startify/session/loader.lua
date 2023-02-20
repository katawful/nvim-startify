local _2afile_2a = "fnl/nvim-startify/session/loader.fnl"
local _2amodule_name_2a = "nvim-startify.utils.session.loader"
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
local function init(source_last_session_3f, files)
  return print("SESSION LOADED")
end
_2amodule_2a["init"] = init
local function file(session_file)
  return print("SESSION LOADED")
end
_2amodule_2a["file"] = file
return _2amodule_2a