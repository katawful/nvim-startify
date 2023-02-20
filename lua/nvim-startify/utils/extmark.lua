local _2afile_2a = "fnl/nvim-startify/utils/extmark.fnl"
local _2amodule_name_2a = "nvim-startify.utils.extmark"
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
local file, high = autoload("nvim-startify.utils.file"), autoload("nvim-startify.utils.highlight")
do end (_2amodule_locals_2a)["file"] = file
_2amodule_locals_2a["high"] = high
local function create_namespace()
  file.startify["namespace"] = vim.api.nvim_create_namespace("startify")
  return nil
end
_2amodule_2a["create-namespace"] = create_namespace
local function add(buffer, contents, placement, hl_group, pad_3f)
  local padded_contents
  do
    local out = {}
    for _, v in ipairs(contents) do
      table.insert(out, (file.padding(file["align-value"]()) .. v))
    end
    padded_contents = out
  end
  local padded_start_col = (file["align-value"]() + placement["start-col"])
  local padded_end_col = (file["align-value"]() + placement["end-col"])
  local function _1_()
    if pad_3f then
      return padded_contents
    else
      return contents
    end
  end
  vim.api.nvim_buf_set_lines(buffer, (placement["start-line"] - 1), (placement["end-line"] - 1), false, _1_())
  local _2_
  if pad_3f then
    _2_ = padded_start_col
  else
    _2_ = placement["start-col"]
  end
  local _4_
  if pad_3f then
    _4_ = padded_end_col
  else
    _4_ = placement["end-col"]
  end
  return vim.api.nvim_buf_set_extmark(buffer, file.startify.namespace, (placement["start-line"] - 1), _2_, {end_row = (placement["end-line"] - 1), end_col = _4_, hl_group = hl_group, strict = false})
end
_2amodule_2a["add"] = add
return _2amodule_2a