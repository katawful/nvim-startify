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
local autoload = (require("nvim-startify.aniseed.autoload")).autoload
local a, _ = autoload("nvim-startify.aniseed.core"), nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["_"] = _
local function remove_from_seq_tbl(seq, key)
  local output = {}
  for _0, val in ipairs(seq) do
    if (key ~= val) then
      table.insert(output, val)
    else
    end
  end
  return output
end
_2amodule_locals_2a["remove-from-seq-tbl"] = remove_from_seq_tbl
local function update_oldfiles(file)
  if ((vim.g.startify_locked == 0) or (vim.g.startify_locked == nil) or __fnl_global__do_2dviml(exists, "v:oldfiles")) then
    remove_from_seq_tbl(vim.v.oldfiles, file)
    return table.insert(vim.v.oldfiles, 0, file)
  else
    return nil
  end
end
_2amodule_2a["update-oldfiles"] = update_oldfiles
return _2amodule_2a