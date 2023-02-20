local _2afile_2a = "fnl/nvim-startify/fortune/init.fnl"
local _2amodule_name_2a = "nvim-startify.fortune.init"
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
local function init()
  return {"FORTUNE", "nnnnnnnnnnnnnnnnnnnnnn"}
end
_2amodule_2a["init"] = init
local function longest_line(buffer)
  local line_count = 0
  for _, v in ipairs(file["get-value"](buffer, "header", "contents")) do
    if (#v > line_count) then
      line_count = #v
    else
    end
  end
  return line_count
end
_2amodule_2a["longest-line"] = longest_line
return _2amodule_2a