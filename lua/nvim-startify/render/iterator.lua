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
local builtin, config, file, index = autoload("nvim-startify.render.builtins"), autoload("nvim-startify.utils.config"), autoload("nvim-startify.utils.file"), autoload("nvim-startify.utils.index")
do end (_2amodule_locals_2a)["builtin"] = builtin
_2amodule_locals_2a["config"] = config
_2amodule_locals_2a["file"] = file
_2amodule_locals_2a["index"] = index
local function skip_line_3f()
  return "Returns true if we can skip a line and continue looping"
end
_2amodule_2a["skip-line?"] = skip_line_3f
local function title_ify_loop(buffer, ify)
  local ify_format
  if ify.format then
    ify_format = ify.format
  else
    ify_format = {}
  end
  local merged_format = vim.tbl_extend("keep", ify_format, config.opts.format)
  if merged_format["above-spacing"] then
    file.startify["current-line"] = (file.startify["current-line"] + merged_format["above-spacing"])
  else
  end
  file["add-line"](buffer, ify.string, file.startify["current-line"], merged_format)
  file.startify["current-line"] = (file.startify["current-line"] + 1)
  if merged_format["below-spacing"] then
    file.startify["current-line"] = (file.startify["current-line"] + merged_format["below-spacing"])
    return nil
  else
    return nil
  end
end
_2amodule_2a["title-ify-loop"] = title_ify_loop
local function entries_loop(buffer, ify, format)
  local entries_length = #ify.entries
  local names
  if ify.names then
    names = ify.names
  else
    names = ify.entries
  end
  for i = 1, entries_length do
    file["add-entry-line"](buffer, file["pad-key-string"](index["get-next"](buffer), names[i], format), file.startify["current-line"], format)
    file.startify["current-line"] = (file.startify["current-line"] + 1)
  end
  return nil
end
_2amodule_2a["entries-loop"] = entries_loop
local function list_ify_loop(buffer, ify)
  local ify_format
  local _6_
  do
    local t_5_ = ify
    if (nil ~= t_5_) then
      t_5_ = (t_5_).format
    else
    end
    _6_ = t_5_
  end
  if _6_ then
    ify_format = ify.format
  else
    ify_format = {}
  end
  local merged_format = vim.tbl_extend("keep", ify_format, config.opts.format)
  if merged_format["above-spacing"] then
    file.startify["current-line"] = (file.startify["current-line"] + merged_format["above-spacing"])
  else
  end
  entries_loop(buffer, ify, merged_format)
  if merged_format["below-spacing"] then
    file.startify["current-line"] = (file.startify["current-line"] + merged_format["below-spacing"])
    return nil
  else
    return nil
  end
end
_2amodule_2a["list-ify-loop"] = list_ify_loop
local function art_ify_loop(buffer, art_ify)
end
_2amodule_2a["art-ify-loop"] = art_ify_loop
local function ify_loop(buffer, to_ify)
  local ify
  if (type(to_ify[1]) == "string") then
    ify = builtin.use(to_ify[1])
  else
    ify = to_ify[1]
  end
  local ify_type = to_ify[2]
  local _12_ = ify_type
  if (_12_ == "title") then
    return title_ify_loop(buffer, ify)
  elseif (_12_ == "list") then
    return list_ify_loop(buffer, ify)
  elseif (_12_ == "art") then
    return art_ify_loop(buffer, ify)
  else
    return nil
  end
end
_2amodule_2a["ify-loop"] = ify_loop
local function loop(buffer)
  file.startify["current-line"] = 1
  local ifys = config.opts["render-order"]
  local ifys_length = #ifys
  for i = 1, ifys_length do
    ify_loop(buffer, ifys[i])
  end
  return nil
end
_2amodule_2a["loop"] = loop
return _2amodule_2a