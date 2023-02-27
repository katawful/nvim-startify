local _2afile_2a = "fnl/nvim-startify/render/builtins.fnl"
local _2amodule_name_2a = "nvim-startify.render.builtins"
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
local config, file = autoload("nvim-startify.utils.config"), autoload("nvim-startify.utils.file")
do end (_2amodule_locals_2a)["config"] = config
_2amodule_locals_2a["file"] = file
local key_string = "[%s] %s"
_2amodule_2a["key-string"] = key_string
local list_most_recent_files = {type = "file", entries = file["recent-files"](config.opts.settings["list-number"])}
_2amodule_2a["list-most-recent-files"] = list_most_recent_files
local title_global_files = {string = "Most Recent Files"}
_2amodule_2a["title-global-files"] = title_global_files
local function use(setting)
  local _1_ = setting
  if (_1_ == "list-most-recent-files") then
    return list_most_recent_files
  elseif (_1_ == "title-global-files") then
    return title_global_files
  else
    return nil
  end
end
_2amodule_2a["use"] = use
return _2amodule_2a