local _2afile_2a = "fnl/nvim-startify/session/init.fnl"
local _2amodule_name_2a = "nvim-startify.session.init"
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
local config, _ = autoload("nvim-startify.utils.config"), nil
_2amodule_locals_2a["config"] = config
_2amodule_locals_2a["_"] = _
local function path()
  return vim.fn["(do-viml config.opts.session-dir resolve)"](expand)
end
_2amodule_2a["path"] = path
return _2amodule_2a