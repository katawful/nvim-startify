local _2afile_2a = "fnl/nvim-startify/utils/data.fnl"
local _2amodule_name_2a = "nvim-startify.utils.data"
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
local file = autoload("nvim-startify.utils.file")
do end (_2amodule_locals_2a)["file"] = file
local function insert_entry(entry)
  return table.insert((((file.startify[file.startify["working-buffer"]]).ify)[file.startify["working-ify"]]).entries, entry)
end
_2amodule_2a["insert-entry"] = insert_entry
local function insert_key(entry, index)
  table.insert((((file.startify[file.startify["working-buffer"]]).ify)[file.startify["working-ify"]]).keys, entry)
  do end (entry)["index"] = index
  return table.insert((file.startify[file.startify["working-buffer"]]).keys, entry)
end
_2amodule_2a["insert-key"] = insert_key
local function set_ify_value(ify, key, value)
  ((file.startify[file.startify["working-buffer"]]).ify)[ify][key] = value
  return nil
end
_2amodule_2a["set-ify-value"] = set_ify_value
return _2amodule_2a