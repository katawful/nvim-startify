local _2afile_2a = "fnl/nvim-startify/utils/index.fnl"
local _2amodule_name_2a = "nvim-startify.utils.index"
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
local function create(buffer)
  if config.opts["custom-index"] then
    file.startify[buffer]["global-index-state"] = {}
    file.startify[buffer]["global-index-position"] = {}
    file.startify[buffer]["global-index-state"][1] = (config.opts["custom-index"])[1]
    file.startify[buffer]["global-index-position"][1] = 1
    return nil
  else
    file.startify[buffer]["global-index-state"] = {}
    file.startify[buffer]["global-index-position"] = {}
    file.startify[buffer]["global-index-state"][1] = 0
    file.startify[buffer]["global-index-position"][1] = 1
    return nil
  end
end
_2amodule_2a["create"] = create
local function inc_and_return(buffer)
  local pre_cur_index = file["get-value"](buffer, "global-index-state", 1)
  local cur_index
  if pre_cur_index then
    cur_index = pre_cur_index
  else
    cur_index = 0
  end
  local pre_cur_pos = file["get-value"](buffer, "global-index-position", 1)
  local cur_pos
  if pre_cur_pos then
    cur_pos = pre_cur_pos
  else
    cur_pos = 1
  end
  local next_pos = (cur_pos + 1)
  do end (file.startify[buffer]["global-index-position"])[1] = next_pos
  if config.opts["custom-index"] then
    file.startify[buffer]["global-index-state"][1] = (config.opts["custom-index"])[next_pos]
  else
    file.startify[buffer]["global-index-state"][1] = cur_pos
  end
  return cur_index
end
_2amodule_2a["inc-and-return"] = inc_and_return
local function get_next(buffer)
  local _6_
  do
    local t_5_
    do
      local t_7_ = file.startify[buffer]
      if (nil ~= t_7_) then
        t_7_ = (t_7_)["global-index-state"]
      else
      end
      t_5_ = t_7_
    end
    if (nil ~= t_5_) then
      t_5_ = (t_5_)[1]
    else
    end
    _6_ = t_5_
  end
  if _6_ then
    return inc_and_return(buffer)
  else
    create(buffer)
    return inc_and_return(buffer)
  end
end
_2amodule_2a["get-next"] = get_next
return _2amodule_2a