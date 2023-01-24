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
local default
local function _2_(...)
  return vim.g.startify_files_number
end
local _3_
if vim.g.startify_enable_special then
  _3_ = handle_vim_var("startify_relative_path", "g", true, false)
else
  _3_ = true
end
local _5_
if vim.g.startify_relative_path then
  _5_ = handle_vim_var("startify_relative_path", "g", value["relative-path"], value["absolute-path"])
else
  _5_ = value["relative-path"]
end
local function _7_(...)
  return vim.g.startify_transformations
end
local _8_
do
  local list
  local function _9_(...)
    return vim.g.startify_skiplist
  end
  list = (_9_(...) or {})
  table.insert(list, "runtime/doc/.*\\.txt$")
  table.insert(list, "bundle/.*/doc/.*\\.txt$")
  table.insert(list, "plugged/.*/doc/.*\\.txt$")
  table.insert(list, "/\\.git/")
  table.insert(list, "fugitiveblame$")
  table.insert(list, (vim.fn.escape(vim.fn.fnamemodify(vim.fn.resolve(vim.fn.getenv("VIMRUNTIME")), ":p"), "\\") .. "doc/.*\\.txt$"))
  _8_ = list
end
local function _10_(...)
  return vim.g.startify_skiplist_server
end
local function _11_(...)
  return vim.g.startify_padding_left
end
local function _12_(...)
  return vim.g.startify_bookmarks
end
local _13_
if vim.g.startify_change_to_dir then
  _13_ = handle_vim_var("startify_change_to_dir", "g", true, false)
else
  _13_ = true
end
local _15_
if vim.g.startify_change_to_vcs_dir then
  _15_ = handle_vim_var("startify_change_to_vcs_dir", "g", true, false)
else
  _15_ = false
end
local function _17_(...)
  return vim.g.startify_change_cmd
end
local function _18_(...)
  return vim.g.startify_lists
end
local function _19_(...)
  return vim.g.startify_commands
end
local _20_
if vim.g.startify_update_old_files then
  _20_ = handle_vim_var("startify_update_old_files", "g", true, false)
else
  _20_ = false
end
local function _22_(...)
  return vim.g.startify_session_dir
end
local _23_
if vim.g.startify_session_autoload then
  _23_ = handle_vim_var("startify_session_autoload", "g", true, false)
else
  _23_ = false
end
local function _25_(...)
  return vim.g.startify_session_remove_lines
end
local function _26_(...)
  return vim.g.startify_session_savevars
end
local function _27_(...)
  return vim.g.startify_session_savecmds
end
local function _28_(...)
  return vim.g.startify_session_number
end
local _29_
if vim.g.startify_session_persistence then
  _29_ = handle_vim_var("startify_session_persistence", "g", true, false)
else
  _29_ = false
end
local _31_
if vim.g.startify_session_sort then
  _31_ = handle_vim_var("startify_session_sort", "g", true, false)
else
  _31_ = false
end
local function _33_(...)
  return vim.g.startify_custom_indices
end
local _34_
if vim.g.startify_custom_header then
  vim.notify("vim.g.startify_custom_header must be converted manually\nDefaulting to an empty value", vim.log.levels.WARN)
  _34_ = {""}
else
  _34_ = fortune.init()
end
local function _36_(...)
  return vim.g.startify_custom_header_quotes
end
local function _37_(...)
  return vim.g.startify_custom_footer
end
local _38_
if vim.g.startify_disable_at_vimenter then
  _38_ = handle_vim_var("startify_disable_at_vimenter", false, true)
else
  _38_ = true
end
local _40_
if vim.g.startify_use_env then
  _40_ = handle_vim_var("startify_use_env", true, false)
else
  _40_ = false
end
local function _42_(...)
  return vim.g.startify_session_before_save
end
local _43_
if vim.g.startify_session_delete_buffers then
  _43_ = handle_vim_var("startify_session_delete_buffers", "g", true, false)
else
  _43_ = true
end
local _45_
if vim.g.startify_fortune_use_unicode then
  _45_ = handle_vim_var("startify_fortune_use_unicode", "g", true, false)
else
  _45_ = false
end
default = {["files-number"] = (_2_(...) or 10), ["show-special"] = _3_, ["use-relative-path"] = _5_, transformations = (_7_(...) or {}), skiplist = _8_, ["server-skiplist"] = (_10_(...) or {}), ["left-padding"] = (_11_(...) or 3), bookmarks = (_12_(...) or {}), ["change-to-dir"] = _13_, ["change-to-vcs-root"] = _15_, ["chdir-cmd"] = (_17_(...) or "lcd"), ["display-lists"] = (_18_(...) or {{type = "files", header = "   MRU"}, {type = "dir", header = ("   MRU " .. vim.fn.getcwd())}, {type = "sessions", header = "   Sessions"}, {type = "bookmarks", header = "   Bookmarks"}, {type = "commands", header = "   Commands"}}), commands = (_19_(...) or {}), ["update-old-files"] = _20_, ["session-dir"] = (_22_(...) or (vim.fn.stdpath("data") .. "/session")), ["session-autoload"] = _23_, ["session-remove-lines"] = (_25_(...) or {}), ["session-save-vars"] = (_26_(...) or {}), ["session-save-cmds"] = (_27_(...) or {}), ["session-number"] = (_28_(...) or 999), ["session-persistence"] = _29_, ["session-sort-time"] = _31_, ["custom-index"] = (_33_(...) or {}), ["custom-header"] = _34_, ["custom-header-quote"] = (_36_(...) or {}), ["custom-footer"] = (_37_(...) or ""), ["on-vimenter"] = _38_, ["show-env"] = _40_, ["pre-session-commands"] = (_42_(...) or {}), ["del-buf-on-session"] = _43_, ["fortune-unicode"] = _45_}
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