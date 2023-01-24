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
local a, autocmd, command, configs, fortune, map, _, _0 = autoload("nvim-startify.aniseed.core"), autoload("nvim-startify.utils.autocmd"), autoload("nvim-startify.utils.command"), autoload("nvim-startify.utils.config"), autoload("nvim-startify.fortune.init"), autoload("nvim-startify.utils.map"), nil, nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["autocmd"] = autocmd
_2amodule_locals_2a["command"] = command
_2amodule_locals_2a["configs"] = configs
_2amodule_locals_2a["fortune"] = fortune
_2amodule_locals_2a["map"] = map
_2amodule_locals_2a["_"] = _0
_2amodule_locals_2a["_"] = _0
local function handle_vim_var(var_name, scope, truthy, falsy)
  if (vim[scope][var_name] == 0) then
    return falsy
  elseif (vim[scope][var_name] > 0) then
    return truthy
  else
    return nil
  end
end
_2amodule_2a["handle-vim-var"] = handle_vim_var
local value = {["relative-path"] = ":~:.", ["absolute-path"] = ":p:~"}
_2amodule_2a["value"] = value
local function config(opts)
  return configs.hotload(opts)
end
_2amodule_2a["config"] = config
local function init()
  print("HI")
  if a["empty?"](configs.opts) then
    configs.hotload()
  else
  end
  autocmd.init()
  command.init()
  map.init()
  return print("BYE")
end
_2amodule_2a["init"] = init
return _2amodule_2a