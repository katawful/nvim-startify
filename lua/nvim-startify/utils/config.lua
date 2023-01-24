local _2afile_2a = "fnl/nvim-startify/utils/config.fnl"
local _2amodule_name_2a = "nvim-startify.utils.config"
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
local fortune, _, _0 = autoload("nvim-startify.fortune.init"), nil, nil
_2amodule_locals_2a["fortune"] = fortune
_2amodule_locals_2a["_"] = _0
_2amodule_locals_2a["_"] = _0
local value = {["relative-path"] = ":~:.", ["absolute-path"] = ":p:~"}
_2amodule_2a["value"] = value
local default
local function _1_(...)
  return vim.g.startify_files_number
end
local _2_
if vim.g.startify_enable_special then
  _2_ = __fnl_global__handle_2dvim_2dvar("startify_relative_path", "g", true, false)
else
  _2_ = true
end
local _4_
if vim.g.startify_relative_path then
  _4_ = __fnl_global__handle_2dvim_2dvar("startify_relative_path", "g", value["relative-path"], value["absolute-path"])
else
  _4_ = value["relative-path"]
end
local function _6_(...)
  return vim.g.startify_transformations
end
local _7_
do
  local list
  local function _8_(...)
    return vim.g.startify_skiplist
  end
  list = (_8_(...) or {})
  table.insert(list, "runtime/doc/.*\\.txt$")
  table.insert(list, "bundle/.*/doc/.*\\.txt$")
  table.insert(list, "plugged/.*/doc/.*\\.txt$")
  table.insert(list, "/\\.git/")
  table.insert(list, "fugitiveblame$")
  table.insert(list, (vim.fn.escape(vim.fn.fnamemodify(vim.fn.resolve(vim.fn.getenv("VIMRUNTIME")), ":p"), "\\") .. "doc/.*\\.txt$"))
  _7_ = list
end
local function _9_(...)
  return vim.g.startify_skiplist_server
end
local function _10_(...)
  return vim.g.startify_padding_left
end
local function _11_(...)
  return vim.g.startify_bookmarks
end
local _12_
if vim.g.startify_change_to_dir then
  _12_ = __fnl_global__handle_2dvim_2dvar("startify_change_to_dir", "g", true, false)
else
  _12_ = true
end
local _14_
if vim.g.startify_change_to_vcs_dir then
  _14_ = __fnl_global__handle_2dvim_2dvar("startify_change_to_vcs_dir", "g", true, false)
else
  _14_ = false
end
local function _16_(...)
  return vim.g.startify_change_cmd
end
local function _17_(...)
  return vim.g.startify_lists
end
local function _18_(...)
  return vim.g.startify_commands
end
local _19_
if vim.g.startify_update_old_files then
  _19_ = __fnl_global__handle_2dvim_2dvar("startify_update_old_files", "g", true, false)
else
  _19_ = false
end
local function _21_(...)
  return vim.g.startify_session_dir
end
local _22_
if vim.g.startify_session_autoload then
  _22_ = __fnl_global__handle_2dvim_2dvar("startify_session_autoload", "g", true, false)
else
  _22_ = false
end
local function _24_(...)
  return vim.g.startify_session_remove_lines
end
local function _25_(...)
  return vim.g.startify_session_savevars
end
local function _26_(...)
  return vim.g.startify_session_savecmds
end
local function _27_(...)
  return vim.g.startify_session_number
end
local _28_
if vim.g.startify_session_persistence then
  _28_ = __fnl_global__handle_2dvim_2dvar("startify_session_persistence", "g", true, false)
else
  _28_ = false
end
local _30_
if vim.g.startify_session_sort then
  _30_ = __fnl_global__handle_2dvim_2dvar("startify_session_sort", "g", true, false)
else
  _30_ = false
end
local function _32_(...)
  return vim.g.startify_custom_indices
end
local _33_
if vim.g.startify_custom_header then
  vim.notify("vim.g.startify_custom_header must be converted manually\nDefaulting to an empty value", vim.log.levels.WARN)
  _33_ = {""}
else
  _33_ = fortune.init()
end
local function _35_(...)
  return vim.g.startify_custom_header_quotes
end
local function _36_(...)
  return vim.g.startify_custom_footer
end
local _37_
if vim.g.startify_disable_at_vimenter then
  _37_ = __fnl_global__handle_2dvim_2dvar("startify_disable_at_vimenter", false, true)
else
  _37_ = true
end
local _39_
if vim.g.startify_use_env then
  _39_ = __fnl_global__handle_2dvim_2dvar("startify_use_env", true, false)
else
  _39_ = false
end
local function _41_(...)
  return vim.g.startify_session_before_save
end
local _42_
if vim.g.startify_session_delete_buffers then
  _42_ = __fnl_global__handle_2dvim_2dvar("startify_session_delete_buffers", "g", true, false)
else
  _42_ = true
end
local _44_
if vim.g.startify_fortune_use_unicode then
  _44_ = __fnl_global__handle_2dvim_2dvar("startify_fortune_use_unicode", "g", true, false)
else
  _44_ = false
end
default = {["files-number"] = (_1_(...) or 10), ["show-special"] = _2_, ["use-relative-path"] = _4_, transformations = (_6_(...) or {}), skiplist = _7_, ["server-skiplist"] = (_9_(...) or {}), ["left-padding"] = (_10_(...) or 3), bookmarks = (_11_(...) or {}), ["change-to-dir"] = _12_, ["change-to-vcs-root"] = _14_, ["chdir-cmd"] = (_16_(...) or "lcd"), ["display-lists"] = (_17_(...) or {{type = "files", header = "   MRU"}, {type = "dir", header = ("   MRU " .. vim.fn.getcwd())}, {type = "sessions", header = "   Sessions"}, {type = "bookmarks", header = "   Bookmarks"}, {type = "commands", header = "   Commands"}}), commands = (_18_(...) or {}), ["update-old-files"] = _19_, ["session-dir"] = (_21_(...) or (vim.fn.stdpath("data") .. "/session")), ["session-autoload"] = _22_, ["session-remove-lines"] = (_24_(...) or {}), ["session-save-vars"] = (_25_(...) or {}), ["session-save-cmds"] = (_26_(...) or {}), ["session-number"] = (_27_(...) or 999), ["session-persistence"] = _28_, ["session-sort-time"] = _30_, ["custom-index"] = (_32_(...) or {}), ["custom-header"] = _33_, ["custom-header-quote"] = (_35_(...) or {}), ["custom-footer"] = (_36_(...) or ""), ["on-vimenter"] = _37_, ["show-env"] = _39_, ["pre-session-commands"] = (_41_(...) or {}), ["del-buf-on-session"] = _42_, ["fortune-unicode"] = _44_}
_2amodule_2a["default"] = default
local opts = {}
_2amodule_2a["opts"] = opts
local function hotload(config)
  if config then
    local out = vim.tbl_deep_extend("force", default, config)
    for k, v in pairs(out) do
      opts[k] = v
    end
    return nil
  else
    for k, v in pairs(default) do
      opts[k] = v
    end
    return nil
  end
end
_2amodule_2a["hotload"] = hotload
return _2amodule_2a